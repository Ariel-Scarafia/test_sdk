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
        Text(paymentOption.cardHolder)
    }
}

#Preview {
    PaymentMethodCarouselCell(
        paymentOption: PaymentMethodOption(
            id: 0,
            cardName: "Visa",
            cardHolder: "Juan"
        )
    )
}
