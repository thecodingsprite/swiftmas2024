//
//  ContentView.swift
//  RecipeFinder
//
//  Created by The Coding Sprite on 16/12/2024.
//

import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let ingredients: [String]
    let dietaryInfo: [String]
}

struct ContentView: View {
    @State private var recipes: [Recipe] = [
           Recipe(name: "Vegan Pumpkin Pie", ingredients: ["Pumpkin", "Coconut Milk", "Maple Syrup"], dietaryInfo: ["Vegan", "Gluten-Free"]),
           Recipe(name: "Classic Roast Turkey", ingredients: ["Turkey", "Butter", "Herbs"], dietaryInfo: ["Gluten-Free"]),
           Recipe(name: "Chocolate Yule Log", ingredients: ["Chocolate", "Eggs", "Flour"], dietaryInfo: ["Vegetarian"]),
           Recipe(name: "Stuffed Bell Peppers", ingredients: ["Bell Peppers", "Quinoa", "Black Beans"], dietaryInfo: ["Vegan"]),
       ]

       @State private var searchQuery = ""
       @State private var selectedDietaryFilters: [String] = []

       let dietaryOptions = ["Vegan", "Vegetarian", "Gluten-Free"]

       var filteredRecipes: [Recipe] {
           recipes.filter { recipe in
               let matchesQuery = searchQuery.isEmpty || recipe.ingredients.contains { $0.localizedCaseInsensitiveContains(searchQuery) }
               let matchesDietary = selectedDietaryFilters.isEmpty || recipe.dietaryInfo.contains { selectedDietaryFilters.contains($0) }
               return matchesQuery && matchesDietary
           }
       }

       var body: some View {
           NavigationView {
               VStack {
                   // Search Bar
                   TextField("Search for ingredients...", text: $searchQuery)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()

                   // Dietary Filters
                   HStack {
                       ForEach(dietaryOptions, id: \ .self) { option in
                           Button(action: {
                               if selectedDietaryFilters.contains(option) {
                                   selectedDietaryFilters.removeAll { $0 == option }
                               } else {
                                   selectedDietaryFilters.append(option)
                               }
                           }) {
                               Text(option)
                                   .padding()
                                   .background(selectedDietaryFilters.contains(option) ? Color.green : Color.gray.opacity(0.2))
                                   .foregroundColor(.white)
                                   .cornerRadius(8)
                           }
                       }
                   }
                   .padding()

                   // Recipe List
                   List(filteredRecipes) { recipe in
                       VStack(alignment: .leading) {
                           Text(recipe.name)
                               .font(.headline)
                           Text("Ingredients: " + recipe.ingredients.joined(separator: ", "))
                               .font(.subheadline)
                               .foregroundColor(.gray)
                           Text("Dietary Info: " + recipe.dietaryInfo.joined(separator: ", "))
                               .font(.footnote)
                               .foregroundColor(.blue)
                       }
                       .listRowBackground(Color.white.opacity(0.5))
                   }
                   .scrollContentBackground(.hidden)
                   .scrollIndicators(.hidden)
               }
               .navigationTitle("Holiday Recipe Finder")
               .background {
                   Image("bg")
                       .resizable()
                       .ignoresSafeArea()
               }
           }
       }
}

#Preview {
    ContentView()
}
