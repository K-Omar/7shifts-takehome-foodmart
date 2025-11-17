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
    
    enum LoadState {
        case loading, loaded, failed
    }
    
    @Published var loadState: LoadState = .loading
    @Published var loadError: (any Error)?
    
    @Published var categories = [Category]()
    @Published var foods = [Food]()
    
    /// The array of foods that matches the user's category filters, or all foods
    /// if no category filter is enabled.
    var filteredFoods: [Food] {
        let enabledCategoryUuids = Set(categories.filter(\.isEnabled).map(\.uuid))
        
        return enabledCategoryUuids.isEmpty ? foods : foods.filter { enabledCategoryUuids.contains($0.categoryUuid) }
    }
    
    private var urlSession: any DataFetching
    
    init(session: any DataFetching = URLSession.shared) {
        self.urlSession = session
    }
    
    func loadAppData() async {
        loadState = .loading
        
        do {
            async let foodsData = loadFoods()
            async let categoriesData = loadCategories()
            
            let (foods, categories) = try await (foodsData, categoriesData)
            
            self.foods = foods
            self.categories = categories
            
            loadState = .loaded
        } catch {
            loadState = .failed
            loadError = error
        }
    }
    
    func category(for food: Food) -> String {
        let category = categories.first(where: { $0.uuid == food.categoryUuid })
        return category?.name ?? ""
    }
    
    private func loadFoods() async throws -> [Food] {
        let url = URL(string: "https://7shifts.github.io/mobile-takehome/api/food_items.json")!
        let (data, _) = try await urlSession.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Food].self, from: data)
    }
    
    private func loadCategories() async throws -> [Category] {
        let url = URL(string: "https://7shifts.github.io/mobile-takehome/api/food_item_categories.json")!
        let (data, _) = try await urlSession.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Category].self, from: data)
    }
}
