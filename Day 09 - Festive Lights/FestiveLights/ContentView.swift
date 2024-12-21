//
//  ContentView.swift
//  FestiveLights
//
//  Created by The Coding Sprite on 21/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var lightColors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
    @State private var activeColorIndex = 0
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 40) {
            // Header
            Text("Christmas Lights Simulator")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            // Light Bulbs Display
            HStack(spacing: 20) {
                ForEach(0..<6) { index in
                    Circle()
                        .fill(lightColors[(activeColorIndex + index) % lightColors.count])
                        .frame(width: 50, height: 50)
                        .shadow(radius: 5)
                }
            }
            
            Spacer()
            
            // Control Buttons
            HStack(spacing: 20) {
                Button(action: startAnimation) {
                    Text(isAnimating ? "Pause Lights" : "Start Lights")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(isAnimating ? Color.red : Color.green)
                        .cornerRadius(10)
                }
                
                Button(action: randomizeColors) {
                    Text("Randomize Colors")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .onAppear(perform: startAnimation)
    }
    
    /// Start or stop the animation
    private func startAnimation() {
        isAnimating.toggle()
        
        if isAnimating {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if !isAnimating {
                    timer.invalidate()
                } else {
                    activeColorIndex = (activeColorIndex + 1) % lightColors.count
                }
            }
        }
    }
    
    // Randomize the colors of the lights
    private func randomizeColors() {
        lightColors = lightColors.shuffled()
    }
}

#Preview {
    ContentView()
}
