//
//  CardInfo.swift
//  WhiteLabelWallet_Dev
//
//  Created by Ariel Scarafia on 28/10/2024.
//

import SwiftUI

struct CardView: View {
    var width: CGFloat = 128
    var height: CGFloat = 61
    
    var typeOfCard: String
    var cardHolder: String
    var cardLogo: String
    var cardNumber: String
    
    var cardBackgroundColor: Color = ColorSettings.blueCard
    var cardGradientColor: LinearGradient = ColorSettings.blueCardGradient
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(typeOfCard)
                    .font(FontSettings.secondaryFont(size: 6, weight: .semibold))
                Text(cardHolder)
                    .font(FontSettings.secondaryFont(size: 8))
                Text(cardNumber)
                    .font(FontSettings.secondaryFont(size: 8))
            }
            .padding(.vertical, 10)
            .padding(.leading, 10)
            .foregroundColor(.white)
            .frame(width: width, height: height, alignment: .leading)
            
            HStack {
                Spacer()
                
                Image(cardLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 42, height: height, alignment: .top)
                    .padding(.trailing, 10)
                    .padding(.top, 20)
                    
            }
        }
        .frame(width: width, height: height)
        .background(
            CardBackgroundView(
                backgroundColor: cardBackgroundColor,
                foregroundGradient: cardGradientColor
            )
        )
    }
}

#Preview {
    CardView(typeOfCard: "CRÉDITO", cardHolder: "Sofía Falcón", cardLogo: "icon_VISA", cardNumber: "2009 XXXX XXXX XXXX")
}
