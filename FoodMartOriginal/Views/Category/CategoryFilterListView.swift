//
//  CategoryFilterListView.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-15.
//

import SwiftUI

struct CategoryFilterListView: View {
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    @State private var categories = [Category]()
    
    var body: some View {
        List($foodViewModel.categories) { $category in
            Toggle(isOn: $category.isEnabled) {
                Text(category.name)
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    let viewModel = FoodViewModel()
    
    return CategoryFilterListView()
        .environmentObject(viewModel)
        .task {
            await viewModel.loadFoods()
            await viewModel.loadCategories()
        }
}
