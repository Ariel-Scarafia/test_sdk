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

    var isBlinking = false

    let blinkingLabel = BlinkingLabel(frame: CGRectMake(50, 100, 200, 30))
    
    let squareButton = UIButton(frame: CGRect(x: 100, y: 200, width: 142, height: 134))

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

        print("View did load: SDK Example")
        // Setup the BlinkingLabel

        blinkingLabel.text = "I blink!"

        blinkingLabel.font = UIFont.systemFont(ofSize: 20)

        view.addSubview(blinkingLabel)

        blinkingLabel.startBlinking()

        isBlinking = true

        // Create a UIButton to toggle the blinking

        let toggleButton = UIButton(frame: CGRectMake(10, 60, 125, 30))

        toggleButton.setTitle("Toggle Blinking", for: .normal)

        toggleButton.setTitleColor(UIColor.red, for: .normal)

        toggleButton.addTarget(self, action: #selector(self.toggleBlinking), for: .touchUpInside)

        view.addSubview(toggleButton)

        squareButton.setTitle("Presione para la cámara", for: .normal)
        squareButton.setTitleColor(.black, for: .normal)
        squareButton.setImage(UIImage(named: "give_us_a_few_seconds"), for: .normal)
        squareButton.addTarget(self, action: #selector(self.requestCamera), for: .touchUpInside)
        
        view.addSubview(squareButton)
        
//        let carouselView = PaymentMethodCarousel(paymentMethods: paymentOptions)
//        let viewCtrl = UIHostingController(rootView: carouselView)
//        self.addChildViewController(viewCtrl)
//        view.addSubview(viewCtrl.view)
        guard let encodedData = try? JSONEncoder().encode(paymentOptions) else { return }
        let data = String(data: encodedData, encoding: .utf8)
        
        FiservQR_API.setPaymentOptions(data ?? "")
        let carouselView = FiservQR_API.getPaymentCarousel()
        let carouselViewCtrl = UIHostingController(rootView: carouselView)
        addChildViewController(carouselViewCtrl)
        carouselViewCtrl.view.frame = self.view.bounds
        view.addSubview(carouselViewCtrl.view)
        carouselViewCtrl.didMove(toParent: self)
        
    }

    @objc func toggleBlinking() {

        if (isBlinking) {
            blinkingLabel.stopBlinking()
        } else {
            blinkingLabel.startBlinking()
        }
        isBlinking = !isBlinking
    }

    @objc func requestCamera() {        
        Task {
            let hasPermission = await FiservQR_API.hasCameraPermission()
            if hasPermission {

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


