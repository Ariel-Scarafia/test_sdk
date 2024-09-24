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
    
    @State private var activeCardIndex: Int? = 0
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(paymentMethods) { paymentMethod in
                    PaymentMethodCarouselCell(
                        paymentOption: paymentMethod
                    )
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $activeCardIndex)
        .scrollIndicators(.hidden)
        pagingControl
    }
    
    var pagingControl: some View {
        HStack {
            ForEach(0..<paymentMethods.count) { index in
                Button {
                    withAnimation {
                        activeCardIndex = index
                    }
                } label: {
                    Image(systemName: activeCardIndex == index ? "circle.fill" : "circle")
                        .foregroundStyle(Color(uiColor: .systemGray3))
                }
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
    )
}
