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
    
    static let example = Category(
        uuid: "b1f6d8a5-0e29-4d70-8d4f-1f8c1d7a5b12",
        name: "Produce",
        isEnabled: false
    )
}
