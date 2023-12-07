//
//  NightWatchApp.swift
//  NightWatch
//
//  Created by karlis.stekels on 06/12/2023.
//

import SwiftUI

@main
struct NightWatchApp: App {
    
    @StateObject private var nightWatchTasks = NightWatchTasks()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView(nightWatchTasks: nightWatchTasks)
        }
    }
}
