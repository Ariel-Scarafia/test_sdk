//
//  FontSettings.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 24/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

public class FontSettings {
    
    static func mainFont(size: CGFloat = 14.0, weight: Font.Weight = .regular) -> Font {
        Font.custom(mainFont, size: size)
            .weight(weight)
    }
    
    static func secondaryFont(size: CGFloat = 14.0, weight: Font.Weight = .regular) -> Font {
        Font.custom(secondaryFont, size: size)
            .weight(weight)
    }
    
    static private (set) var mainFont = "Montserrat"
    static private (set) var secondaryFont = "OpenSans"
    
    static public func setMainFont(name mainFont: String) {
        self.mainFont = mainFont
    }
    
    static public func setSecondaryFont(name secondaryFont: String) {
        self.secondaryFont = secondaryFont
    }
}
