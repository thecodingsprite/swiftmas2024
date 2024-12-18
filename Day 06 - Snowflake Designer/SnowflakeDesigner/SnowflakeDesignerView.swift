//
//  ContentView.swift
//  SnowflakeDesigner
//
//  Created by The Coding Sprite on 18/12/2024.
//

import SwiftUI


struct SnowflakeDesignerView: View {
    // The image that will be used as the snowflake template
    let snowflakeImage: Image
    
    @State private var drawing: [Path] = [] // Store the drawn paths
    @State private var currentPath = Path() // The current drawing path
    @State private var currentColor: Color = .blue // The initial drawing color
    @State private var strokeWidth: CGFloat = 2 // Default stroke width
    
    let colors: [Color] = [.white, .red, .green, .yellow, .purple] // Predefined colors

        var body: some View {
            VStack {
                // Color buttons for predefined colors
                HStack {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                currentColor = color
                            }
                            .padding(4)
                    }
                }
                .padding()

                // Stroke width slider
                VStack {
                    Text("Stroke Width: \(Int(strokeWidth))")
                        .padding()
                        .foregroundStyle(.white)
                    Slider(value: $strokeWidth, in: 1...10, step: 1)
                        .padding([.leading, .trailing])
                }

                ZStack {
                    snowflakeImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .colorInvert()
                        .opacity(0.5)

                    Canvas { context, size in
                        // Draw the current path being drawn with the selected stroke width
                        context.stroke(currentPath, with: .color(currentColor), lineWidth: strokeWidth)

                        // Draw all completed paths with the selected color and stroke width
                        for path in drawing {
                            context.stroke(path, with: .color(currentColor), lineWidth: strokeWidth)
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    currentPath.addLine(to: value.location)
                                }
                                .onEnded { _ in
                                    drawing.append(currentPath)
                                    currentPath = Path()
                                })
                }
                .padding()
            }
            .background(.black)
        }
}

#Preview {
    SnowflakeDesignerView(snowflakeImage: Image("snowflake-1"))
}
