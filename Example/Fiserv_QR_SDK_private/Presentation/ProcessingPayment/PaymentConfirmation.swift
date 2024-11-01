//
//  PaymentConfirmation.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 01/11/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI

struct PaymentConfirmation: View {
    @EnvironmentObject private var paymentViewModel: PaymentMethodViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    VStack(spacing: 15) {                        Image(ImagesResources.processingPaymentImageName)
                            .frame(width: 128, height: 103)
                        
                        Group {
                            Text("Pagaste \(paymentViewModel.paymentRequest.currency) \(paymentViewModel.ammount ?? 0)")
                                .font(FontSettings.mainFont(size: 16, weight: .semibold))
                                .padding(.horizontal)
                                .padding(.top, 5)
                                .foregroundColor(ColorSettings.okGreen)
                            
                            Text("a \(paymentViewModel.paymentRequest.descripcionEmpresa)")
                                .font(FontSettings.mainFont(size: 16, weight: .semibold))
                                .foregroundColor(ColorSettings.okGreen)
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 330, minHeight: 540)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 15)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.white)
                    })
                    .shadow(radius: 3)
                    
                    DefaultButton(label: "Compartir comprobante", isEnabled: .constant(true))
                        .padding(.horizontal, 15)
                    
                    DefaultButton(label: "Ir a Inicio", isEnabled: .constant(true), buttonColor: ColorSettings.disabledGrey, enabledTextColor: ColorSettings.colorPrimary)
                    {
                        paymentViewModel.backToStart()
                    }
                        .padding(.horizontal, 15)
                    
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    PaymentConfirmation()
        .environmentObject(PaymentMethodViewModel())
}
