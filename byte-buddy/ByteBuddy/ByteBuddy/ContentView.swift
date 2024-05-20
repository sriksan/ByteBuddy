import SwiftUI

struct ContentView: View {
    @State private var selectedIndex = 0
    @StateObject private var trackViewModel = TrackViewModel() 
    @State var calories: Double = 2000
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView(calories: $calories)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            SearchViewBoth()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)

            
            TrackView(caloriesGoal: $calories)
                .environmentObject(trackViewModel)
                .tabItem {
                    Label("Track", systemImage: "chart.bar")
                }
                .tag(2)
        }
        .onAppear {
        }
        .environmentObject(trackViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


