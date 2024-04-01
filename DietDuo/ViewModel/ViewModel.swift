//
//  ViewModel.swift
//  DietDuo
//
//  Created by Mikhail Demichev on 13.02.2024.
//

import SwiftUI

class ViewModel: ObservableObject {
  
    @AppStorage("calculatedResult") var calculatedResult: Int = 0
    @AppStorage("recomendedBreakfastCalories") var recomendedBreakfastCalories: String = "0"
    @AppStorage("recomendedLunchCalories") var recomendedLunchCalories: String = "0"
    @AppStorage("recomendedDinnerCalories") var recomendedDinnerCalories: String = "0"
    @AppStorage("recomendedSnackCalories") var recomendedSnackCalories: String = "0"
    @AppStorage("burnedCalories") var burnedCalories: Int = 0
    
    func calculateRecommendations() -> Void {
           let breakfastLowerBound = (calculatedResult / 100) * 25
           let breakfastUpperBound = (calculatedResult / 100) * 30
           recomendedBreakfastCalories = "\(breakfastLowerBound) - \(breakfastUpperBound)"

           let lunchLowerBound = (calculatedResult / 100) * 30
           let lunchUpperBound = (calculatedResult / 100) * 35
           recomendedLunchCalories = "\(lunchLowerBound) - \(lunchUpperBound)"

           let dinnerLowerBound = (calculatedResult / 100) * 20
           let dinnerUpperBound = (calculatedResult / 100) * 25
           recomendedDinnerCalories = "\(dinnerLowerBound) - \(dinnerUpperBound)"

           let snackLowerBound = (calculatedResult / 100) * 10
           let snackUpperBound = (calculatedResult / 100) * 15
           recomendedSnackCalories = "\(snackLowerBound) - \(snackUpperBound)"
       }
   
    func dailyСalorieСalculator(userAge: Int, userHeight: Int, userWeight: Int, userGender: Int, userGoal: Int) -> CGFloat {
        var resultWeight = 0
        var resultHight = 0
        var resultAge = 0
        var result = 0
        let userSettingsTuple = (age: userAge,
                                 hight: userHeight,
                                 weight: userWeight,
                                 gender: userGender,
                                 goal: userGoal)
        switch userSettingsTuple {
            case (_, _, _, 0, 0):
                resultWeight = userSettingsTuple.weight * 24
                resultHight = userSettingsTuple.hight * 8
                resultAge = userSettingsTuple.age * 6
                result = resultWeight + resultHight - resultAge - 180
            case (_, _, _ ,0 ,1):
                resultWeight = userSettingsTuple.weight * 14
                resultHight = userSettingsTuple.hight * 8
                resultAge = userSettingsTuple.age * 6
                result = resultWeight + resultHight - resultAge - 161
            case (_, _, _, 0, 2):
                resultWeight = userSettingsTuple.weight * 19
                resultHight = userSettingsTuple.hight * 8
                resultAge = userSettingsTuple.age * 6
                result = resultWeight + resultHight - resultAge - 170
            case (_, _, _, 1, 0):
                resultWeight = userSettingsTuple.weight * 20
                resultHight = userSettingsTuple.hight * 7
                resultAge = userSettingsTuple.age * 5
                result = resultWeight + resultHight - resultAge - 180
            case (_, _, _, 1, 1):
                resultWeight = userSettingsTuple.weight * 10
                resultHight = userSettingsTuple.hight * 7
                resultAge = userSettingsTuple.age * 5
                result = resultWeight + resultHight - resultAge - 161
            case (_, _, _, 1, 2):
            resultWeight = userSettingsTuple.weight * 15
            resultHight = userSettingsTuple.hight * 7
            resultAge = userSettingsTuple.age * 5
            result = resultWeight + resultHight - resultAge - 170
        default: break
        }
        self.calculatedResult = result
        return CGFloat(result)
    }
    
    func activityResult (chosenActivity: String, duration: Int) -> Int {
        var result = 0
        
        switch chosenActivity {
            case "Aerobics":
                result = duration * (420/60)
            case "Yoga":
                result = duration * (220/60)
            case "Jumping rope":
                result = duration * (600/60)
            case "Swimming":
                result = duration * (230/60)
            case "Workout in the gym":
                result = duration * (520/60)
            case "Walking":
                result = duration * (350/60)
            case "Running":
                result = duration * (500/60)
            default:
                break
            }
        
           return result
        }
}

