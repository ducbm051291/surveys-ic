//
//  SurveyAnswerMultipleChoiceView.swift
//  Surveys
//
//  Created by David Bui on 09/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyAnswerMultipleChoiceView: View {

    @ObservedObject var viewModel: SurveyAnswerViewModel
    @State var statusChoices: [Bool]
    @State var choices: [String]

    var body: some View {
        VStack {
            ForEach(choices.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 16.0) {
                    HStack(alignment: .center) {
                        Text(choices[index])
                            .font(.bold(ofSize: .medium))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 16.0)
                        Spacer()
                        Button(String.empty) {}
                            .modifier(CheckboxButtonModifier(
                                isChecked: $statusChoices[index],
                                action: {
                                    viewModel.answer(index)
                                }
                            ))
                    }
                    Divider()
                        .background(.white)
                        .frame(height: 0.5)
                }
            }
        }
        .padding(.horizontal, 80.0)
        .edgesIgnoringSafeArea(.all)
    }

    init(viewModel: SurveyAnswerViewModel) {
        self.viewModel = viewModel
        choices = viewModel.answers.map { $0.text ?? .empty }
        statusChoices = viewModel.answers.map { _ in false }
    }
}
