//
//  AddMealsView.swift
//  DietDuo
//
//  Created by Mikhail Demichev on 13.02.2024.
//

import SwiftUI

struct AddMealsView: View {
    
    var mealModel: MealCellModel
    @State private var textValue: String = ""
    @State private var weightValue: Int = 250
    @State private var weightOptions = Array(stride(from: 0, through: 1000, by: 25))
    @State private var mealsList: [String] = []
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ZStack {
                Image("gradient")
                    .resizable()
                    .frame(width: .infinity, height: 360)
                    .cornerRadius(20)
                
                VStack(alignment: .leading) {
                    VStack {
                        HStack {
                            Image(mealModel.image)
                                .resizable()
                                .frame(width: 70, height: 70)
                            
                            VStack (alignment: .leading) {
                                Text("Add \(mealModel.title)")
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Text("\(mealModel.recommendedMealCalories)")
                                    .foregroundColor(.white)
                                    .bold()
                                
                                Text("\(mealModel.receivedCalories)")
                                    .foregroundColor(.white)
                                
                             
                                           
                            }
                            Button(action: {
                                           presentationMode.wrappedValue.dismiss()
                                       }) {
                                          
                                             Image(systemName: "xmark")
                                               .resizable()
                                               .frame(width: 25, height: 25)
                                               .foregroundColor(.white)

                                       }.offset(x: -20, y: -30)
                        }
                        
                        VStack {
                            TextField("Search food", text: $textValue)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .cornerRadius(10)
                                .padding(0)
                                .opacity(0.8)
                            
                            ZStack {
                                Text("Select weight:")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                                    .opacity(1)
                                    .offset(x: -110)
                                
                                Picker("Select weight:", selection: $weightValue) {
                                    ForEach(weightOptions, id: \.self) { weight in
                                        Text("\(weight) g")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .bold()
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 375, height: 100)
                                .onAppear {
                                    weightValue = 250
                                }
                            } .offset(y: -20)
                            

                            Button {
                                let activity = "\(textValue) / \(weightValue) g / 0 kcal"
                                mealsList.append(activity)
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Add")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                    .fontWeight(.bold)
                            }
                            .frame(width: 200, height: 35)
                            .foregroundColor(.white)
                            .background(Color.customOrange)
                            .cornerRadius(10)
                            .shadow(color: .white, radius: 0.2, x: -0.5, y: -0.5)
                            .shadow(color: .customGray, radius: 0.1, x: 0.1, y: 0.1)
                            .offset(y: -30)
                        }
                    }
                } .offset(y: 35)
            }
            
            List {
                ForEach(mealsList, id: \.self) { activity in
                    HStack {
                        Text(activity)
                            .foregroundColor(.gray)
                            .bold()
                            .frame(height: 40)
                        Spacer()
                        
                        Button(action: {
                            if let index = mealsList.firstIndex(of: activity) {
                                mealsList.remove(at: index)
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.orange)
                                .offset(x: -10)
                        }
                    }
                }
                .onDelete { indexSet in
                    mealsList.remove(atOffsets: indexSet)
                }
            } .listStyle(.plain)
              
 
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            AddMealsView(mealModel: .init(image: "egg_3274259", title: "Breakfast", recommendedMealCalories: "Recommended: 650 - 780 kcal", receivedCalories: "Received: 340"))
        }
    }
}

    
