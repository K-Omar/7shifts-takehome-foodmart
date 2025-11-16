//
//  FoodItemListView.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-15.
//

import SwiftUI

struct FoodItemListView: View {
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    @State private var foods = [Food]()
    
    let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16),
        ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(foodViewModel.filteredFoods) { food in
                FoodItemView(food: food)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @StateObject var viewModel = FoodViewModel()
    
    ScrollView {
        FoodItemListView()
            .task {
                await viewModel.loadFoods()
                await viewModel.loadCategories()
            }
    }
    .environmentObject(viewModel)
}
