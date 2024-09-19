//
//  Fiserv_QR_SDK.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 15/07/2024.
//

import Foundation
import SwiftUI
import AVFoundation

public class Fiserv_QR_SDK_MAIN {
    
    static private (set) var apiKey: String = ""

    static private (set) var paymentOptions: [PaymentMethodOption] = [
        PaymentMethodOption(
            id: 0,
            cardName: "Visa",
            cardHolder: "Lucas"
        ),
        PaymentMethodOption(
            id: 1,
            cardName: "Visa",
            cardHolder: "Rodrigo"
        ),
        PaymentMethodOption(
            id: 2,
            cardName: "Visa",
            cardHolder: "Juan"
        )
    ]
    
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
    
    static public func hasCameraPermission() async -> Bool {
        
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        // Determine if the user previously authorized camera access.
        var isAuthorized = status == .authorized
        
        // If the system hasn't determined the user's authorization status,
        // explicitly prompt them for approval.
        if status == .notDetermined {
            isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
        }
        
        return isAuthorized
    }
}
