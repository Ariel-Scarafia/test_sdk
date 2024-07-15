//
//  ViewController.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel-Scarafia on 07/10/2024.
//  Copyright (c) 2024 Ariel-Scarafia. All rights reserved.
//

import UIKit
import Fiserv_QR_SDK

class ViewController: UIViewController {

    var isBlinking = false

    let blinkingLabel = BlinkingLabel(frame: CGRectMake(50, 100, 200, 30))

    override func viewDidLoad() {

        super.viewDidLoad()

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

    }

    @objc func toggleBlinking() {

        if (isBlinking) {
            blinkingLabel.stopBlinking()
        } else {
            blinkingLabel.startBlinking()
        }
        isBlinking = !isBlinking
    }

}


