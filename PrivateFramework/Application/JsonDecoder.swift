//
//  JsonDecoder.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 02/08/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

func decodeData<T: Codable>(data: Data) throws -> T {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.iso8601Full)
    return try decoder.decode(T.self, from: data)
}
