//
//  ViewController.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel-Scarafia on 07/10/2024.
//  Copyright (c) 2024 Ariel-Scarafia. All rights reserved.
//

import UIKit
import Fiserv_QR_SDK
import SwiftUI

class ViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let carouselView = PaymentMethodCarousel(paymentMethods: paymentOptions)
//        let viewCtrl = UIHostingController(rootView: carouselView)
//        self.addChildViewController(viewCtrl)
//        view.addSubview(viewCtrl.view)
        
        var loginButton : UIButton = {
                let button = UIButton(type: .system)
                button.setTitle("Open Scanner", for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.backgroundColor = .red
                button.tintColor = .white
                return button
            }()
        
        loginButton.addTarget(self, action: #selector(requestCamera), for: .touchUpInside)
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -30),
        ])
    }

    @objc func requestCamera() {        
        Task {
            let hasPermission = await FiservQR_API.hasCameraPermission()
            if hasPermission {
                guard let encodedData = try? JSONEncoder().encode(paymentOptions) else { return }
                let data = String(data: encodedData, encoding: .utf8)
                
                FiservQR_API.setPaymentOptions(data ?? "")
//                let scannerView = FiservQR_API.getScannerView()
//                
//                let scannerViewController = UIHostingController(rootView: scannerView)
//                self.addChildViewController(scannerViewController)
//                view.addSubview(scannerViewController.view)
                
                let scannerVC = FiservQR_API.getScannerViewController()
                print("*** Received QRScanner VC from SDK")
                addChildViewController(scannerVC)
                view.addSubview(scannerVC.view)
                NSLayoutConstraint.activate([
//                    scannerView.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//                    scannerView.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    scannerVC.view.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 50),
                    scannerVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -50),
                    scannerVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 50),
                    scannerVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -50),
                ])
                scannerVC.didMove(toParentViewController: self)
                
            } else {
                showAlertMessage(title: "Permissions Required", message: "You need to grant camera access to read the QR code")
            }
            print("Camera permission: \(hasPermission)")
        }
    }
    
    func showAlertMessage(title: String, message: String) {
        
        let alertMessagePopUpBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        
        alertMessagePopUpBox.addAction(okButton)
        self.present(alertMessagePopUpBox, animated: true)
    }
}


