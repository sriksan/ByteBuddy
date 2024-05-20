import SwiftUI


struct SearchViewLenoir: View {
    @StateObject private var viewModel = SearchViewModelLenoir()
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
            Text("Lenoir Items")
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

struct SearchViewLenoir_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewLenoir()
            .environmentObject(TrackViewModel())
    }
}
