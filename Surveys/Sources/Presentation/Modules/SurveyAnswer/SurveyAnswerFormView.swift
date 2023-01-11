//
//  SurveyAnswerFormView.swift
//  Surveys
//
//  Created by David Bui on 10/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyAnswerFormView: View {

    @State var questions: [String]
    @State var responses: [String]

    var body: some View {
        VStack(spacing: 16.0) {
            ForEach(questions.indices, id: \.self) { index in
                TextField(String.empty, text: $responses[index])
                    .modifier(
                        TextFieldFormModifier(
                            isPlaceholderVisible: responses[index].isEmpty,
                            placeholder: questions[index]
                        )
                    )
                    .tag(index)
            }
        }
    }

    init(answers: [String]) {
        questions = answers
        responses = answers.map { _ in String.empty }
    }
}

extension SurveyAnswerNPSView {

    private func getRatingFontOf(_ index: Int) -> Font {
        index >= rating ? .regular(ofSize: .medium) : .bold(ofSize: .medium)
    }

    private func getRatingOpacityOf(_ index: Int) -> Double {
        index >= rating ? 0.5 : 1.0
    }
}
