
import SwiftUI

struct HomeView: View {
    @State private var isChasePressed = false
    @State private var isLenoirPressed = false
    @EnvironmentObject var trackViewModel: TrackViewModel
    @Binding var calories: Double
    
    var remainingCalories: Int {
        let remaining = Int(calories) - trackViewModel.consumedCalories
        return max(0, remaining) // Ensure remaining calories is not negative
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background images
                Image("cdspeople")
                    .resizable()
                    .frame(width: 400, height: 300)
                    .offset(x: 100, y: 250)
                    .opacity(0.25)
                
                Image("cdspeople2")
                    .resizable()
                    .frame(width: 400, height: 300)
                    .offset(x: -150, y: 0)
                    .opacity(0.25)
                
                Image("cdspeople3")
                    .resizable()
                    .frame(width: 400, height: 300)
                    .offset(x: -150, y: 400)
                    .opacity(0.25)
                
                Image("cdspeople4")
                    .resizable()
                    .frame(width: 400, height: 300)
                    .offset(x: 100, y: -100)
                    .opacity(0.25)
                
                Image("cdspeople5")
                    .resizable()
                    .frame(width: 400, height: 300)
                    .offset(x: 0, y: -300)
                    .opacity(0.25)
                
                Image("cdspeople6")
                    .resizable()
                    .frame(width: 400, height: 300)
                    .offset(x: -300, y: 300)
                    .opacity(0.25)
                
                Image("cdspeople7")
                    .resizable()
                    .frame(width: 400, height: 300)
                    .offset(x: 200, y: 200)
                    .opacity(0.25)
                
                Image("cdspeople8")
                    .resizable()
                    .frame(width: 400, height: 300)
                    .offset(x: 200, y: 500)
                    .opacity(0.25)
                
                VStack {
                    // Spacer()
                    
                    // ByteBuddy logo
                    Image("ByteBuddyLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 450, height: 450)
                        .padding()
                    
                    // Calories indicator
                    VStack(spacing: 20) {
                        HStack {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.orange)
                            Text("Today's Calories: \(trackViewModel.consumedCalories)")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        HStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(.green)
                            Text("Remaining Calories: \(remainingCalories)")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    Spacer()
                    // Navigation links
                    HStack(spacing: 20) {
                        NavigationLink(destination: SearchView()) {
                            Text("Chase")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 170)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .scaleEffect(isChasePressed ? 2 : 1.0)
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isChasePressed = true
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isChasePressed = false
                                    }
                                }
                        )
                        
                        NavigationLink(destination: SearchViewLenoir()) {
                            Text("Lenoir")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 170)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .scaleEffect(isLenoirPressed ? 2 : 1.0)
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isLenoirPressed = true
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isLenoirPressed = false
                                    }
                                }
                        )
                    }
                    .padding()
                }
                .padding()
            }
        }
    }
}
