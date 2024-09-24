//
//  UIColor+Extension.swift
//
//  Created by Ariel Scarafia on 12/09/2022.
//

import Foundation
import UIKit

extension UIColor {
    var hex: String {
        get {
            var red:CGFloat = 0
            var blue:CGFloat = 0
            var green:CGFloat = 0
            var alpha:CGFloat = 0

            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            let rgb:Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
            return String.localizedStringWithFormat("#%06x", rgb)
        }
    }
}
