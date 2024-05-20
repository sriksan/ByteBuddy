import SwiftUI


struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject var trackViewModel: TrackViewModel
    @State private var searchText: String = ""


    var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return viewModel.meals
        } else {
            return viewModel.meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }


    var body: some View {
        VStack {
            Text("Chase Items")
                .font(.largeTitle)
                .bold()
                .padding()


            TextField("Search by Name", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)


            if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
            } else {
                List(filteredMeals) { meal in
                    MealListItems(meal: meal)
                }
            }


            Spacer()
        }
        .onAppear {
            viewModel.loadMeals()
        }
    }
}


struct MealListItems: View {
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
                    .scaleEffect(isScaled ? 1.5 : 1.0) // Scale up when isScaled is true
                    .animation(.easeInOut(duration: 0.5)) // Smooth animation
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(TrackViewModel())
    }
}

