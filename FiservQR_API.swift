//
//  FiservQR_API.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 02/08/2024.
//

import Foundation
import Fiserv_QR_SDK_private

public final class FiservQR_API {
    
    static public func setPaymentOptions(_ paymentOptions: String) {
        Fiserv_QR_SDK_MAIN.setPaymentOptions(paymentOptions)
    }
    
    static public func getPaymentCarousel() -> Any View {
        Fiserv_QR_SDK_MAIN.getPaymentView()
    }
}
