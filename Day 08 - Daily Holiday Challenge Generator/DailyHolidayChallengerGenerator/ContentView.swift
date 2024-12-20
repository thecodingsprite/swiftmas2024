//
//  ContentView.swift
//  DailyHolidayChallengerGenerator
//
//  Created by The Coding Sprite on 20/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var challenges = [
        "Bake holiday cookies",
        "Decorate a gingerbread house",
        "Write holiday cards to friends and family",
        "Watch a classic holiday movie",
        "Host a hot cocoa night",
        "Go caroling or play festive music",
        "Donate to a local charity",
        "Make DIY ornaments",
        "Build a snowman",
        "Have a holiday pajama day",
        "Make a festive wreath",
        "Host a holiday trivia game night",
        "Visit a holiday market or fair",
        "Create a holiday photo booth",
        "Make a list of New Year's resolutions"
    ]
    @State private var currentChallenge = ""
    @State private var showChallenge = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Holiday Challenge")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            // Show current challenge with animation
            if showChallenge {
                Text(currentChallenge)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .transition(.scale.combined(with: .opacity))
                    .animation(.spring(), value: showChallenge)
            }
            
            // Button to generate a new challenge
            Button(action: generateChallenge) {
                Text("New Challenge")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RadialGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.3), Color.white]),
                center: .center,
                startRadius: 100,
                endRadius: 500
            )
            .ignoresSafeArea()
        )
    }
    
    /// Generate a new random challenge
    private func generateChallenge() {
        let newChallenge = challenges.randomElement() ?? "Have a festive day!"
        withAnimation {
            currentChallenge = newChallenge
            showChallenge = true
        }
    }
}


#Preview {
    ContentView()
}

