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
        let answerViewModel = SurveyAnswerViewModel(question: viewModel.question)
        return VStack {
            Spacer()
            switch displayType {
            case .star, .heart, .smiley:
                SurveyAnswerRatingView(viewModel: answerViewModel)
            case .nps:
                SurveyAnswerNPSView(viewModel: answerViewModel)
            case .textarea:
                SurveyAnswerTextAreaView()
            case .textfield:
                SurveyAnswerFormView(viewModel: answerViewModel)
            case .choice, .dropdown:
                switch pickType {
                case .any:
                    SurveyAnswerMultipleChoiceView(viewModel: answerViewModel)
                case .one, .none:
                    SurveyAnswerSingleChoiceView(viewModel: answerViewModel)
                }
            case .intro, .outro:
                EmptyView()
            }
            Spacer()
        }
    }
}
