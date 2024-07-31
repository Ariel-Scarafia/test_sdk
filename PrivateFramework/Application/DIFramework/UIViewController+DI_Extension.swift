//
//  UIViewController+DI_Extension.swift
//
//  Created by Ariel Scarafia on 11/04/2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func vcContainsInjectedType(_ injectedType: String) -> Bool {
        let mirror = Mirror(reflecting: self)
                
        for child in mirror.children {
            let childDescription = String(describing: child.value)
            if childDescription.contains("SharedInstance") && childDescription.contains(injectedType) {
                return true
            }
        }
        return false
    }
    
    func removeFromParentContainer() {
        self.willMove(toParent: nil)
        //self.view.removeConstraints(self.view.constraints)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func addToContainer(_ container: UIViewController) {
        container.addChild(self)
        self.didMove(toParent: container)
    }
}
