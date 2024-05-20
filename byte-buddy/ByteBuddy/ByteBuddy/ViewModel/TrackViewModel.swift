import SwiftUI

class TrackViewModel: ObservableObject {
    @Published var trackedMeals: [Meal] = []
    @Published var consumedCalories: Int = 0
    @Published var nutrientBreakdown: [String: Double] = [
        "protein": 0.0,
        "carbs": 0.0,
        "sugar": 0.0,
        "fats": 0.0
    ]

    func addMealToTracker(meal: Meal) {
        trackedMeals.append(meal)
        updateNutrientBreakdown(meal: meal)
    }

    private func updateNutrientBreakdown(meal: Meal) {
        consumedCalories += Int(meal.calories ?? 0)
        nutrientBreakdown["protein"]? += meal.protein
        nutrientBreakdown["carbs"]? += meal.carbs
        nutrientBreakdown["sugar"]? += meal.sugar
        nutrientBreakdown["fats"]? += meal.fat
    }
}

