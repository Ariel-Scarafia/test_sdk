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
        
//        let carouselView = FiservQR_API.getPaymentCarousel()
//        let carouselViewCtrl = UIHostingController(rootView: carouselView)
//        addChildViewController(carouselViewCtrl)
//        carouselViewCtrl.view.frame = self.view.bounds
//        view.addSubview(carouselViewCtrl.view)
//        carouselViewCtrl.didMove(toParent: self)
        
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
        print("Pidió la cámara loco")
        
        Task {
            let hasPermission = await FiservQR_API.hasCameraPermission()
            print("Camera permission: \(hasPermission)")
        }
    }
}


