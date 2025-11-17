//
//  FoodItemListView.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-15.
//

import SwiftUI

struct FoodItemListView: View {
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(foodViewModel.filteredFoods) { food in
                    FoodItemView(food: food)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = FoodViewModel()
    
    FoodItemListView()
        .environmentObject(viewModel)
        .task(viewModel.loadAppData)
}
