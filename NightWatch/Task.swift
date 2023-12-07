//
//  Task.swift
//  NightWatch
//
//  Created by karlis.stekels on 07/12/2023.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    let name: String
    var isComplete: Bool
    var lastCompleted: Date?
}
 
