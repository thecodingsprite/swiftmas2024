//
//  SnowflakeTemplatePickerView.swift
//  SnowflakeDesigner
//
//  Created by The Coding Sprite on 17/12/2024.
//

import SwiftUI

struct SnowflakeTemplatePickerView: View {
    let templates: [String] = ["snowflake-1", "snowflake-2", "snowflake-3"] // Image names
    @State private var selectedTemplate = "snowflake-1" // Default template
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Choose Template", selection: $selectedTemplate) {
                    ForEach(templates, id: \.self) { template in
                        Text(template).tag(template)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
                
                // Display the selected template
                Image(selectedTemplate)
                    .resizable()
                    .frame(width: 300, height: 300)
                
                Spacer()
                
                // Go to drawing view
                NavigationLink(destination: SnowflakeDesignerView(snowflakeImage: Image(selectedTemplate))) {
                    Text("Start Drawing")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("Choose Snowflake Template")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SnowflakeTemplatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        SnowflakeTemplatePickerView()
    }
}
