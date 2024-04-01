//
//  InfoVIew.swift
//  DietDuo
//
//  Created by Mikhail Demichev on 01.04.2024.
//

import SwiftUI

struct InfoView: View {
    @State private var currentProgress: CGFloat = 1120.0
    @State private var isActive = false
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Image("gradient")
                .resizable()
                .cornerRadius(20)
                .frame(height: 330)
            
            VStack {
                HStack {
                    Button {
                        print("")
                    } label: {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .shadow(color: Color.gray, radius: 1, x: 2, y: 1)
                    }.offset(x: -80)
                    
                    Text(getCurrentDate())
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .bold()
                        .offset(x: -5)
                    
                    Button {
                        isActive = true
                    } label: {
                        NavigationLink(destination: PreferencesView(), isActive: $isActive) {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .shadow(color: Color.gray, radius: 1, x: 2, y: 1)
                        }
                    }.offset(x: 80)
                }
                
                ZStack {
                    Circle()
                        .stroke(Color.customGray, lineWidth: 10)
                        .shadow(color: Color.white, radius: 1, x: 2, y: 1)
                        .shadow(color: Color.gray, radius: -1, x: -2, y: -1)
                        .frame(width: 200, height: 200)
                    
                    Circle()
                        .trim(from: 0, to: min(currentProgress / CGFloat(viewModel.calculatedResult), 1.0))
                        .stroke(Color.customGreen, lineWidth: 10)
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear)
                        .shadow(color: Color.white, radius: 0.2, x: 0.2, y: 0.2)
                        .shadow(color: Color.black, radius: 0.5, x: 0.2, y: 0.2)
                    
                    Text("\(formatNumber(Int( CGFloat(viewModel.calculatedResult) - currentProgress)))\nkcal left")
                        .lineSpacing(7)
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(width: 140)
                    
                    HStack {
                        Text("0\ngained")
                        Spacer()
                            .frame(width: 220)
                        Text("\(viewModel.burnedCalories) \nburned")
                    }
                    .font(.system(size: 21))
                    .foregroundColor(.white)
                    .padding()
                    .offset(y: 75)
                    .multilineTextAlignment(.center)
                    .bold()
                }
            }
            .offset(y: 18)
        }
    }
}
func getCurrentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "MMMM d"
    return dateFormatter.string(from: Date())
}

func formatNumber(_ number: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .none
    return formatter.string(from: NSNumber(value: number)) ?? ""
}

struct InfoVIew_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
