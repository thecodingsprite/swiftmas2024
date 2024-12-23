//
//  ContentView.swift
//  HotDrinkCustomizer
//
//  Created by The Coding Sprite on 23/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var hasTea = false
    @State private var hasCoffee = false
    @State private var hasChocolate = false
    @State private var hasMarshmallows = false
    @State private var hasWhippedCream = false

    @State private var questionTrack = 0

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // Display header based on the current question
            if questionTrack != 3 {
                Text(headerText)
                    .font(.title)
                    .foregroundStyle(.white)
            }

            Spacer()

            // Main content based on questionTrack
            switch questionTrack {
            case 0:
                yesNoButtons

            case 1:
                drinkButtons

            case 2:
                extraButtons

            case 3:
                enjoyView

            case 4:
                goodbyeView

            default:
                EmptyView()
            }

            Spacer()

            // Display the cup and its contents
            if questionTrack > 0 && questionTrack < 4 {
                cupView
            }
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.bg
                .ignoresSafeArea()
        )
    }

    /// Header text based on questionTrack
    private var headerText: String {
        switch questionTrack {
        case 0: return "Fancy a hot drink?"
        case 1: return "What kind?"
        case 2: return "Any Extras?"
        default: return ""
        }
    }

    /// Yes/No Buttons
    private var yesNoButtons: some View {
        HStack(spacing: 20) {
            Button("Yes Please") {
                questionTrack = 1
            }

            Button("No Thanks") {
                questionTrack = 4
            }
        }
    }

    /// Drink Selection Buttons
    private var drinkButtons: some View {
        HStack(spacing: 20) {
            drinkButton(title: "Tea", isSelected: $hasTea)
            drinkButton(title: "Coffee", isSelected: $hasCoffee)
            drinkButton(title: "Hot Cocoa", isSelected: $hasChocolate)
        }
    }

    /// Extras Selection Buttons
    private var extraButtons: some View {
        HStack(spacing: 20) {
            drinkButton(title: "Marshmallows", isSelected: $hasMarshmallows)
            drinkButton(title: "Whipped Cream", isSelected: $hasWhippedCream)
        }
    }

    /// Enjoy View
    private var enjoyView: some View {
        HStack {
            Text("Enjoy!")
                .font(.title)
                .foregroundStyle(.white)

            Button(action: reset) {
                Image(systemName: "arrow.triangle.2.circlepath")
            }
        }
        .padding(.horizontal)
    }

    /// Goodbye View
    private var goodbyeView: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Have a nice day")
                .font(.title)
                .foregroundStyle(.white)

            Button(action: reset) {
                Image(systemName: "arrow.triangle.2.circlepath")
            }
            Spacer()
        }
    }

    /// Cup View
    private var cupView: some View {
        ZStack {
            Image("cup")
                .resizable()
                .aspectRatio(contentMode: .fit)

            if hasTea {
                Image("tea")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            if hasCoffee {
                Image("coffee")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            if hasChocolate {
                Image("cocoa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            if hasMarshmallows {
                Image("marshmallows")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            if hasWhippedCream {
                Image("whipped-cream")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            Image("steam")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }

    /// Helper Button Generator
    private func drinkButton(title: String, isSelected: Binding<Bool>) -> some View {
        Button(title) {
            isSelected.wrappedValue.toggle()
            questionTrack += 1
        }
        .padding(10)
    }

    /// Reset the application state
    private func reset() {
        questionTrack = 0
        hasTea = false
        hasCoffee = false
        hasChocolate = false
        hasMarshmallows = false
        hasWhippedCream = false
    }
}

#Preview {
    ContentView()
}
