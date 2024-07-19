//
//  ContentView.swift
//  Rick and Morty
//
//  Created by Egor Bazakin on 19.07.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    @State private var showSplash = true
    var body: some View {
        Group {
            if showSplash {
                SplashScreen()
            } else {
                if networkManager.isConnected {
                    CharacterView()
                        .environmentObject(networkManager)
                }
                else {
                    NoInternetView()
                }
            }
            }
        .onAppear {
            networkManager.startMonitoring()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.showSplash = false
            }
        }
        .onDisappear {
            networkManager.stopMonitoring()
        }
    }
}

#Preview {
    ContentView()
}
