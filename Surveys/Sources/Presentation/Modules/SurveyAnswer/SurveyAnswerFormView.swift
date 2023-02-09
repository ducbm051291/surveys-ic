//
//  SurveyAnswerFormView.swift
//  Surveys
//
//  Created by David Bui on 10/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyAnswerFormView: View {

    @State var viewModel: SurveyAnswerViewModel
    @State var formTexts: [String]

    var body: some View {
        VStack(spacing: 16.0) {
            ForEach(viewModel.answers.indices, id: \.self) { index in
                TextField(String.empty, text: $formTexts[index])
                    .modifier(
                        TextFieldFormModifier(
                            isPlaceholderVisible: formTexts[index].isEmpty,
                            placeholder: viewModel.answers[index].text ?? .empty
                        )
                    )
                    .onChange(of: formTexts[index]) { newText in
                        viewModel.answer(index, text: newText)
                    }
                    .tag(index)
            }
        }
    }

    init(viewModel: SurveyAnswerViewModel) {
        self.viewModel = viewModel
        formTexts = [String](repeating: .empty, count: viewModel.answers.count)
    }
}
