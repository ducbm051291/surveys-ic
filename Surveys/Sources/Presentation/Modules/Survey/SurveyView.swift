//
//  SurveyView.swift
//  Surveys
//
//  Created by David Bui on 28/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Kingfisher
import SwiftUI

struct SurveyView: View {

    @EnvironmentObject private var navigator: Navigator
    @ObservedObject private var viewModel: SurveyViewModel

    @State var isQuestionViewPresented = false

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
                .onAppear {
                    viewModel.loadSurveyDetail()
                }
        case .loading:
            setUpView(isLoading: true)
        case .loaded:
            setUpView()
        case let .error(message):
            setUpView()
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text(Localize.commonApplicationNameText()),
                        message: Text(message),
                        dismissButton: Alert.Button.default(Text(Localize.commonOkText()))
                    )
                }
        }
    }

    init(viewModel: SurveyViewModel) {
        self.viewModel = viewModel
    }

    private func setUpView(isLoading: Bool = false) -> some View {
        ZStack {
            setUpBackground()
            setUpSurvey()
        }
        .fullScreenCover(isPresented: $isQuestionViewPresented) {
            SurveyQuestionsView(
                viewModel: SurveyQuestionsViewModel(survey: viewModel.survey),
                isPresented: $isQuestionViewPresented
            )
        }
        .modifier(NavigationBackButtonModifier(action: {
            navigator.goBack()
        }))
    }

    private func setUpBackground() -> some View {
        GeometryReader { geometry in
            KFImage(viewModel.survey.largeImageURL)
                .placeholder { _ in
                    Assets.surveyBackgroundImage.image
                        .resizable()
                        .scaledToFill()
                }
                .fade(duration: 0.3)
                .resizable()
                .scaledToFill()
                .overlay {
                    Constants.Gradient.surveyBackground.opacity(0.6)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .edgesIgnoringSafeArea(.all)
    }

    private func setUpSurvey() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(viewModel.survey.title)
                .modifier(TextTitleModifier(titleSize: .xLarge))
                .lineLimit(2)
            Text(viewModel.survey.description)
                .modifier(TextDescriptionModifier())
                .lineLimit(2)
            Spacer()
            HStack {
                Spacer()
                PrimaryButton(
                    isEnabled: .constant(true),
                    isLoading: false,
                    action: {
                        withoutAnimation {
                            isQuestionViewPresented = true
                        }
                    },
                    title: Localize.surveyStartSurveyTitle()
                )
                .frame(width: 140.0)
            }
        }
        .padding(.top, 20.0)
        .padding(.horizontal, 20.0)
        .padding(.bottom, 54.0)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SurveyViewPreview: PreviewProvider {

    static var previews: some View {
        SurveyView(viewModel: SurveyViewModel(survey: APISurvey(
            id: .empty,
            type: .empty,
            title: .empty,
            description: .empty,
            coverImageUrl: .empty,
            questionList: []
        )))
    }
}
