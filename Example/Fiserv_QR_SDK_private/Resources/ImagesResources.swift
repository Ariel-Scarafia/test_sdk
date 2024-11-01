//
//  ImagesSource.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 30/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

public final class ImagesResources {
    
    static private (set) var processingPaymentImageName: String = "wallet_animation"
 
    static private (set) var paymentApprovedImageName: String = "icon_approved_big"
    
    static private (set) var paymentRejectedImageName: String = "icon_rejected_big"
    
    public static func setProcessingPaymentImage(_ imageName: String) {
        processingPaymentImageName = imageName
    }
    
    public static func setPaymentApprovedImage(_ imageName: String) {
        paymentApprovedImageName = imageName
    }
    
    public static func setPaymentRejectedImage(_ imageName: String) {
        paymentRejectedImageName = imageName
    }
}
