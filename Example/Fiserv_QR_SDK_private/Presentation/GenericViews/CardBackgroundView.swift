//
//  CardBackgroundView.swift
//  WhiteLabelWallet_Dev
//
//  Created by Ariel Scarafia on 28/10/2024.
//

import SwiftUI

struct CardBackgroundView: View {
    var backgroundColor: Color = ColorSettings.blueCard
    var foregroundGradient: LinearGradient = ColorSettings.blueCardGradient
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                
                RoundedRectangle(cornerRadius: 3)
                    .foregroundStyle(backgroundColor)
                
                Path { path in
                    path.move(
                        to: CGPoint(
                            x: 3,
                            y: 0
                        )
                    )
                    
                    path.addLine(
                        to: CGPoint(
                            x: (width * 0.5 + height * 0.41)-3,
                            y: 0
                        )
                    )
                    path.addQuadCurve(
                        to: CGPoint(
                            x: (width * 0.5 + height * 0.41),
                            y: 3
                        ),
                        control: CGPoint(
                            x: (width * 0.5 + height * 0.41),
                            y: 0
                        )
                    )
                    
                    path.addLine(
                        to: CGPoint(
                            x: (width * 0.5 - height * 0.41)+3,
                            y: height-3
                        )
                    )
                    path.addQuadCurve(
                        to: CGPoint(
                            x: (width * 0.5 - height * 0.41)-3,
                            y: height
                        ),
                        control: CGPoint(
                            x: (width * 0.5 - height * 0.41),
                            y: height
                        )
                    )
                    
                    path.addLine(
                        to: CGPoint(
                            x: 3,
                            y: height
                        )
                    )
                    path.addQuadCurve(
                        to: CGPoint(
                            x: 0,
                            y: height-3
                        ),
                        control: CGPoint(
                            x: 0,
                            y: height
                        )
                    )
                    
                    path.addLine(
                        to: CGPoint(
                            x: 0,
                            y: 0
                        )
                    )
                    path.addQuadCurve(
                        to: CGPoint(
                            x: 0,
                            y: 3
                        ),
                        control: CGPoint(
                            x: 0,
                            y: 0
                        )
                    )
                }
                .foregroundStyle(foregroundGradient)
            }
        }
    }

}

#Preview {
    CardBackgroundView()
}
