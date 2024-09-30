//
//  PaymentMethodScreen.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 01/08/2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import SwiftUI

struct PaymentMethodScreen: View {
    @EnvironmentObject private var paymentMethodViewModel: PaymentMethodViewModel
    @State var paymentRequest: CreatePaymentRequest
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 15) {
                        Group {
//                            Text("Vas a pagarle a")
                            Text(LocalizableStrings.payment_methods_youll_pay_to.localized())
                            Text(paymentRequest.descripcionEmpresa)
                        }
                        .padding(.top, 15)
                        .font(FontSettings.mainFont(size: 20, weight: .bold))
                        
                        Group {
                            Text(paymentRequest.currency)
                            +
                            Text(paymentRequest.montoIngresable)
                        }
                        .padding(.top, 30)
                        
                        VStack(spacing: 10) {
                            Text(LocalizableStrings.payment_methods_select_payment_method.localized())
//                            Text("Elige uno de los medios de pago")
                            PaymentMethodCarousel(
                                paymentMethods: paymentRequest.paymentOptions ?? []
                            )
                            .frame(height: 143)
                        }
                        .padding(.vertical, 30)
//                        .padding(.bottom, 15)
                    }
                    .background(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.white)
                    })
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                    Button {
                        paymentMethodViewModel.goToAwaitPayment()
                    } label: {
                          Text(LocalizableStrings.payment_methods_pay.localized())
//                        Text("Pagar")
                            .foregroundStyle(.white)
                            .frame(width: 328, height: 48)
                            .background(content: {
                                RoundedRectangle(cornerRadius: 3)
                                    .foregroundStyle(ColorSettings.colorPrimary)
                            })
                    }
                    .padding(.bottom)
                    .padding(.top, 30)
                }
            }
            .navigationDestination(isPresented: $paymentMethodViewModel.goToAwaitingPayment) {
                ProcessingPayment()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let paymentOptions = [
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
    
    var paymentRequest = CreatePaymentRequest()
    paymentRequest.paymentOptions = paymentOptions
    return PaymentMethodScreen(
        paymentRequest: paymentRequest
    )
    .environmentObject(PaymentMethodViewModel())
}
