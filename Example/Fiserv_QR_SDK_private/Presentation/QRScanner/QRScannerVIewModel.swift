//
//  QRScannerVIewModel.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 26/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import AVKit

class QRScannerViewModel: NSObject, ObservableObject {
    
    @Published var scannedText: String = "" {
        didSet {
            print("**** Value: \(scannedText)")
            if !scannedText.isEmpty, let validUrl = URL(string: scannedText) {
                print("*** Valid value, proceed to paymentMethod")
                goToPaymentMethod = true
            } else {
                print("*** invalid value, continue to scan for a new QR Code")
                goToPaymentMethod = false
            }
        }
    }
    
    @Published var goToPaymentMethod: Bool = false
    
    let paymentRequest = CreatePaymentRequest(paymentOptions:
            [
                PaymentMethodOption(
                    id: 0,
                    cardName: "Visa",
                    cardHolder: "Lucas",
                    cardLogo: "card_visa_debit"
                ),
                PaymentMethodOption(
                    id: 1,
                    cardName: "Visa",
                    cardHolder: "Rodrigo",
                    cardLogo: "card_visa_debit"
                ),
                PaymentMethodOption(
                    id: 2,
                    cardName: "Visa",
                    cardHolder: "Juan",
                    cardLogo: "card_visa_debit"
                )
            ]
    )
    
    func resetViewModel() {
        goToPaymentMethod = false
        scannedText = ""
    }
}

extension QRScannerViewModel: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let scannedCode = readableObject.stringValue else { return }
            scannedText = scannedCode
        }
    }
}
