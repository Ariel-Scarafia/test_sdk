//
//  RepositoryInjectionList.swift
//  DashPass
//
//  Created by Ariel Scarafia on 21/04/2023.
//  Copyright © 2023 Applica. All rights reserved.
//

import Foundation

private struct APIServiceKey: InjectionKey {
    typealias Value = APIProtocol
    
    static var factoryValue: APIProtocol = APIService()
    
    static var singletonValue = factoryValue
}

private struct TestRepositoryKey: InjectionKey {
    static var factoryValue: TestService {
        @SingletonInstance(\.apiServiceProvider) var apiService: APIProtocol
        
        return TestRepository(apiService: apiService)
    }
    static var singletonValue = factoryValue
}

extension DIFramework {
    var apiServiceProvider: APIProtocol {
        get { self.getInstance(APIServiceKey.self) }
    }
    
    var testRepositoryProvider: TestService {
        get { self.getInstance(TestRepositoryKey.self) }
    }
}
