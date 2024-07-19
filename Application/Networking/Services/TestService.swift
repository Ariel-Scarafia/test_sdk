//
//  TestService.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 19/07/2024.
//

import Foundation

protocol TestService {
    func getData() async throws -> [ResponseValue]
}
