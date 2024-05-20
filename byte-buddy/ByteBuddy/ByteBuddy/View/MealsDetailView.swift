
import SwiftUI

struct MealDetailsView: View {
    var body: some View {
        VStack {
            Text("Meal Name")
                .font(.title)
                .padding()
            
            Text("Calories: 500")
            Text("Serving Size: 1")
            
            Text("Nutrient 1: 10")
            Text("Nutrient 2: 20")
            
            Spacer()
        }
    }
}

struct MealDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsView()
    }
}
