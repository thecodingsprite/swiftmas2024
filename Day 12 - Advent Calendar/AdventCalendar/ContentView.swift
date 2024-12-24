//
//  ContentView.swift
//  AdventCalendar
//
//  Created by The Coding Sprite on 24/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    let jokes = [
        "Why was the snowman looking through the carrots? He was picking his nose!",
        "What do you call Santa when he takes a break? Santa Pause!",
        "Why did the turkey join the band? Because it had the drumsticks!",
        "What do elves learn in school? The elf-abet!",
        "Why is it so cold during Christmas? Because it’s Decembrrrr!",
        "What do you call a reindeer with bad manners? Rude-olph!",
        "What do snowmen eat for breakfast? Frosted flakes!",
        "Why did Santa go to music school? To improve his wrapping skills!",
        "What do you call an old snowman? Water!",
        "What’s a snowman’s favorite drink? Iced tea!",
        "Why don’t you ever see Santa in the hospital? Because he has private elf-care!",
        "What do you get when you cross a snowman and a dog? Frostbite!",
        "What does Santa suffer from if he gets stuck in a chimney? Claus-trophobia!",
        "Why are Christmas trees bad at knitting? They always drop their needles!",
        "What did one snowflake say to the other? You’re one of a kind!",
        "What do you call an obnoxious reindeer? Rude-olph!",
        "What’s every parent’s favorite Christmas carol? Silent Night!",
        "What do gingerbread men use to make their beds? Cookie sheets!",
        "What do Santa’s helpers use to measure? Santameters!",
        "Why do mummies like Christmas so much? Because of all the wrapping!",
        "What did the Christmas tree say to the ornament? Quit hanging around!",
        "How much did Santa pay for his sleigh? Nothing, it was on the house!",
        "What’s Santa’s favorite type of music? Wrap music!",
        "Why are Christmas trees so bad at sewing? They always drop their needles!"
    ]
    
    @State private var colors: [Int: Color] = [:]
    @State private var shapes: [Int: AnyShape] = [:]
    @State private var sizes: [Int: CGSize] = [:]
    @State private var isAlertVisible = false
    @State private var selectedDay = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Advent Calendar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .shadow(radius: 15)
                    .padding()
                
                Spacer()
                // 4x6 Grid of Dates
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                    ForEach(1...24, id: \ .self) { day in
                        Button(action: {
                            showAlert(for: day)
                        }) {
                            ZStack {
                                assignedShape(for: day)
                                    .foregroundColor(colors[day] ?? assignColor(for: day))
                                    .frame(width: assignedSize(for: day).width, height: assignedSize(for: day).height)
                                
                                Text("\(day)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .alert(isPresented: $isAlertVisible) {
                Alert(title: Text("Day \(selectedDay)"), message: Text(jokes[selectedDay - 1]), dismissButton: .default(Text("Close")))
            }
            .frame(maxHeight: .infinity)
            .background(
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.yellow.opacity(0.8),
                        Color.red.opacity(0.6),
                        Color.green.opacity(0.5),
                        Color.blue.opacity(0.4)
                    ]),
                    center: .center,
                    startRadius: 100,
                    endRadius: 500
                )
                .ignoresSafeArea()
            )
        }
        
    }
    
    private func showAlert(for day: Int) {
        selectedDay = day
        isAlertVisible = true
    }
    ///Assign the random colors to each date
    private func assignColor(for day: Int) -> Color {
        let color = [Color.red, Color.green, Color.blue, Color.purple, Color.orange, Color.yellow].randomElement() ?? .red
        colors[day] = color
        return color
    }
    ///Assign the random shapes to each date
    private func assignedShape(for day: Int) -> some Shape {
        if let shape = shapes[day] {
            return shape
        }
        
        let newShape: AnyShape = [
            AnyShape(Circle()),
            AnyShape(RoundedRectangle(cornerRadius: 10)),
            AnyShape(Capsule())
        ][Int.random(in: 0..<3)]
        
        shapes[day] = newShape
        return newShape
    }
    ///Assign the random sizes to each date
    private func assignedSize(for day: Int) -> CGSize {
        if let size = sizes[day] {
            return size
        }
        
        let newSize = CGSize(width: CGFloat.random(in: 60...90), height: CGFloat.random(in: 60...90))
        sizes[day] = newSize
        return newSize
    }
}



#Preview {
    ContentView()
}
