//
//  ColorSettings.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 30/09/2024.
//

import Foundation
import SwiftUI
import Fiserv_QR_SDK_private

public final class ColorSettingsInterface {
    
    public static func setPrimaryColor(_ primaryColor: Color) {
        ColorSettings.setPrimaryColor(primaryColor)
    }
}
