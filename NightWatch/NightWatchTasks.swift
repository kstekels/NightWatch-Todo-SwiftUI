//
//  NightWatchTasks.swift
//  NightWatch
//
//  Created by karlis.stekels on 07/12/2023.
//

import Foundation

class NightWatchTasks: ObservableObject {
    @Published var nightlyTasks = [
        Task(name: "Check all windows", isComplete: false, lastCompleted: nil),
        Task(name: "Check all doors", isComplete: false, lastCompleted: nil),
        Task(name: "Check that the safe is loceked", isComplete: false, lastCompleted: nil),
        Task(name: "Check the mailbox", isComplete: false, lastCompleted: nil),
        Task(name: "Inspect security cameras", isComplete: false, lastCompleted: nil),
        Task(name: "Clean ice from sidewalks", isComplete: false, lastCompleted: nil),
        Task(name: "Document \"strange and \"unusual occurancies", isComplete: false, lastCompleted: nil)
    ]
    @Published var weeklyTasks = [
        Task(name: "Check inside all vacant rooms", isComplete: false),
        Task(name: "Walk the perimeter of property", isComplete: false)
    ]
    @Published var monthlyTasks = [
        Task(name: "Test security alarm", isComplete: false, lastCompleted: nil),
        Task(name: "Test motion detectors", isComplete: false, lastCompleted: nil),
        Task(name: "Test smoke alarm", isComplete: false, lastCompleted: nil)
    ]
}
