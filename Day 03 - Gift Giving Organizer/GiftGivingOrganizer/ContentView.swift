//
//  ContentView.swift
//  GiftGivingOrganizer
//
//  Created by The Coding Sprite on 15/12/2024.
//

import SwiftUI


struct ContentView: View {
    
    @State private var participants: [String] = []
    @State private var newParticipant = ""
    @State private var gifts: [String] = []
    @State private var newGift = ""
    @State private var assignments: [(String, String)] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Participant Input Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Add Participants")
                        .font(.headline)
                       
                    HStack {
                        TextField("Enter name", text: $newParticipant)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Add") {
                            if !newParticipant.isEmpty {
                                participants.append(newParticipant)
                                newParticipant = ""
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.green)
                    }
                    if !participants.isEmpty {
                        Text("Participants: \(participants.joined(separator: ", "))")
                            .font(.subheadline)
                    }
                }
                
                Divider()
                
                // Gift Input Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Add Gifts")
                        .font(.headline)
                    HStack {
                        TextField("Enter gift", text: $newGift)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Add") {
                            if !newGift.isEmpty {
                                gifts.append(newGift)
                                newGift = ""
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.green)
                    }
                    if !gifts.isEmpty {
                        Text("Gifts: \(gifts.joined(separator: ", "))")
                            .font(.subheadline)
                    }
                }
                
                Divider()
                
                // Assign Gifts Button
                Button("Assign Gifts") {
                    if participants.count > 0 && gifts.count > 0 {
                        assignGifts()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.green)
                .disabled(participants.isEmpty || gifts.isEmpty)
                
                // Show Assignments
                if !assignments.isEmpty {
                    List(assignments, id: \.0) { (name, gift) in
                        HStack {
                            Text(name)
                            Spacer()
                            Text(gift)
                                .foregroundColor(.gray)
                        }
                        .listRowBackground(Color.yellow)
                    }
                    .scrollIndicators(.hidden)
                    .scrollContentBackground(.hidden)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Gift Exchange Organizer")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                Image("festive-bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .blur(radius: 3)
                    .opacity(0.5)
            )
        }
    }
    
    func assignGifts() {
        var remainingGifts = gifts.shuffled()
        assignments = participants.map { participant in
            let gift = remainingGifts.removeFirst()
            return (participant, gift)
        }
    }
}

#Preview {
    ContentView()
}
