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
    
    static private (set) var primaryColor = Color(red: 82/256, green: 103/256, blue: 114/256)
    
    static private (set) var textPrimary = Color(red: 82/256, green: 103/256, blue: 114/256)
    
    public static func setPrimaryColor(_ color: Color) {
        self.primaryColor = color
    }
}
