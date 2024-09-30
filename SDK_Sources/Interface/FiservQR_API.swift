//
//  FiservQR_API.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 02/08/2024.
//

import Foundation
import SwiftUI
import Fiserv_QR_SDK_private

public final class FiservQR_API {
    
    static public func setPaymentOptions(_ paymentOptions: String) {
        Fiserv_QR_SDK_MAIN.setPaymentOptions(paymentOptions)
    }
    
    static public func getPaymentCarousel() -> some View {
        Fiserv_QR_SDK_MAIN.getPaymentView()
    }
    
    //The SDK checks for camera permissions. Use this before getting the scanner view
    static public func hasCameraPermission() async -> Bool {
        await Fiserv_QR_SDK_MAIN.hasCameraPermission()
    }
    
    //This returns a View for the QR Scanner. Use this for SwiftUI
    static public func getScannerView() -> some View {
        Fiserv_QR_SDK_MAIN.getScannerView()
    }
    
    //This returns a viewController with the Scanner View
    static public func getScannerViewController() -> UIViewController {
        Fiserv_QR_SDK_MAIN.getScannerViewController()
    }
}
