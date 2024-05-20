
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var searchResults: [Meal] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    init() {
        loadMeals()
    }
    
    func loadMeals() {
        isLoading = true
        errorMessage = ""
        
        guard let url = Bundle.main.url(forResource: "chase", withExtension: "json") else {
            errorMessage = "JSON file not found."
            isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            meals = try decoder.decode([Meal].self, from: data)
            isLoading = false
        } catch {
            errorMessage = "Error loading meals: \(error.localizedDescription)" 
            isLoading = false
        }
    }
    
    func searchMeals(query: String) {
        if query.isEmpty {
            searchResults = []
        } else {
            searchResults = meals.filter { meal in
                meal.name.localizedCaseInsensitiveContains(query)
            }
        }
    }
}
