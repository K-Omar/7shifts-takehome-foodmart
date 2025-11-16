//
//  Category.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-12.
//

import Foundation

struct Category: Codable, Hashable, Identifiable {
    let uuid: String
    let name: String
    var isEnabled: Bool = false 
    
    var id: String { uuid }
    
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case name 
    }
}
