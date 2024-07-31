//
//  TestRepository.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 19/07/2024.
//

import Foundation

class TestRepository: TestService {
    private let apiService: APIProtocol
    
    init(apiService: APIProtocol) {
        self.apiService = apiService
    }
    
    func getData() async throws -> [ResponseValue] {
        try await apiService.get(endpoint: APIEndpoints.getTest, query: [])
    }
}
