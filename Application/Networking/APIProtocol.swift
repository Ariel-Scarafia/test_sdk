//
//  APIProtocol.swift
//
//  Created by Ariel Scarafia on 21/04/2023.
//  Copyright © 2023 Applica. All rights reserved.
//

import Foundation

protocol APIProtocol {
    func get<T: Codable>(endpoint: String, query: [URLQueryItem]) async throws -> T
    
    func post<T: Codable>(endpoint: String, query: [URLQueryItem], requestData: Codable?) async throws -> T
    
    func put<T: Codable>(endpoint: String, query: [URLQueryItem], requestData: Codable?) async throws -> T
    
    func delete<T: Codable>(endpoint: String, query: [URLQueryItem]) async throws -> T?
    
}
