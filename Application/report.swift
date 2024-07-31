//
//  report.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 31/07/2024.
//

import Foundation

class Report {
    @SharedInstance(\.testRepositoryProvider) private var testRepository: TestService
    
    func getResponse() {
        Task {
            do {
                let response = try await testRepository.getData()
                print("**** Data is: \(response.first)")
            } catch {
                print("There was an error: \(error)")
            }
        }
    }
}
