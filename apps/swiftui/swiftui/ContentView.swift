import SwiftUI

/// アプリのメインタブを管理
struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            RegisterView { _ in
                selectedTab = 0
            }
            .tabItem {
                Label("Register", systemImage: "photo.badge.plus")
            }
            .tag(1)
//            MapView(observations: observations)
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
