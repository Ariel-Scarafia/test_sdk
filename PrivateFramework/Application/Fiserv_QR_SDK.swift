//
//  Fiserv_QR_SDK.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 15/07/2024.
//

import Foundation
import SwiftUI

public class Fiserv_QR_SDK_MAIN {
    
    static private (set) var apiKey: String = ""
    
    static private (set) var paymentOptions: [PaymentMethodOption] = []
    
    static public func getAPIKey() -> String {
        return apiKey
    }
    
    static public func setAPIKey(_ apiKey: String) {
        self.apiKey = apiKey
    }
    
    static public func setPaymentOptions(_ paymentOptions: String) {
        guard
            let data = paymentOptions.data(using: .utf8),
            let decoded: [PaymentMethodOption] = try? decodeData(data: data)
        else { return }
        
        self.paymentOptions = decoded
    }
    
    static public func getPaymentView() -> some View {
        PaymentMethodCarousel(paymentMethods: paymentOptions)
    }
}
