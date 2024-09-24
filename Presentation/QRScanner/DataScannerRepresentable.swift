//
//  DataScannerRepresentable.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 24/09/2024.
//

import Foundation
import SwiftUI
import BarcodeScanner

//struct DataScannerRepresentable: UIViewController, UIViewControllerRepresentable {
//    @Binding var shouldStartScanning: Bool
//    @Binding var scannedText: String
//
//    
//    class Coordinator: NSObject, DataScannerViewControllerDelegate {
//       var parent: DataScannerRepresentable
//       
//       init(_ parent: DataScannerRepresentable) {
//           self.parent = parent
//       }
//               
//        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
//            switch item {
//            case .text(let text):
//                parent.scannedText = text.transcript
//            case .barcode(let barcode):
//                parent.scannedText = barcode.payloadStringValue ?? "Unable to decode the scanned code"
//            default:
//                print("unexpected item")
//            }
//        }
//    }
//    
//    private let scannerViewController = BarcodeScannerViewController()
//
//    private func configScanner() {
//        scannerViewController.codeDelegate = self
//        scannerViewController.errorDelegate = self
//        scannerViewController.dismissalDelegate = self
//        scannerViewController.messageViewController.view.isHidden = true
//        scannerViewController.headerViewController.view.isHidden = true
//    }
//    
//    private func presentScanner() {
//        self.addChild(scannerViewController)
//        scannerViewController.view.frame = view.bounds
//        view.addSubview(scannerViewController.view)
//        scannerViewController.didMove(toParent: self)
//        scannerViewController.reset()
//    }
//    
//    func makeUIViewController(context: Context) -> DataScannerViewController {
//        let dataScannerVC = DataScannerViewController(
//            recognizedDataTypes: dataToScanFor,
//            qualityLevel: .accurate,
//            recognizesMultipleItems: true,
//            isHighFrameRateTrackingEnabled: true,
//            isPinchToZoomEnabled: true,
//            isGuidanceEnabled: true,
//            isHighlightingEnabled: true
//        )
//        
//        dataScannerVC.delegate = context.coordinator
//       
//       return dataScannerVC
//    }
//
//    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
//       if shouldStartScanning {
//           try? uiViewController.startScanning()
//       } else {
//           uiViewController.stopScanning()
//       }
//    }
//
//    func makeCoordinator() -> Coordinator {
//       Coordinator(self)
//    }
//}
