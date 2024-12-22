//
//  ContentView.swift
//  CharityDonationTracker
//
//  Created by The Coding Sprite on 22/12/2024.
//

import SwiftUI

struct Donation: Identifiable {
    let id = UUID()
    let organization: String
    let amount: Double
}

struct ContentView: View {
    
    @State private var donations: [Donation] = []
    @State private var organization = ""
    @State private var amount = ""
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Header
            Text("Charity Donation Tracker")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .padding()
                .foregroundStyle(.white)
            
            // Organisation
            TextField("Organization Name", text: $organization)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            // Donation
            TextField("Donation Amount", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding(.horizontal)
            
            // Add donation to list
            Button {
                // Check fields have numbers & strings
                guard let amountValue = Double(amount), !organization.isEmpty else { return }
                
                let newDonation = Donation(
                    organization: organization,
                    amount: amountValue
                )
                donations.append(newDonation)
                
                // Clear input fields
                organization = ""
                amount = ""
            } label: {
                Text("Add Donation")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            // Donation List
            List(donations) { donation in
                VStack(alignment: .leading, spacing: 5) {
                    Text(donation.organization)
                        .font(.headline)
                    Text("Amount: £\(donation.amount, specifier: "%.2f")")
                        .font(.subheadline)
                }
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
        }
        .padding()
        .background(
            Image("bg").overlay(.black.opacity(0.2)).opacity(0.9)
                .blur(radius: 10)
        )
    }
}

#Preview {
    ContentView()
}
