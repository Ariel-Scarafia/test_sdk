//
//  Fiserv_QR_SDK.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 15/07/2024.
//

import Foundation

public class Fiserv_QR_SDK_MAIN {
    
    static private (set) var apiKey: String = ""
    
    static public func getAPIKey() -> String {
        return apiKey
    }
    
    static public func setAPIKey(_ apiKey: String) {
        self.apiKey = apiKey
    }
}
