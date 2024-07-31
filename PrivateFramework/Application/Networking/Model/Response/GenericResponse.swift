//
//  GenericResponse.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 19/07/2024.
//

import Foundation

struct GenericResponse {
    
}

struct ResponseValue: Codable {
    let id: String?
    let createdAt: String?
    let name: String?
    let avatar: String?
}
