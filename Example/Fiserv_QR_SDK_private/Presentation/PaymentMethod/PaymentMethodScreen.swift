//
//  PaymentMethodScreen.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 01/08/2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import SwiftUI

struct PaymentMethodScreen: View {
    @StateObject private var paymentMethodViewModel: PaymentMethodViewModel = .init()
    
    @SwiftUI.Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 15) {
                        Group {
                            Text("Vas a pagarle a")
//                            Text(LocalizableStrings.payment_methods_youll_pay_to.localized())
                            Text(paymentMethodViewModel.paymentRequest.descripcionEmpresa)
                        }
                        .padding(.top, 15)
                        .font(FontSettings.mainFont(size: 20, weight: .bold))
                        
                        HStack {
                            Text(paymentMethodViewModel.paymentRequest.currency)
                            TextField(
                                value: $paymentMethodViewModel.ammount,
                                format: .number
//                                    .grouping()
                                    .precision(.fractionLength(2))
                            ) {
                                Text("Ingrese el monto a pagar")
                            }
                        }
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 10) {
//                            Text(LocalizableStrings.payment_methods_select_payment_method.localized())
                            Text("Elige uno de los medios de pago")
                            PaymentMethodCarousel(
                                paymentMethods: $paymentMethodViewModel.paymentOptions
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
                    
                    DefaultButton(label: "Pagar", isEnabled: .constant(true)) {
                        paymentMethodViewModel.goToAwaitPayment()
                    }
                    .padding(.horizontal, 15)
//                    Button {
//                        paymentMethodViewModel.goToAwaitPayment()
//                    } label: {
//                          Text(LocalizableStrings.payment_methods_pay.localized())
////                        Text("Pagar")
//                            .foregroundStyle(.white)
//                            .frame(width: 328, height: 48)
//                            .background(content: {
//                                RoundedRectangle(cornerRadius: 3)
//                                    .foregroundStyle(ColorSettings.colorPrimary)
//                            })
//                    }
//                    .padding(.bottom)
//                    .padding(.top, 30)
                }
            }
            .onChange(of: paymentMethodViewModel.goToStart) {
                if paymentMethodViewModel.goToStart {
                    dismiss()
                }
            }
            .navigationDestination(isPresented: $paymentMethodViewModel.goToAwaitingPayment) {
                ProcessingPayment()
                    .environmentObject(paymentMethodViewModel)
            }
            .navigationDestination(isPresented: $paymentMethodViewModel.goToPaymentCompleted) {
                withAnimation(.easeIn(duration: 2)) {
                    PaymentConfirmation()
                        .environmentObject(paymentMethodViewModel)
                }
            }
            .onAppear() {
                paymentMethodViewModel.prepareScreen()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    PaymentMethodScreen()
        .environmentObject(PaymentMethodViewModel())
}
