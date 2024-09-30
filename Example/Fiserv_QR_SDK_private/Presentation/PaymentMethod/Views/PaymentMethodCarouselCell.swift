//
//  PaymentMethodCarouselCell.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 02/08/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI

struct PaymentMethodCarouselCell: View {
    var width = 212.0
    var height = 96.0
    @State var paymentOption: PaymentMethodOption
    var body: some View {
        VStack {
            Image(paymentOption.cardLogo ?? "")
            Text(paymentOption.cardHolder)
                .background(Color.red)
                .bold()
                .font(.title)
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    let paymentOption = PaymentMethodOption(
        id: 0,
        cardName: "Visa",
        cardHolder: "Juan",
        cardLogo: "card_visa_debit"
    )
    return PaymentMethodCarouselCell(
        paymentOption: paymentOption
    )
}
