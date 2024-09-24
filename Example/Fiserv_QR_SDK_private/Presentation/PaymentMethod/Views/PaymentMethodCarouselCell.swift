//
//  PaymentMethodCarouselCell.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 02/08/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI

struct PaymentMethodCarouselCell: View {
    @State var paymentOption: PaymentMethodOption
    var body: some View {
        Image(paymentOption.cardLogo ?? "")
            .frame(width: 212, height: 96)
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
