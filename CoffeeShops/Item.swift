//
//  Item.swift
//  CoffeeShops
//
//  Created by Luke Rohrer on 9/21/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
