//
//  ContentView.swift
//  swiftui
//
//  Created by Shota Teranishi on 2026/09/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            RegisterView()
                .tabItem {
                    Label("Register", systemImage: "photo.badge.plus")
                }
        }
    }
}

#Preview {
    ContentView()
}
