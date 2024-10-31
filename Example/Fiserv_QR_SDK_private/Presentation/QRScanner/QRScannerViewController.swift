//
//  QRScanner.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 25/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import VisionKit
import SwiftUI

class QRScannerViewController: UIViewController {
    
    let paymentOptions = [
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
    
//    let dataScannerVC = DataScannerViewController(
//        recognizedDataTypes: [.text(), .barcode()],
//        qualityLevel: .fast,
//        recognizesMultipleItems: false,
//        isHighFrameRateTrackingEnabled: false,
//        isHighlightingEnabled: true)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dataScannerVC.delegate = self
        let dataScannerView = QRScannerView()
        
        let dataScannerVC = UIHostingController(rootView: dataScannerView)
        //                self.addChildViewController(scannerViewController)
        //                view.addSubview(scannerViewController.view)
//        var scannerAvailable: Bool {
//            DataScannerViewController.isSupported &&
//            DataScannerViewController.isAvailable
//        }
        
        self.addChild(dataScannerVC)
        self.view.addSubview(dataScannerVC.view)
    
        dataScannerVC.view.frame = self.view.bounds
        
        print("**** QR Scanner ViewController")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
////        try? dataScannerVC.startScanning()
//    }
    
    private func qrFound(_ qrInfo: String) {
        
        print("**** Scanned: \(qrInfo)")
        guard
            let data = qrInfo.data(using: .utf8),
            let decoded: [PaymentMethodOption] = try? decodeData(data: data)
        else { return }
        
        var paymentRequest = CreatePaymentRequest()
        paymentRequest.paymentOptions = paymentOptions
        
        let carouselView = PaymentMethodScreen(paymentRequest: paymentRequest)
        let carouselViewCtrl = UIHostingController(rootView: carouselView)
        addChild(carouselViewCtrl)
        carouselViewCtrl.view.frame = self.view.bounds
        view.addSubview(carouselViewCtrl.view)
        carouselViewCtrl.didMove(toParent: self)
        
//        dataScannerVC.stopScanning()
//        dataScannerVC.dismiss(animated: true)
    }
}

//extension QRScannerViewController: QRScannerViewDelegate {
//    func didFoundData(_ data: String) {
//        //inspect data, maybe decode to a value
//        print("**** Data scanned is \(data)")
//        if !data.isEmpty {
//            qrFound(data)
//        }
//    }
//}

extension QRScannerViewController: DataScannerViewControllerDelegate {
    
    func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
        //TODO: show alert that the scanner doesn't work
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        let paymentOptions = [
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
        
        guard let encodedData = try? JSONEncoder().encode(paymentOptions) else { return }
        let data = String(data: encodedData, encoding: .utf8)
        qrFound(data ?? "")
    }
}
