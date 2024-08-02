//
//  PaymentMethodOption.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 02/08/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

class PaymentMethodOption: Codable, Identifiable {
    var id: Int
    var cardName: String = ""
    var cardHolder: String = ""
    var active: Bool = false
    var typePaymentMethodId: Int = 0
    var numberCard: Int = 0
    var numberCardComplete: String = ""
    var fictitiousMethod: Bool = false
    var propio: Bool = false
    var expirationDate: String = ""
    var currentEmail: String = ""
        
    init(id: Int, cardName: String, cardHolder: String) {
        self.id = id
        self.cardName = cardName
        self.cardHolder = cardHolder
    }
    
    func getExpirationMonth() -> String {
        let mes = self.expirationDate.prefix(2)
        return String(mes)
    }
    
    func getExpirationYear() -> String {
        let año = self.expirationDate.suffix(2)
        return String(año)
    }
    
    func getNumberCardString() -> String {
        return String(numberCard).count == 3 ? "0\(numberCard)" : "\(numberCard)"
    }
    
    func hasDataForMakePayment() -> Bool {
        return expirationDate != "" && numberCardComplete != ""
    }
    
    func isDebitOrCreditCard() -> Bool {
        let id = self.typePaymentMethodId
        return id != 99 && id != 31 && id != 41 && id != 40
    }
    
    func isCajaPlus() -> Bool {
        return typePaymentMethodId == 40
    }
    
//    func getMpImage() -> UIImage {
//        guard let card = Card(rawValue: self.typePaymentMethodId) else { return UIImage() }
//        return card.mpImage
//    }
//    
//    func getImage() -> UIImage {
//        guard let card = Card(rawValue: self.typePaymentMethodId) else { return UIImage() }
//        return card.brandImage
//    }
//    
//    func getImageLogo() -> UIImage {
//        guard let card = Card(rawValue: self.typePaymentMethodId) else { return UIImage() }
//        return card.logoImage
//    }
//    
}

