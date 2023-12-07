//
//  ContentView.swift
//  NightWatch
//
//  Created by karlis.stekels on 06/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var nightWatchTasks: NightWatchTasks
    @State private var focusModeOn = false
    @State private var resetAlertShowing = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: SectionHeader(iconName: "moon.stars", titleName: "Nightly Tasks")) {
                    
                    // Can I get the task and its index in array?
                    let taskIndices = nightWatchTasks.nightlyTasks.indices
                    let tasks = nightWatchTasks.nightlyTasks
                    let taskIndexPairs = Array(zip(tasks, taskIndices))
                    
                    
                    ForEach(taskIndexPairs, id: \.0.id) { task, taskIndex in
                        
                        let nightWatchTasksWrapper = $nightWatchTasks
                        
                        let tasksBinding = nightWatchTasksWrapper.nightlyTasks
                        
                        let theTaskBinding = tasksBinding[taskIndex]
                        
                        if (focusModeOn == false || (focusModeOn && task.isComplete == false)) {
                            NavigationLink(destination: DetailsView(task: theTaskBinding)) {
                                ListItem(task: task)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        nightWatchTasks.nightlyTasks.remove(atOffsets: indexSet)
                    }
                    .onMove { taskIndices, newOffset in
                        nightWatchTasks.nightlyTasks.move(fromOffsets: taskIndices, toOffset: newOffset)
                    }
                }
                
//                Section(header: SectionHeader(iconName: "sunset", titleName: "Weekly tasks")) {
//                    
//                    // Can I get the task and its index in array?
//                    let taskIndices = nightWatchTasks.weeklyTasks.indices
//                    let tasks = nightWatchTasks.weeklyTasks
//                    let taskIndexPairs = Array(zip(tasks, taskIndices))
//                    
//                    ForEach(taskIndexPairs, id:\.0.id) { task, taskIndex in
//                        
//                        let nightWatchTasksWrapper = $nightWatchTasks
//                        
//                        let tasksBinding = nightWatchTasksWrapper.nightlyTasks
//                        
//                        let theTaskBinding = tasksBinding[taskIndex]
//                        
//                        NavigationLink(destination: DetailsView(task: theTaskBinding)) {
//                            ListItem(task: task)
//                        }
//                    }
//                }
//                
//                Section(header: SectionHeader(iconName: "calendar", titleName: "Monthly tasks")) {
//                    ForEach(nightWatchTasks.monthlyTasks) { task in
//                        NavigationLink(destination: DetailsView(task: task)) {
//                            ListItem(task: task)
//                        }
//                    }
//                }
            }
            .listStyle(.grouped)
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        resetAlertShowing.toggle()
                    } label: {
                        Text("Reset")
                    }

                }
                ToolbarItem(placement: .bottomBar) {
                    Toggle(isOn: $focusModeOn) {
                        Text("Focus mode")
                    }
                    .toggleStyle(.switch)
                    .padding(.horizontal)
                }
            }
        }
        .alert(isPresented: $resetAlertShowing, content: {
            Alert(
                title: Text("Reset List"),
                message: Text("Are you sure?"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Yes, reset it!"), action: {
                    let refreshNightWatchTask = NightWatchTasks()
                    self.nightWatchTasks.nightlyTasks = refreshNightWatchTask.nightlyTasks
                    self.nightWatchTasks.weeklyTasks = refreshNightWatchTask.weeklyTasks
                    self.nightWatchTasks.monthlyTasks = refreshNightWatchTask.monthlyTasks
                })
            )
        })
    }
}

#Preview {
    ContentView(nightWatchTasks: NightWatchTasks())
}

struct SectionHeader: View {
    
    let iconName: String
    let titleName: String
    
    var body: some View {
        HStack {
            Text(Image(systemName: iconName))
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                .fontWeight(.heavy)
            Text(titleName)
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                .fontWeight(.heavy)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
        }
        .foregroundStyle(.accent)
    }
}

struct DetailsView: View {
    @Binding var task: Task
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack {
            HStack{
                Text(Image(systemName: task.isComplete ? "checkmark.square" : "square"))
                Text(task.name)
            }
            
            ActionButton(isComplete: $task.isComplete)
            
            Divider()
            
            if verticalSizeClass == .regular {
                VStack(alignment: .center) {
                    
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                        .padding()
                }
            }
            
        }
    }
}

struct ListItem: View {
    let task: Task
    
    var body: some View {
        HStack {
            Text(Image(systemName: task.isComplete ? "checkmark.circle.fill": "circle"))
                .foregroundStyle(task.isComplete ? Color.green : Color.gray)
            Text(task.name)
                .strikethrough(task.isComplete)
                .foregroundStyle(task.isComplete ? Color.gray : Color.primary)
        }
    }
}

struct ActionButton: View {
    
    @Binding var isComplete: Bool
    
    var body: some View {
        Button(action: {
            isComplete.toggle()
        }, label: {
            ZStack {
                Color.blue
                VStack {
                    Text(!isComplete ? "Mark Complete" : "Reset")
                        .padding()
                        .foregroundStyle(Color.white)
                }
            }
            .frame(width: 150, height: 60)
            .cornerRadius(15)
        })
        .padding(.top)
    }
}
