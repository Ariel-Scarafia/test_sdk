//
//  ImagesSource.swift
//  Fiserv_QR_SDK
//
//  Created by Ariel Scarafia on 30/09/2024.
//

import Foundation
import Fiserv_QR_SDK_private

public final class ImagesSourceInterface {
    
    public static func setProcessingPaymentImageName(_ imageName: String) {
        ImagesResources.setProcessingPaymentImage(imageName)
    }
    
    public static func setPaymentApprovedImage(_ imageName: String) {
        ImagesResources.setPaymentApprovedImage(imageName)
    }
    
    public static func setPaymentRejectedImage(_ imageName: String) {
        ImagesResources.setPaymentRejectedImage(paymentRejectedImageName = imageName)
    }
}
