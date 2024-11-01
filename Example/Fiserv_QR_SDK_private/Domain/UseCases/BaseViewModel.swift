//
//  BaseViewModel.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 31/10/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published public var showLoading = false
    
    internal var alertMessage: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.showAlert = self?.alertMessage.isNilOrEmpty() == false
            }
        }
    }
    @Published public var showAlert: Bool = false
    
    internal func showLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.showLoading = true
        }
    }
    
    internal func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.showLoading = false
        }
    }
    
    public func alertCleared() {
        alertMessage = nil
    }
}
