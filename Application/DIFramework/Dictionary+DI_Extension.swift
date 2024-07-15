//
//  Dictionary+DI_Extension.swift
//
//  Created by Ariel Scarafia on 11/04/2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /**
     An extension that add the elements of one dictionary to another
     */
    public mutating func add(_ dictionary: [Key : Value]) {
        for (key, value) in dictionary {
            self[key] = value
        }
    }
}
