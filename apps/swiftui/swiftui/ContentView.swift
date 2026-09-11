import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            RegisterView {
                selectedTab = 0
            }
            .tabItem {
                Label("Register", systemImage: "photo.badge.plus")
            }
            .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
