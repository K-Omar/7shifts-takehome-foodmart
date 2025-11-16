//
//  FoodItemView.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-15.
//

import SwiftUI

struct FoodItemView: View {
    @EnvironmentObject var foodViewModel: FoodViewModel
    var food: Food
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: food.imageUrl)!) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                }
            }
            .clipShape(.rect(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(food.price, format: .currency(code: "USD").presentation(.narrow))
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text(food.name)
                    .font(.headline)
                    .fontWeight(.medium)
                
                    //TODO: Add proper category here
                Text(foodViewModel.category(for: food))
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    FoodItemView(food: .example)
        .frame(width: 200, height: 200)
        .environmentObject(FoodViewModel())
}
