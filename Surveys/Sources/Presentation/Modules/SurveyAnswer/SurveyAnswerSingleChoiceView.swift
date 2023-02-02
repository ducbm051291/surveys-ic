//
//  SurveyAnswerSingleChoiceView.swift
//  Surveys
//
//  Created by David Bui on 05/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyAnswerSingleChoiceView: View {

    @ObservedObject var viewModel: SurveyAnswerViewModel
    @State private var choices: [String]
    @State var selectedChoiceIndex: Int = 0

    var body: some View {
        ZStack {
            Picker(String.empty, selection: $selectedChoiceIndex) {
                ForEach(choices.indices, id: \.self) { index in
                    VStack(alignment: .center) {
                        Text(choices[index])
                            .font(.bold(ofSize: .medium))
                            .foregroundColor(.white)
                        Divider()
                            .background(.white)
                            .frame(height: 0.5)
                    }
                    .tag(index)
                    .padding(.horizontal, 80.0)
                }
            }
            .onChange(of: selectedChoiceIndex) { index in
                viewModel.answer(index)
            }
            .pickerStyle(.wheel)
        }
    }

    init(viewModel: SurveyAnswerViewModel) {
        self.viewModel = viewModel
        choices = viewModel.answers.map { $0.text ?? .empty }
    }
}
