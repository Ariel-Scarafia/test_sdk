//
//  Fiserv_QR_SDK.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 15/07/2024.
//

import Foundation

public final class Fiserv_QR_SDK {
    
    static private (set) var apiKey: String = ""
    
    static public func setAPIKey(_ apiKey: String) {
        self.apiKey = apiKey
    }
}
