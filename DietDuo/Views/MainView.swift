//
//  MainView.swift
//  DietDuo
//
//  Created by Mikhail Demichev on 13.02.2024.
//
import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                InfoView()
                
                Spacer()
                
                MenuList()
            }
            .ignoresSafeArea(.all)
            .frame(maxHeight: .infinity)
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

