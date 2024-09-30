//
//  RequiresCameraPermission.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 19/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import VisionKit

protocol QRScannerViewDelegate {
    func didFoundData(_ data: String)
}

struct QRScannerView: View {
    @EnvironmentObject var qrScannerViewModel: QRScannerViewModel
    
    @State var isShowingScanner = true
    @State private (set) var scannedText = "" {
        didSet {
            print("**** Scanned value found: \(scannedText)")
            scannerViewDelegate?.didFoundData(scannedText)
        }
    }
    
    let scannerViewDelegate: QRScannerViewDelegate?
    
    var body: some View {
        
        NavigationStack {
            Group {
                if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                    ZStack(alignment: .bottom) {
                        
                        DataScannerRepresentable(
                            shouldStartScanning: $isShowingScanner,
                            scannedText: $qrScannerViewModel.scannedText,
                            dataToScanFor: [.barcode(symbologies: [.qr])]
                        )
                        
                        Text("Código escaneado: " + qrScannerViewModel.scannedText)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                    }
                } else if !DataScannerViewController.isSupported {
                    Text("It looks like this device doesn't support the DataScannerViewController")
                } else {
                    Text("It appears your camera may not be available")
                }
            }
            .navigationDestination(isPresented: $qrScannerViewModel.goToPaymentMethod) {
                PaymentMethodScreen(paymentRequest: qrScannerViewModel.paymentRequest)
                    .environmentObject(PaymentMethodViewModel())
            }
        }
    }
        
}

#Preview {
    QRScannerView(scannerViewDelegate: nil)
}
