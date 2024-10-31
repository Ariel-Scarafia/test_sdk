//
//  Fiserv_QR_SDK_ColorSettings.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 24/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

public class ColorSettings {
        
    static private(set) var disabledButton = Color.init(red: 204/255, green: 204/255, blue: 204/255, opacity: 1)
    static private(set) var enabledButton = Color.init(red: 82/255, green: 103/255, blue: 114/255, opacity: 1)
    
    static var colorPrimary = Color.init(red: 82/255, green: 103/255, blue: 114/255, opacity: 1)
    static private(set) var colorSecondary = Color.init(red: 108/255, green: 141/255, blue: 157/255, opacity: 1)
    static private(set) var colorTertiary = Color.init(red: 208/255, green: 229/255, blue: 239/255, opacity: 1)
    
    static private(set) var darkPrimary = Color.init(red: 51/255, green: 51/255, blue: 51/255, opacity: 1)
    static private(set) var darkSecondary = Color.init(red: 114/255, green: 114/255, blue: 114/255, opacity: 1)
    static private(set) var darkTertiary = Color.init(red: 154/255, green: 154/255, blue: 154/255, opacity: 1)
    
    static private(set) var disabledGrey = Color.init(red: 204/255, green: 204/255, blue: 204/255, opacity: 1)
    static private(set) var errorRed = Color.init(red: 219/255, green: 0/255, blue: 53/255, opacity: 1)
    static private(set) var okGreen = Color.init(red: 23/255, green: 173/255, blue: 10/255, opacity: 1)
    static private(set) var blueCard = Color.init(red: 37/255, green: 43/255, blue: 147/255, opacity: 1)
    static private(set) var blueCardEnd = Color.init(red: 40/255, green: 213/255, blue: 251/255, opacity: 1)
    
    static private(set) var textPrimary = Color.init(red: 51/255, green: 51/255, blue: 51/255, opacity: 1)
    static private(set) var textSecondary = Color.init(red: 102/255, green: 102/255, blue: 102/255, opacity: 1)
    static private(set) var textTertiary = Color.init(red: 154/255, green: 154/255, blue: 154/255, opacity: 1)
    static private(set) var textRedDark = Color.init(red: 131/255, green: 20/255, blue: 10/255, opacity: 1)
    static private(set) var textRedIntense = Color.init(red: 255/255, green: 1/255, blue: 1/255, opacity: 1)
    static private(set) var textOrange = Color.init(red: 226/255, green: 88/255, blue: 34/255, opacity: 1)
    
    static private(set) var gradientStart = Color.init(red: 82/255, green: 103/255, blue: 114/255, opacity: 1)
    static private(set) var gradientEnd = Color.init(red: 208/255, green: 229/255, blue: 239/255, opacity: 1)
    static var gradientPrimary = LinearGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static var blueCardGradient = LinearGradient(colors: [blueCard, blueCardEnd], startPoint: .top, endPoint: .bottom)

    public static func setPrimaryColor(_ color: Color) {
        self.colorPrimary = color
    }
}
