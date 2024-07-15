//
//  IOError.swift
//
//  Created by Ariel Scarafia on 21/04/2023.
//  Copyright © 2023 Applica. All rights reserved.
//

import Foundation

enum IOError: Error {
    case invalidURL(String)
    case invalidParameter(String, Any)
    case invalidJSON(String)
    case invalidDecoderConfiguration
    case responseError
    case responseErrorCode(Int)
    case nilValueResponse
}
