import SwiftUI

struct TrackView: View {
    @EnvironmentObject var trackViewModel: TrackViewModel
    @State private var proteinGoal: Double = 100
    @State private var carbsGoal: Double = 100
    @State private var sugarGoal: Double = 50
    @State private var fatsGoal: Double = 70
    @Binding var caloriesGoal: Double

    var body: some View {
        VStack {
            Text("TRACKER")
                .bold()
                .font(.largeTitle)
                .padding()
            // Calorie progress bar
            HStack {
                ProgressBar(value: Double(Int(trackViewModel.consumedCalories)), total: Double(caloriesGoal), title: "Calories")
                NutrientAdjustmentButton(title: "", goal: $caloriesGoal)
                
            }
            // Display progress bars for nutrients with consumed quantities
            HStack {
                NutritionProgressView(title: "Protein", value: trackViewModel.nutrientBreakdown["protein"] ?? 0, total: proteinGoal)
                NutrientAdjustmentButton(title: "", goal: $proteinGoal)
            }
            HStack {
                NutritionProgressView(title: "Carbs", value: trackViewModel.nutrientBreakdown["carbs"] ?? 0, total: carbsGoal)
                NutrientAdjustmentButton(title: "", goal: $carbsGoal)
            }
            HStack {
                NutritionProgressView(title: "Sugar", value: trackViewModel.nutrientBreakdown["sugar"] ?? 0, total: sugarGoal)
                NutrientAdjustmentButton(title: "", goal: $sugarGoal)
            }
            HStack {
                NutritionProgressView(title: "Fats", value: trackViewModel.nutrientBreakdown["fats"] ?? 0, total: fatsGoal)
                NutrientAdjustmentButton(title: "", goal: $fatsGoal)
            }

            // Plus and minus buttons to adjust nutrient goals
            // Logged items under progress bars
            List(trackViewModel.trackedMeals) { meal in
                Text("\(meal.name): \(meal.formattedCalories) calories")
            }

            Spacer()
        }
        .padding()
        .environmentObject(trackViewModel) // Pass TrackViewModel as environment object to TrackView
    }
}

struct NutrientAdjustmentButton: View {
    let title: String
    @Binding var goal: Double

    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
            HStack {
                Button(action: {
                    goal -= 10 // Decrease goal by 10
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                }
                .padding()

                Button(action: {
                    goal += 10 // Increase goal by 10
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                }
                .padding()
            }
        }
    }
}

struct ProgressBar: View {
    var value: Double
    var total: Double
    var title: String

    var body: some View {
        VStack {
            Text("\(title): \(Int(value))/\(Int(total))")
            ProgressView(value: value, total: total)
                .padding()
        }
    }
}

struct NutritionProgressView: View {
    let title: String
    let value: Double
    let total: Double

    var body: some View {
        VStack {
            Text("\(title): \(Int(value))/\(Int(total))")
            ProgressView(value: value, total: total)
                .padding()
        }
    }
}



