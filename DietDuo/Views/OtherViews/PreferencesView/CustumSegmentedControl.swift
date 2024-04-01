//
//  CustumSegmentedControl.swift
//  DietDuo
//
//  Created by Mikhail Demichev on 13.02.2024.
//

import SwiftUI

struct CustomSegmentedControl: View {
    let options: [String]
    @Binding var selectedOption: Int

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<options.count) { index in
                Button(action: {
                    self.selectedOption = index
                }) {
                    Text(options[index])
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .padding(1)
                        .foregroundColor(index == selectedOption ? Color.black : Color.white)
                        .bold()
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(index == selectedOption ? Color.white : Color.customGray)
                               
                        )
                        .opacity(0.6)
                }
            }
        }
    }
}
