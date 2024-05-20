import SwiftUI

struct SearchViewBoth: View {
    @StateObject private var viewModelLenoir = SearchViewModelLenoir()
    @StateObject private var viewModelChase = SearchViewModel()
    @EnvironmentObject var trackViewModel: TrackViewModel
    @State private var searchText: String = ""

    var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return viewModelLenoir.meals + viewModelChase.meals
        } else {
            let lenoirMeals = viewModelLenoir.meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            let chaseMeals = viewModelChase.meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            return lenoirMeals + chaseMeals
        }
    }

    var body: some View {
        VStack {
            Text("Menu Items")
                .font(.largeTitle)
                .bold()
                .padding()

            TextField("Search by Name", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            if viewModelLenoir.isLoading || viewModelChase.isLoading {
                ProgressView()
            } else if !viewModelLenoir.errorMessage.isEmpty {
                Text(viewModelLenoir.errorMessage)
            } else {
                List(filteredMeals) { meal in
                    MealListItem(meal: meal)
                }
            }

            Spacer()
        }
        .onAppear {
            viewModelLenoir.loadMeals()
            viewModelChase.loadMeals()
        }
    }
}

struct MealListItem: View {
    let meal: Meal
    @EnvironmentObject var trackViewModel: TrackViewModel
    @State private var scale: CGFloat = 1.0
    @State private var isScaled = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(meal.name)
                .bold()
            Text("Calories: \(meal.formattedCalories)")
            Text("Fats: " + String(meal.fat))
            Text("Carbs: " + String(meal.carbs))
            Text("Sugar: " + String(meal.sugar))
            Text("Protein: " + String(meal.protein))
            Button(action: {
                trackViewModel.addMealToTracker(meal: meal)
                isScaled = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isScaled = false
                }
            }) {
                Image(systemName: "fork.knife.circle")
                    .font(.title)
                    .padding(.top, 1)
                    .scaleEffect(isScaled ? 1.5 : 1.0)
                    .animation(.easeInOut(duration: 0.5)) 
            }
        }
    }
}

struct SearchViewBoth_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewBoth()
            .environmentObject(TrackViewModel())
    }
}

