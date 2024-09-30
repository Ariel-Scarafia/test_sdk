//
//  PaymentMethodViewModel.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 25/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

class PaymentMethodViewModel: ObservableObject {
    @Published var goToAwaitingPayment: Bool = false
    
    
    func goToAwaitPayment() {
        goToAwaitingPayment = true
    }
}
