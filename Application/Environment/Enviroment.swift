//
//  Enviroment.swift
//
//  Created by Ariel Scarafia on 15/07/2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import Foundation

enum Environment: String {
    case scheme = "SCHEME"
    case host = "HOST"
    case envAbr = "ENV_ABR"
    case releaseVersionNumber = "CFBundleShortVersionString"
    case buildVersionNumber = "CFBundleVersion"
    case API_KEY = "API_KEY"
    
    private static let infoDict: [String: Any] = {
        guard let info = Bundle(identifier: "org.cocoapods.Fiserv-QR-SDK")?.infoDictionary else {
            fatalError("Plist file not found")
        }
        return info
    }()
    
    var value: String {
        if self == .API_KEY {
            return Fiserv_QR_SDK.apiKey
        }
        return Environment.infoDict[rawValue] as? String ?? ""

    }
    
    static let appVersion = "\(Environment.releaseVersionNumber.value) (\(Environment.buildVersionNumber.value)) \(Environment.envAbr.value)"
}
