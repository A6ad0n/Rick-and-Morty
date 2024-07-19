//
//  Rick_and_MortyApp.swift
//  Rick and Morty
//
//  Created by Egor Bazakin on 19.07.2024.
//

import SwiftUI

@main
struct Rick_and_MortyApp: App {
    @StateObject var networkManager = NetworkManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkManager)
        }
    }
}
