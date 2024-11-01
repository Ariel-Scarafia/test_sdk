//
//  ButtonIngresar.swift
//  WhiteLabelWallet
//
//  Created by Ariel Scarafia on 05/08/2024.
//

import SwiftUI

struct DefaultButton: View {
    var width: CGFloat = 320
    var height: CGFloat = 47
    @State var label: String
    @Binding var isEnabled: Bool
    var buttonColor = ColorSettings.enabledButton
    var disableButtonColor = ColorSettings.disabledButton
    var enabledTextColor = Color.white
    var disabledtextColor = ColorSettings.colorSecondary
    @State var callBack: (() -> Void)?
    
    var body: some View {
        
        Button {
            guard let callBack else { return }
            callBack()
        } label: {
            Spacer()
            Text(label)
                .font(FontSettings.secondaryFont(size: 16, weight: .semibold))
                .foregroundStyle(isEnabled ? enabledTextColor : disabledtextColor)
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 3)
                .foregroundStyle(isEnabled ? buttonColor : disableButtonColor)
                .frame(height: height)
        )
        .frame(height: height)
        .disabled(!isEnabled)
    }
}

#Preview {
    @State var enabled = true
    return DefaultButton(label: "Ingresar", isEnabled: $enabled, callBack: nil)
}
