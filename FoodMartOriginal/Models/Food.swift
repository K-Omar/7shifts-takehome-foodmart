//
//  Food.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-12.
//

import Foundation

struct Food: Codable, Hashable, Identifiable {
    let uuid: String
    let categoryUuid: String
    var name: String
    var price: Double
    let imageUrl: String
    
    var id: String { uuid }
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case price
        case categoryUuid = "category_uuid"
        case imageUrl = "image_url"
    }
    
    static let example = Food(
        uuid: "e9f2c6d5-4b3e-41a7-8c4d-5e9f7a2b4a09",
        categoryUuid: "b1f6d8a5-0e29-4d70-8d4f-1f8c1d7a5b12",
        name: "Apple",
        price: 0.99,
        imageUrl: "https://7shifts.github.io/mobile-takehome/images/apple.png"
    )
}
