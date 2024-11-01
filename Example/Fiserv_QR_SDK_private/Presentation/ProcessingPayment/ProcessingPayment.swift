//
//  ProcessingPayment.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 25/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI

struct ProcessingPayment: View {
    @EnvironmentObject private var paymentViewModel: PaymentMethodViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 15) {
                        Image(ImagesResources.processingPaymentImageName)
                            .frame(width: 128, height: 103)
                        
                        Text("Estamos procesando el pago")
                            .font(FontSettings.mainFont(weight: .semibold))
                            .padding(.horizontal)
                            .padding(.top, 5)
                        
                        Text("Aguarde unos segundos")
                            .font(FontSettings.secondaryFont(size: 10))
                    }
                    .frame(minWidth: 300, maxWidth: 330, minHeight: 400)
                    .padding(.vertical, 30)
                    .padding(.horizontal)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.white)
                    })
                    .shadow(radius: 3)
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ProcessingPayment()
        .environmentObject(PaymentMethodViewModel())
}
