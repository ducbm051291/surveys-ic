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
            VStack(alignment: .leading, spacing: 10.0) {
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
        VStack {
            let displayType = viewModel.question.displayType
            let pickType = viewModel.question.pick

            switch displayType {
            case .star, .heart, .smiley:
                EmptyView()
            case .nps:
                EmptyView()
            case .textarea, .textfield:
                EmptyView()
            case .choice, .dropdown, .intro, .outro:
                switch pickType {
                case .any:
                    EmptyView()
                case .one, .none:
                    SurveyAnswerSingleChoiceView(viewModel: viewModel.answerViewModel)
                }
            }
        }
    }
}
