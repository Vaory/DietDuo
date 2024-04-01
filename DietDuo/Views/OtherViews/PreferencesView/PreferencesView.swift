//
//  PreferencesView.swift
//  DietDuo
//
//  Created by Mikhail Demichev on 13.02.2024.
//

import SwiftUI

struct PreferencesView: View {
    
    @AppStorage("userAge") private var userAgeText = ""
    @AppStorage("userHeight") private var userHeightText = ""
    @AppStorage("userWeight") private var userWeightText = ""
    @AppStorage("userGender") private var userGender = 0
    @AppStorage("userGoal") private var userGoal = 0
    
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = ViewModel()
    
    let genders = ["Male", "Female"]
        let goals = ["Gain", "Loss", "Hold"]
    
    var userAge: Int {
           Int(userAgeText) ?? 0
       }
       
       var userHeight: Int {
           Int(userHeightText) ?? 0
       }
       
       var userWeight: Int {
           Int(userWeightText) ?? 0
       }
       

    
    var body: some View {
        ZStack {
            Image("gradient")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                ZStack {
                    Image("DD-LOGO-WHITE")
                        .resizable()
                        .frame(width: 85, height: 87)
                        .offset(x: 150, y: -21)
                    
                    Text("my parameters")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.center)
                    
                }
                .offset(x: -17, y: -15)
             
                VStack(alignment: .leading, spacing: 15) {
                    Text("Enter your age:")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .opacity(0.8)

                    TextField("Enter your full age", text: $userAgeText)
                        .foregroundColor(.black)
                        .bold()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .opacity(0.6)
                        
                    Text("Enter your height:")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .opacity(0.8)

                    TextField("Enter your height in cm.", text: $userHeightText)
                        .foregroundColor(.black)
                        .bold()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .opacity(0.6)

                    
                    Text("Enter your weight:")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .opacity(0.8)

                    TextField("Enter your weight in kg.", text: $userWeightText)
                        .foregroundColor(.black)
                        .bold()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .opacity(0.6)

                      
                    Text("Select your gender:")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .opacity(0.8)
                    
                    CustomSegmentedControl(options: genders, selectedOption: $userGender)
                    
                    Text("Select your weight goal:")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .opacity(0.8)
                    
                    CustomSegmentedControl(options: goals, selectedOption: $userGoal)
                                    
                }
                .padding(10)
                .cornerRadius(10)
                
                Spacer()
                    .frame(height: 70)
                
                Button(action: {
                                if userAge != 0 && userHeight != 0 && userWeight != 0 {
                                    showAlert = false
                                    viewModel.dailyСalorieСalculator(userAge: userAge, userHeight: userHeight, userWeight: userWeight, userGender: userGender, userGoal: userGoal)
                                    viewModel.calculateRecommendations()
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    showAlert = true
                                }
                            }) {
                                Text("Save")
                                    .bold()
                                    .frame(width: 250, height: 35)
                                    .background(Color.customOrange)
                                    
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .cornerRadius(10)
                            }
                            .shadow(color: .white, radius: 0.2, x: -0.5, y: -0.5)
                            .shadow(color: .customGray, radius: 0.1, x: 0.1, y: 0.1)
                            .padding(4)
                            .offset(y: 10)
                            
                        
                            
                        }
            .padding(4)
            .offset(y: 10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Empty Fields"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.customGreen)
    }
    
}
    
struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
