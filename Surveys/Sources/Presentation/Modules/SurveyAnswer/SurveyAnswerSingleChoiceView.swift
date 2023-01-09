//
//  SurveyAnswerSingleChoiceView.swift
//  Surveys
//
//  Created by David Bui on 05/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

import SwiftUI

struct SurveyAnswerSingleChoiceView: View {

    @Binding var selectedChoice: String
    @State private var choices: [String]

    var body: some View {
        ZStack {
            Picker(String.empty, selection: $selectedChoice) {
                ForEach(choices, id: \.self) { choice in
                    VStack(alignment: .center) {
                        Text(choice)
                            .font(.bold(ofSize: .medium))
                            .foregroundColor(.white)
                        Divider()
                            .background(.white)
                            .frame(height: 0.5)
                    }
                    .padding(.horizontal, 80.0)
                }
            }
            .pickerStyle(.wheel)
        }
    }

    init(choices: [String], selectedChoice: Binding<String>) {
        self.choices = choices
        _selectedChoice = selectedChoice
    }
}
