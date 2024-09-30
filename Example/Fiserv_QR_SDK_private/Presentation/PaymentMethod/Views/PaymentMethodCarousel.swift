//
//  PaymentMethodCarousel.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 02/08/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI

struct PaymentMethodCarousel: View {
    var screenWidth: CGFloat = UIScreen.main.bounds.width
//    var frameHeight: CGFloat = 143
    var paymentMethods: [PaymentMethodOption]
    
    @State private var activeCardIndex: Int? = 0
    @State private var itemsArray: [[PaymentMethodOption]] = []
    
    private let cellWidth: CGFloat = 212
    private let cellHeight: CGFloat = 96
    private let animationDuration: CGFloat = 0.3
    private let animation: Animation = .default
    
    var body: some View {        
        let widthDifference = screenWidth - cellWidth
        let itemsTemp = itemsArray.flatMap { $0.map { $0 } }
        VStack (spacing: 15) {
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(0..<itemsTemp.count, id: \.self) { index in
                        let item = itemsTemp[index]
                        VStack {
                            PaymentMethodCarouselCell(
                                width: cellWidth,
                                height: cellHeight,
                                paymentOption: item
                            )
                            .background(Color.blue)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: cellHeight)
            .contentMargins(widthDifference/2, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeCardIndex, anchor: .center)
            .scrollIndicators(.hidden)
            .onAppear {
                self.itemsArray = [paymentMethods, paymentMethods, paymentMethods]
                // start at the first item of the second colors array
                activeCardIndex = itemsArray.count
            }
            .onChange(of: activeCardIndex) {
                guard let scrollPosition = activeCardIndex else {return}
                
                let itemCount = paymentMethods.count
                // last item of the first colors Array
                if scrollPosition / itemCount == 0 && scrollPosition % itemCount == itemCount - 1  {
                    // append colors array before the first and remove the curren last color array
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        itemsArray.removeLast()
                        itemsArray.insert(paymentMethods, at: 0)
                        self.activeCardIndex = scrollPosition + paymentMethods.count
                    }
                    return
                }
                
                // first item of the last colors Array
                if scrollPosition / itemCount == 2 && scrollPosition % itemCount == 0  {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        itemsArray.removeFirst()
                        itemsArray.append(paymentMethods)
                        self.activeCardIndex = scrollPosition - paymentMethods.count
                    }
                    
                    return
                }
            }
            
            pagingControl
        }
    }
    
    var pagingControl: some View {
        HStack {
            ForEach(0..<paymentMethods.count, id: \.self) { index in
                Button {
                    withAnimation(animation) {
                        activeCardIndex = index + paymentMethods.count
                    }
                } label: {
                    Image(systemName: (index == (activeCardIndex ?? 0) % paymentMethods.count) ? "circle.fill" : "circle")
                        .foregroundStyle(Color(uiColor: .systemGray3))
                        .frame(width: 15)
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
