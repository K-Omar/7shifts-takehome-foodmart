//
//  FoodViewModel.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-15.
//

import Combine
import Foundation

@MainActor
class FoodViewModel: ObservableObject {
    @Published var categories = [Category]()
    @Published var foods = [Food]()
    
    var filteredFoods: [Food] {
        let enabledCategoryUuids = Set(categories.filter(\.isEnabled).map(\.uuid))
        
        return enabledCategoryUuids.isEmpty ? foods : foods.filter { enabledCategoryUuids.contains($0.categoryUuid) }
    }
    
    func loadFoods() async {
        do {
            let url = URL(string: "https://7shifts.github.io/mobile-takehome/api/food_items.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            foods = try decoder.decode([Food].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func loadCategories() async {
        do {
            let url = URL(string: "https://7shifts.github.io/mobile-takehome/api/food_item_categories.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            categories = try decoder.decode([Category].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func category(for food: Food) -> String {
        print(categories.count)
        let category = categories.first(where: { $0.uuid == food.categoryUuid })
        
        print(category)
        
        return category?.name ?? ""
    }
}
