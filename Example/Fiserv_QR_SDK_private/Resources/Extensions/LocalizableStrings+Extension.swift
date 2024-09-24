//
//  LocalizableStrings+Extension.swift
//  WhiteLabelWallet
//
//  Created by Ariel Scarafia on 26/07/2024.
//

import Foundation
import UIKit

extension LocalizableStrings {
    public func localized() -> String {
        return self.rawValue.localized()
    }
    
    public func localized(params: [String]) -> String {
        return self.rawValue.localized(params: params)
    }
    
    public func formatted(
        desiredFont: UIFont? = nil,
        desiredColor: UIColor? = nil,
        desiredAlignment: NSTextAlignment? = nil,
        arguments: [String] = []
    ) -> NSAttributedString {
        return self.rawValue.formatted(desiredFont: desiredFont, desiredColor: desiredColor, desiredAlignment: desiredAlignment, arguments: arguments)
    }
    
    public func formatted(
        desiredFont: UIFont? = nil,
        desiredColor: UIColor? = nil,
        desiredAlignment: NSTextAlignment? = nil,
        arguments: [String] = []
    ) -> AttributedString {
        return self.rawValue.formatted(desiredFont: desiredFont, desiredColor: desiredColor, desiredAlignment: desiredAlignment, arguments: arguments)
    }
}
