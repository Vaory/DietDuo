//
//  MenuListView.swift
//  DietDuo
//
//  Created by Mikhail Demichev on 13.02.2024.
//

import SwiftUI

struct MealCellModel: Identifiable, Hashable {
    let id = UUID()
    let image: String
    let title: String
    let recommendedMealCalories: String
    let receivedCalories: String
   
}

struct MenuList: View {
    var viewModel = ViewModel()
    var mealList: [MealCellModel]
    
    init() {
        self.mealList = [
            .init(image: "egg_3274259", title: "Breakfast", recommendedMealCalories: "Recommended: \(viewModel.recomendedBreakfastCalories) kcal", receivedCalories: "Received: 0"),
            .init(image: "hot-soup_2387954", title: "Lunch", recommendedMealCalories: "Recommended: \(viewModel.recomendedLunchCalories) kcal", receivedCalories: "Received: 0"),
            .init(image: "meal_3274083", title: "Dinner", recommendedMealCalories: "Recommended: \(viewModel.recomendedDinnerCalories) kcal", receivedCalories: "Received: 0"),
            .init(image: "apple_3274198", title: "Snack", recommendedMealCalories: "Recommended: \(viewModel.recomendedSnackCalories) kcal", receivedCalories: "Received: 0"),
            .init(image: "calories", title: "Activities", recommendedMealCalories: "Recommended: 45 min", receivedCalories: "")
        ]
    }
    
    @State private var selectedMeal: MealCellModel?
    
    var body: some View {
       
            List {
                ForEach(mealList, id: \.id) { meal in
                    if meal.title == "Activities" {
                        ActivityCellView(meal: meal)
                    } else {
                        NavigationLink(destination: AddMealsView(mealModel: meal), tag: meal, selection: $selectedMeal) {
                            makeMealCellView(meal: meal)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Back to meals", displayMode: .inline)
            .navigationBarHidden(true)
        
    }
    
    func makeMealCellView(meal: MealCellModel) -> some View {
        HStack {
            Image(meal.image)
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(meal.title)
                    .font(.headline)
                Text(meal.recommendedMealCalories)
                    .font(.subheadline)
                Text(meal.receivedCalories)
                    .font(.subheadline)
            }
        }.frame(height: 70)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MenuList()
        }
    }
}

struct ActivityCellView: View {
    var meal: MealCellModel
    
    var body: some View {
        NavigationLink(destination: AddActivitiesView()) {
            makeMealCellView(meal: meal)
        }
    }
    
    func makeMealCellView(meal: MealCellModel) -> some View {
        HStack {
            Image(meal.image)
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(meal.title)
                    .font(.headline)
                Text(meal.recommendedMealCalories)
                    .font(.subheadline)
                Text(meal.receivedCalories)
                    .font(.subheadline)
            }
        }.frame(height: 70)
    }
}
