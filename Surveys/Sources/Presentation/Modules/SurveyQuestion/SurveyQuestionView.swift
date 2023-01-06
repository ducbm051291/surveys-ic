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
    @State var rating: Int = 0
    @State var selectedChoice: String = .empty

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
        VStack {
            let displayType = viewModel.question.displayType
            let pickType = viewModel.question.pick
            Spacer()
            switch displayType {
            case .star, .heart, .smiley:
                SurveyAnswerRatingView(displayType: viewModel.question.displayType, rating: $rating)
            case .nps:
                EmptyView()
            case .textarea, .textfield:
                EmptyView()
            case .choice, .dropdown:
                switch pickType {
                case .any:
                    EmptyView()
                case .one, .none:
                    SurveyAnswerSingleChoiceView(
                        choices: viewModel.question.answers?.map { $0.text ?? .empty } ?? [],
                        selectedChoice: $selectedChoice
                    )
                }
            case .intro, .outro:
                EmptyView()
            }
            Spacer()
        }
    }
}
