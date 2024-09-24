//
//  RequiresCameraPermission.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 19/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import BarcodeScanner

struct RequiresCameraPermission: View {
    @SwiftUI.Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Text("Close the camera")
            }

        }
    }
}

#Preview {
    RequiresCameraPermission()
}
