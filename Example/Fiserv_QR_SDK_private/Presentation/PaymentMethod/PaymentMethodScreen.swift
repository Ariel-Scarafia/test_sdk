//
//  PaymentMethodScreen.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 01/08/2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import SwiftUI

struct PaymentMethodScreen: View {
    @State var paymentMethod: CreatePaymentRequest
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text(paymentMethod.descripcionEmpresa)
                        .font(.headline)
                    Text("CVU: \(paymentMethod.cvu)")
                        .font(.subheadline)
                        .grayscale(0.40)
                    Spacer()
                    Text("$\(paymentMethod.montoIngresable)")
                        .font(.largeTitle)
                        .bold()
                        
                    Text("Elegí uno de los medios de pago que acepta éste servicio")
                        .multilineTextAlignment(.center)
                }
            }
        }
        .navigationTitle("Pagar")
    }
}

#Preview {
    PaymentMethodScreen(
        paymentMethod: CreatePaymentRequest()
    )
}
