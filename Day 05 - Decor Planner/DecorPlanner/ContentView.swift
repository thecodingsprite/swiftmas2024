//
//  ContentView.swift
//  DecorPlanner
//
//  Created by The Coding Sprite on 17/12/2024.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool
}

struct ContentView: View {
    
    @State private var tasks: [Task] = []
    @State private var newTaskName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Input Section
                HStack {
                    TextField("New Decor Task", text: $newTaskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: addTask) {
                        Text("Add")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                // Task List
                List {
                    ForEach(tasks) { task in
                        HStack {
                            Text(task.name)
                                .strikethrough(task.isCompleted, color: .gray)
                                .foregroundColor(task.isCompleted ? .gray : .primary)
                            Spacer()
                            Button(action: {
                                toggleTaskCompletion(task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .blue)
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                    .listRowBackground(Color.white.opacity(0.5))
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("DIY Decor Planner")
            .background {
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.5)
            }
        }
    }
    
    /// Add the new task to the array
    private func addTask() {
        guard !newTaskName.isEmpty else { return }
        tasks.append(Task(name: newTaskName, isCompleted: false))
        newTaskName = ""
    }
    
    /// Mark the particular task as completed
    private func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    /// Delete the task from the array
    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
