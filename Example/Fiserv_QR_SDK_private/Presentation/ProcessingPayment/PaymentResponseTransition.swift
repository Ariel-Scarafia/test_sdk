//
//  PaymentConfirmation.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 27/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI

struct PaymentResponseTransition: View {
    @State var paymentStatus: Bool
    var body: some View {
        VStack {
            Image(paymentStatus ? "icon_correctBig" : "icon_incorrectBig")
                .frame(width: 36, height: 36)
                .foregroundStyle(Color.white)
            Text(paymentStatus ? LocalizableStrings.payment_approved.localized() : LocalizableStrings.payment_rejected.localized() )
                .foregroundStyle(Color.white)
                .font(FontSettings.mainFont(size: 24, weight: .semibold))
        }.background(
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .foregroundColor( paymentStatus ? Color.green : Color.red)
        )
    }
}

#Preview {
    PaymentResponseTransition(paymentStatus: true)
        .environment(\.locale, .init(identifier: "es"))
}
