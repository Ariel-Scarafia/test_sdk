//
//  Enviroment.swift
//  DashPass
//
//  Created by z on 23/08/2022.
//  Copyright © 2022 Applica. All rights reserved.
//

import Foundation

public enum Environment: String {
    case scheme = "SCHEME"
    case host = "HOST"
    case envAbr = "ENV_ABR"
    case releaseVersionNumber = "CFBundleShortVersionString"
    case buildVersionNumber = "CFBundleVersion"
    
    private static let infoDict: [String: Any] = {
        guard let info = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return info
    }()
    
    var value: String {
        return Environment.infoDict[rawValue] as? String ?? ""
    }
    
    static let appVersion = "\(Environment.releaseVersionNumber.value) (\(Environment.buildVersionNumber.value)) \(Environment.envAbr.value)"
}
