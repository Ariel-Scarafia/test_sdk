//
//  PaymentMethodCarousel.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 02/08/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI

struct PaymentMethodCarousel: View {
    @State var paymentMethods: [PaymentMethodOption]
    
    var body: some View {
        List {
            ForEach(paymentMethods) { paymentMethod in
                PaymentMethodCarouselCell(
                    paymentOption: paymentMethod
                )
            }
        }
    }
}

#Preview {
    PaymentMethodCarousel(
        paymentMethods: [
            PaymentMethodOption(
                id: 0,
                cardName: "Visa",
                cardHolder: "Lucas"
            ),
            PaymentMethodOption(
                id: 1,
                cardName: "Visa",
                cardHolder: "Rodrigo"
            ),
            PaymentMethodOption(
                id: 2,
                cardName: "Visa",
                cardHolder: "Juan"
            )
        ]
    )
}
