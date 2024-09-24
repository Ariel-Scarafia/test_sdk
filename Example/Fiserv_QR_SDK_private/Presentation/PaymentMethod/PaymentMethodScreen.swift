//
//  PaymentMethodScreen.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 01/08/2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import SwiftUI

struct PaymentMethodScreen: View {
    @State var paymentRequest: CreatePaymentRequest
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    Group {
                        Text(LocalizableStrings.payment_methods_youll_pay_to.localized())
                        Text(paymentRequest.descripcionEmpresa)
                    }
                        .font(FontSettings.mainFont(size: 20, weight: .bold))
                    
                    Group {
                        Text(paymentRequest.currency)
                        +
                        Text(paymentRequest.montoIngresable)
                    }
                    .padding(.top, 30)
                    
                    VStack(spacing: 10) {
                        Text(LocalizableStrings.payment_methods_select_payment_method.localized())
                        PaymentMethodCarousel(paymentMethods: paymentRequest.paymentOptions ?? [])
                            .frame(height: 143)
                    }
                    .padding(.top, 30)

                }
                .background(.white)
                .padding(.horizontal)
            }
        }
        .navigationTitle("Pagar")
        
        Button {
            
        } label: {
            Text(LocalizableStrings.payment_methods_pay.localized())
                .foregroundStyle(.white)
                .frame(width: 328, height: 48)
                .background(content: {
                    RoundedRectangle(cornerRadius: 3)
                        .backgroundStyle(ColorSettings.primaryColor)
                })
        }
    }
}

#Preview {
    PaymentMethodScreen(
        paymentRequest: CreatePaymentRequest()
    )
}
