//
//  AddActiviteisView.swift
//  DietDuo
//
//  Created by Mikhail Demichev on 13.02.2024.
//

import SwiftUI

struct AddActivitiesView: View {
    
   @StateObject var viewModel = ViewModel()
    @AppStorage("activityList") private var activityListData: Data = Data()
    @State private var activityValue: String = ""
    @State private var durationValue: Int = 250
    @State private var durationOptions = Array(stride(from: 0, through: 120, by: 5))
    @State private var activitiesList = ["Aerobics", "Yoga", "Jumping rope", "Swimming", "Workout in the gym", "Walking", "Running"]
    @State private var caloriesPerActivity: Int = 0
    @State private var activityList: [String] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ZStack {
                Image("gradient")
                    .resizable()
                    .frame(width: .infinity, height: 390)
                    .cornerRadius(20)

                VStack(alignment: .leading) {
                    VStack {
                        HStack {
                            Image("calories")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .offset(x:-10)

                            VStack(alignment: .leading) {
                                Text("Add activities")
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                    .font(.title)
                                    .foregroundColor(.white)

                                Text("Recomended: 45 min")
                                    .foregroundColor(.white)
                                    .bold()

                                Button(action: {
                                    
                                    presentationMode.wrappedValue.dismiss()
                                    
                                }) {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.white)
                                }.offset(x: 220, y: -70)
                            }.offset(y: 20)
                        }.offset(x: -40)

                        VStack {
                            ZStack {
                                Text("Activity:")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                                    .opacity(1)
                                    .offset(x: -135)

                                Picker("Activity:", selection: $activityValue) {
                                      ForEach(activitiesList, id: \.self) { activity in
                                          Text("\(activity) ")
                                              .foregroundColor(.white)
                                              .font(.title3)
                                              .bold()
                                      }
                                  }
                                  .pickerStyle(WheelPickerStyle())
                                  .frame(width: 375, height: 100)
                                  .onAppear {
                                      activityValue = "Aerobics"
                                  }
                              } .offset(y: -20)
                            
                            ZStack {
                                Text("Duration:")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                                    .opacity(1)
                                    .offset(x: -130)

                                Picker("Duration:", selection: $durationValue) {
                                    ForEach(durationOptions, id: \.self) { weight in
                                        Text("\(weight) min")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .bold()
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 375, height: 100)
                                .onAppear {
                                    durationValue = 25
                                }
                            } .offset(y: -35)

                            Button {
                                caloriesPerActivity = viewModel.activityResult(chosenActivity: self.activityValue, duration: self.durationValue)
                                let activity = "\(self.activityValue) / \(durationValue) min / \(caloriesPerActivity) kcal"
                                
                                activityList.append(activity)
                                
                                viewModel.burnedCalories += caloriesPerActivity
                                
                              
                                
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Add")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
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
                } .offset(y: 25)
            }
            List {
                        ForEach(activityList, id: \.self) { activity in
                            HStack {
                                Text(activity)
                                    .foregroundColor(.gray)
                                    .bold()
                                    .frame(height: 40)

                                Spacer()

                                Button(action: {
                                    if let index = activityList.firstIndex(of: activity) {
                                        let components = activity.components(separatedBy: " ")
                                        if components.count >= 4, let calories = Int(components[components.count - 2]) {
                                            viewModel.burnedCalories -= calories
                                        }
                                        activityList.remove(at: index)
                                        saveActivityList()
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.orange)
                                        .offset(x: -10)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let activity = activityList[index]
                                let components = activity.components(separatedBy: " ")
                                if components.count >= 4, let calories = Int(components[components.count - 2]) {
                                    viewModel.burnedCalories -= calories
                                }
                            }
                            activityList.remove(atOffsets: indexSet)
                            
                        }
                    } .listStyle(.inset)

                }
                .onDisappear {
                    saveActivityList()
                    
                }
                .onAppear {
                    loadActivityList()
                   
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            }

            private func saveActivityList() {
                do {
                    let data = try JSONEncoder().encode(activityList)
                    activityListData = data
                } catch {
                    print("Failed to encode activityList: \(error)")
                }
            }

            private func loadActivityList() {
                do {
                    let decodedList = try JSONDecoder().decode([String].self, from: activityListData)
                    activityList = decodedList
                } catch {
                    print("Failed to decode activityList: \(error)")
                }
            }
        }

           struct AddActivitiesView_Previews: PreviewProvider {
               static var previews: some View {
                   AddActivitiesView()
               }
           }
