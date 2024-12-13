//
//  ContentView.swift
//  WishlistTracker
//
//  Created by The Coding Sprite on 12/12/2024.
//

import SwiftUI

struct WishlistItem: Identifiable {
    let id = UUID()
    var name: String
    var isPurchased: Bool
}

struct ContentView: View {
    
    @State private var items: [WishlistItem] = []
    @State private var newItemName = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Add a wishlist item
                    TextField("New Item", text: $newItemName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        if !newItemName.isEmpty {
                            items.append(WishlistItem(name: newItemName, isPurchased: false))
                            newItemName = ""
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.red)
                                .frame(width: 50, height: 40)
                            
                            Text("Add")
                                .foregroundStyle(.white)
                        
                        }
                    }
                }
                //Overlay Background for Textfield
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .opacity(0.2)
                )
                .shadow(radius: 10)
                
                // Show wishlist items
                List {
                    ForEach(items) { item in
                        HStack {
                            
                            Text(item.name)
                            
                            Spacer()
                            
                            Button(item.isPurchased ? "✅" : "Mark as Purchased") {
                                if let index = items.firstIndex(where: { $0.id == item.id }) {
                                    items[index].isPurchased.toggle()
                                }
                            }
                        }
                        // Change to green bg if purchased
                        .listRowBackground(item.isPurchased ? Color.green : Color.white)
                    }
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)

            }
            .navigationTitle("Wishlist")
            .background(Image("paper-bg"))
        }
    }
}

#Preview {
    ContentView()
}
