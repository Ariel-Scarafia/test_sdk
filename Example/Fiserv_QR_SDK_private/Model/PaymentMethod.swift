//
//  PaymentMethod.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 02/08/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

struct CreatePaymentRequest: Codable {
    var idUsuario = UserDefaults.standard.integer(forKey: "userID") 
    var cuotas = "12"
    var cvu: String = "000000505050505050421043"
    var descripcionEmpresa = "Fake Mockup Company"
    var idMedioPago: Int = 0
    var idPaymentRequest: Int = 0
    var idTipoMedioPago: Int = 0
    var currency: String = "$"
    var montoIngresable: String = "250000"
    var namePaymentMethod: String = "Tarjeta"
    var qr: String = ""
    var servicio: String = "Luz"
    var uuid = "UUID"
    var cardNumber: Int?
    var paymentOptions: [PaymentMethodOption]?
}
