//
//  SurveyQuestionsView.swift
//  Surveys
//
//  Created by David Bui on 05/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Kingfisher
import SwiftUI

struct SurveyQuestionsView: View {

    @EnvironmentObject private var navigator: Navigator

    @ObservedObject var viewModel: SurveyQuestionsViewModel

    @State var selectedQuestionIndex = 0
    @State var isSubmittedViewPresented = false
    @State var scale = 0.5

    var isPresented: Binding<Bool>

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
        case .submitting:
            setUpView(isLoading: true)
        case .submitted:
            setUpView()
                .fullScreenCover(isPresented: $isSubmittedViewPresented) {
                    AnswerSubmittedView()
                }
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

    private func setUpView(isLoading: Bool = false) -> some View {
        ZStack {
            setUpBackground()
            setUpCloseButton()
            setUpNextQuestionButton()
            setUpQuestions()
        }
    }

    private func setUpBackground() -> some View {
        GeometryReader { geometry in
            KFImage(URL(string: viewModel.survey.questions?[selectedQuestionIndex].coverImageUrl ?? .empty))
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

    private func setUpCloseButton() -> some View {
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                Button(String.empty) {}
                    .modifier(RoundCloseButtonModifier(action: {
                        withAnimation {
                            isPresented.wrappedValue.toggle()
                        }
                    }))
                    .padding(.top, 20.0)
                    .padding(.trailing, 20.0)
            }
            Spacer()
        }
    }

    private func setUpNextQuestionButton() -> some View {
        VStack(alignment: .trailing) {
            Spacer()
            HStack {
                Spacer()
                Button(String.empty) {}
                    .modifier(RoundNextButtonModifier(action: {}))
                    .padding(.bottom, 54.0)
                    .padding(.trailing, 20.0)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    private func setUpQuestions() -> some View {
        let questions = Array(viewModel.questions.enumerated())

        return VStack {
            TabView(selection: $selectedQuestionIndex) {
                ForEach(questions, id: \.element.question.id) { question in
                    SurveyQuestionView(viewModel: question.element)
                        .tag(question.offset)
                        .contentShape(Rectangle())
                        .highPriorityGesture(DragGesture())
                        .clipped()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .padding(.top, 60.0)
            .padding(.bottom, 60.0)
        }
    }
}

struct SurveyQuestionsViewPreview: PreviewProvider {

    static var previews: some View {
        SurveyQuestionsView(
            viewModel: SurveyQuestionsViewModel(
                survey: APISurvey(
                    id: .empty,
                    type: .empty,
                    title: .empty,
                    description: .empty,
                    coverImageUrl: .empty,
                    questionList: []
                )
            ),
            isPresented: .constant(true)
        )
    }
}
