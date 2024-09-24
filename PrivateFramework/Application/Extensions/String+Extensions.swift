//
//  String+Extensions.swift
//  DashPass
//
//  Created by Ariel Scarafia on 22/02/2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func stringByReplacingFirstOccurrenceOfString(target: String, withString replaceString: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    public func localized() -> String {
        let value = NSLocalizedString(self, comment: "")
        
        let defaultLanguage = "es-LA"
        
        if value != self || NSLocale.preferredLanguages.first == defaultLanguage {
            // return localized string
            return value
        }

         // Load resource for default language to be used as fall back
        guard let path = Bundle.main.path(forResource: defaultLanguage, ofType: "lproj"), let bundle = Bundle(path: path) else {
            return value
        }
        
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
    
    public func localized(params: [String]) -> String {
        var text = self.localized()
        for p in params {
            text = text.stringByReplacingFirstOccurrenceOfString(target: "%@", withString: p)
        }
        return text
    }
    
    func formatted(
        desiredFont: UIFont? = nil,
        desiredColor: UIColor? = nil,
        desiredAlignment: NSTextAlignment? = nil,
        arguments: [String] = []
    ) -> NSAttributedString {
        let font = desiredFont ?? UIFont.preferredFont(forTextStyle: .body)
        let color = desiredColor ?? UIColor.black
        let alignment = desiredAlignment ?? NSTextAlignment.init(.left)
        return getFormattedHTMLString(key: self, desiredFont: font, desiredColor: color, desiredAlignment: alignment, arguments: arguments)
    }
    
    func formatted(
        desiredFont: UIFont? = nil,
        desiredColor: UIColor? = nil,
        desiredAlignment: NSTextAlignment? = nil,
        arguments: [String] = []
    ) -> AttributedString {
        let nsAttributedString: NSAttributedString = self.formatted(desiredFont: desiredFont, desiredColor: desiredColor, desiredAlignment: desiredAlignment, arguments: arguments)
        guard let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) else {
            var attributes = AttributeContainer()
            attributes.font = desiredFont
            attributes.foregroundColor = desiredColor
            return AttributedString(self.localized(params: arguments), attributes: attributes)
        }
        
        return attributedString
    }
    
    private func getFormattedHTMLString(
        key: String,
        desiredFont: UIFont,
        desiredColor: UIColor,
        desiredAlignment: NSTextAlignment,
        arguments: [String]
    ) -> NSAttributedString {
        var sourceString = ""
        if (arguments.isEmpty) {
            sourceString = key.localized()
        } else {
            sourceString = key.localized(params: arguments)
        }
        
        let modifiedFont = String(format:"<span style=\"font-family: '\(desiredFont.fontName)'; font-size: \(desiredFont.pointSize); color:\(desiredColor.hex)\">%@</span>", sourceString)
        let data = modifiedFont.data(using: String.Encoding.unicode, allowLossyConversion: true)
        
        if let attributedString = try? NSMutableAttributedString(
            data: data ?? Data(),
            options: [ .documentType: NSAttributedString.DocumentType.html ],
            documentAttributes: nil) {
            
            let attributeRange = NSRange(location: 0, length: attributedString.length)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = desiredAlignment
            
            attributedString.addAttributes([.paragraphStyle: paragraphStyle], range: attributeRange)
            
            return attributedString as NSAttributedString
        } else {
            return NSAttributedString(string: "")
        }
    }
}

extension String? {
    func orEmpty() -> String {
        return self ?? ""
    }
    
    func isNilOrEmpty() -> Bool {
        return (self == nil || self == "")
    }
}
