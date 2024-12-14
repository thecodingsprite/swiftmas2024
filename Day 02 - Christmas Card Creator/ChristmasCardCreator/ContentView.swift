//
//  ContentView.swift
//  ChristmasCardCreator
//
//  Created by The Coding Sprite on 14/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var recipientName = ""
    @State private var message = ""
    @State private var backgroundTheme = "card-1"
    
    var body: some View {
        VStack {
            ZStack {
                //Show card bg
                Image(backgroundTheme)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .opacity(0.4)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 350, height: 300)
                    .padding(.horizontal)
                
                // Show Message
                Text("\(message) \(recipientName)")
                    .font(.title)
                    .foregroundStyle(.black)
                    .shadow(radius: 20)
                    .padding()
            }
            
            Spacer()
            
            // Recipent Name
            TextField("Recipent Name", text: $recipientName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .shadow(radius: 20)

            // Enter Greeting
            TextField("Enter your message", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .shadow(radius: 20)
            
            // BG Choice
            VStack {
                Text("Pick your greeting card background")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                HStack(spacing: 20) {
                    Button {
                        backgroundTheme = "card-1"
                    } label: {
                        cardModifier(cardName: "card-1")
                    }
                   
                    Button {
                        backgroundTheme = "card-2"
                    } label: {
                        cardModifier(cardName: "card-2")
                    }
                }
                
                HStack(spacing: 20) {
                    Button {
                        backgroundTheme = "card-3"
                    } label: {
                        cardModifier(cardName: "card-3")
                    }
                    Button {
                        backgroundTheme = "card-4"
                    } label: {
                        cardModifier(cardName: "card-4")
                    }
                }
            }
        }
        .padding()
        .background(
            ZStack {
                Image("candybg").resizable().opacity(0.6)
                Rectangle()
                    .fill(.black)
                    .opacity(0.2)
            }
                .ignoresSafeArea()
        )
    }
}

struct cardModifier: View {
    
    var cardName = ""
    
    var body: some View {
        Image(cardName)
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    
   
}

#Preview {
    ContentView()
}

