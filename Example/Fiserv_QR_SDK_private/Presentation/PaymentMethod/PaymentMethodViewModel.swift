//
//  PaymentMethodViewModel.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 25/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

class PaymentMethodViewModel: BaseViewModel {
    @Published var goToStart: Bool = false
    @Published var goToAwaitingPayment: Bool = false
    @Published var goToPaymentCompleted: Bool = false
    
    @Published var ammount: Int?
    
    @Published var paymentRequest: CreatePaymentRequest = CreatePaymentRequest()
    
    @Published var paymentOptions = [
        PaymentMethodOption(
            id: 0,
            cardName: "Visa",
            cardHolder: "Lucas",
            cardLogo: "card_visa_debit"
        ),
        PaymentMethodOption(
            id: 1,
            cardName: "Visa",
            cardHolder: "Rodrigo",
            cardLogo: "card_visa_debit"
        ),
        PaymentMethodOption(
            id: 2,
            cardName: "Visa",
            cardHolder: "Juan",
            cardLogo: "card_visa_debit"
        )
    ]
    
    private var timer: Timer?
    
    func prepareScreen() {
        ammount = Int(paymentRequest.montoIngresable)
        paymentRequest.paymentOptions = paymentOptions
    }
    
    func goToAwaitPayment() {
        goToAwaitingPayment = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.goToPaymentCompleted = true
            self?.goToAwaitingPayment = false
            self?.hideLoader()
        }
    }
    
    func backToStart() {
        goToStart = true
    }
    
    private func processPayment() {
        showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.goToPaymentCompleted = true
            self?.goToAwaitingPayment = false
            self?.hideLoader()
        }
    }
}
