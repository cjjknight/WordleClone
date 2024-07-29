//
//  Item.swift
//  WordleClone
//
//  Created by Christopher Johnson on 7/14/24.
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
