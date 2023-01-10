//
//  SurveyQuestionView.swift
//  Surveys
//
//  Created by David Bui on 05/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyQuestionView: View {

    @ObservedObject var viewModel: SurveyQuestionViewModel

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(viewModel.questionIndex)
                    .font(.regular(ofSize: .small))
                    .foregroundColor(.white.opacity(0.5))
                Text(viewModel.questionText)
                    .font(.bold(ofSize: .xLarge))
                    .foregroundColor(.white)
                setUpAnswer()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
            }
            .padding(.horizontal, 20.0)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

extension SurveyQuestionView {

    private func setUpAnswer() -> some View {
        let displayType = viewModel.question.displayType
        let pickType = viewModel.question.pick
        let answers = viewModel.question.answers ?? []
        return VStack {
            Spacer()
            switch displayType {
            case .star, .heart, .smiley:
                SurveyAnswerRatingView(displayType: displayType)
            case .nps:
                SurveyAnswerNPSView()
            case .textarea:
                EmptyView()
            case .textfield:
                SurveyAnswerFormView(answers: answers.map { $0.text ?? .empty })
            case .choice, .dropdown:
                switch pickType {
                case .any:
                    SurveyAnswerMultipleChoiceView(answers: answers.map { $0.text ?? .empty })
                case .one, .none:
                    SurveyAnswerSingleChoiceView(answers: answers.map { $0.text ?? .empty })
                }
            case .intro, .outro:
                EmptyView()
            }
            Spacer()
        }
    }
}
