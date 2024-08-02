//
//  APIService.swift
//
//  Created by Ariel Scarafia on 21/04/2023.
//  Copyright © 2023 Applica. All rights reserved.
//

import Foundation
import UIKit

class APIService: APIProtocol {
       
    enum RequestType: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }
    
    private func headerInterceptor(request: URLRequest) -> URLRequest {
        var request = request

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let versionLabel = Environment.releaseVersionNumber.value
        request.addValue(String("IOS"), forHTTPHeaderField: "Mobile-App-Platform")
        request.addValue(String(versionLabel), forHTTPHeaderField: "Mobile-App-Version")
        
        //added lenguages
        let lang = getLanguageISO()
        request.addValue(String(lang), forHTTPHeaderField: "Accept-Language")
        
        if let token = tokenFromDefaults() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let uuid = UIDevice.current.identifierForVendor?.uuidString{
            request.setValue(uuid, forHTTPHeaderField: "HWID")
        }
        
        return request
    }
    
    private func getLanguageISO() -> String {
        let locale = Locale.current //Locale.preferredLanguages.first?.prefix(5) {
        guard let languageCode = locale.languageCode,
              let regionCode = locale.regionCode else {
            return "es_AR"
        }
        return languageCode + "_" + regionCode
    }
    
    private func tokenFromDefaults() -> String? {
        //TODO: Where will the token be stored?
//        if let accessToken = UserDefaultsManager.getUserToken() {
//            return accessToken
//        }
        return nil
    }
    
    private func callEnpoint(path: String, method: RequestType, query: [URLQueryItem], requestData: Codable? = nil) async throws -> (Data, URLResponse) {
        
        guard let finalURL = parseUrl(path: path, query: query) else {
            throw IOError.invalidURL(path)
        }
        
        let urlRequest = URLRequest(url: finalURL)
        
        var request = headerInterceptor(request: urlRequest)
        request.httpMethod = method.rawValue
        
        if method != .get && method != .delete {
            request.httpBody = requestData?.toJSONData()
        }
        
        let urlSession = getURLSession()
        
        return try await urlSession.data(for: request)
    }
    
    private func getURLSession() -> URLSession {
        let tenSeconds = 10.0
        let fifteenSeconds = 15.0
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = tenSeconds
        sessionConfig.timeoutIntervalForResource = fifteenSeconds
        return URLSession(configuration: sessionConfig)
    }
    
    private func parseUrl(path: String, query: [URLQueryItem])  -> URL? {
        var urlComponents = URLComponents()
        
        if path.starts(with: "http") {
            urlComponents = URLComponents(string: path) ?? URLComponents()
        } else {
            urlComponents.scheme = APIEndpoints.scheme
            urlComponents.host = APIEndpoints.host
            urlComponents.path = path
        }
        
        if !query.isEmpty {
            urlComponents.queryItems = query
        }
       
        return urlComponents.url
    }

    func get<T: Codable>(endpoint: String, query: [URLQueryItem] = []) async throws -> T {
        let (data, response) = try await callEnpoint(path: endpoint, method: .get, query: query)
        
        try validateResponse(response: response)
        
        return try decodeData(data: data)
    }
    
    func post<T: Codable>(endpoint: String, query: [URLQueryItem] = [], requestData: Codable?) async throws -> T {
        let (data, response) = try await callEnpoint(path: endpoint, method: .post, query: query, requestData: requestData)
        
        try validateResponse(response: response)
        
        return try decodeData(data: data)
    }
    
    func put<T: Codable>(endpoint: String, query: [URLQueryItem] = [], requestData: Codable?) async throws -> T {
        let (data, response) = try await callEnpoint(path: endpoint, method: .put, query: query, requestData: requestData)
        
        try validateResponse(response: response)
        
        return try decodeData(data: data)
    }
    
    func delete<T: Codable>(endpoint: String, query: [URLQueryItem] = []) async throws -> T? {
        let (data, response) = try await callEnpoint(path: endpoint, method: .delete, query: query)
        
        try validateResponse(response: response)
        
        return try decodeData(data: data)
    }
    
    private func validateResponse(response: URLResponse) throws -> Void {
        guard let response = response as? HTTPURLResponse, !responseContainsErrorCode(response: response) else {
            let response = response as? HTTPURLResponse
            processResponseErrorCode(response: response)
            throw IOError.responseErrorCode(response?.statusCode ?? 0)
        }
    }
    
    private func reportNullData(response: HTTPURLResponse) {
        //TODO: is this needed?
        var errorParams = ["server_error_url": response.url?.absoluteString]
//        errorParams[MixpanelConstants.server_error] = response.description
        //Tracker.shared.sendCustomEvent(withName: MixpanelConstants.server_error, customAttributes: errorParams as [String : Any])
    }
    
    private func responseContainsErrorCode(response: HTTPURLResponse) -> Bool {
        return response.statusCode > 299
    }
    
    private func processResponseErrorCode(response: HTTPURLResponse?) {
        switch(response?.statusCode) {
        case 400:
            // If current version is below than minimun required, backend will throw 400
//            reportForceUpdateToMixpanel()
//            goToNewVersionScreen()
            break;
        case 500:
            reportErrorToMixpanel(response)
            break;
        case 401:
            reportErrorToMixpanel(response)
            signOut()
            break;
        default:
            break;
        }
    }
    
    private func reportErrorToMixpanel(_ response: HTTPURLResponse?) {
//        var errorParams = ["server_error_url": response?.url?.absoluteString]
//        errorParams[MixpanelConstants.server_error] = response?.description
//        Tracker.shared.sendCustomEvent(withName: MixpanelConstants.server_error, customAttributes: errorParams as [String : Any])
    }
    
    private func reportForceUpdateToMixpanel() {
//        Tracker.shared.sendCustomEvent(withName: MixpanelConstants.show_force_update_screen)
    }
        
    private func signOut() {
        //TODO: signOut???
//        DispatchQueue.main.async {
//            let appDelegate = UIApplication.shared.delegate as? AppDelegate
//            UserDefaultsManager.setUserToken(nil)
//            UserDefaults.standard.synchronize()
//            UserDefaultsManager.setNoFirstTimeGeofence(false)
//            
//            appDelegate?.signOut() { success in
//                LocationHandler.shareInstance.locationActive = false
//                Realm.instance.safeDeleteAllData()
//            }
//        }
    }
}
