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
    @State var isSubmittedViewPresented = true
    @State var isQuitConfirmAlertPresented = false

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
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        navigator.goBackToRoot()
                    }
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
        .alert(isPresented: $isQuitConfirmAlertPresented) {
            Alert(
                title: Text(Localize.surveyQuestionWarningText()),
                message: Text(Localize.surveyQuestionQuitConfirmText()),
                primaryButton: .default(
                    Text(Localize.commonYesText())
                        .font(.regular()),
                    action: {
                        isPresented.wrappedValue.toggle()
                        viewModel.clearQuestionResponse()
                    }
                ),
                secondaryButton: .default(
                    Text(Localize.commonCancelText())
                        .font(.bold())
                )
            )
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
                            isQuitConfirmAlertPresented = true
                        }
                    }))
                    .padding(.top, 20.0)
                    .padding(.trailing, 20.0)
            }
            Spacer()
        }
    }

    private func setUpNextQuestionButton() -> some View {
        let lastItem = selectedQuestionIndex == viewModel.questions.count - 1

        return VStack(alignment: .trailing) {
            Spacer()
            HStack {
                Spacer()
                if lastItem {
                    PrimaryButton(
                        isEnabled: .constant(true),
                        isLoading: false,
                        action: {
                            viewModel.submitQuestionResponse()
                        },
                        title: Localize.surveyQuestionSubmitTitle()
                    )
                    .frame(width: 120.0)
                    .padding(.bottom, 54.0)
                    .padding(.trailing, 20.0)
                } else {
                    Button(String.empty) {}
                        .modifier(RoundNextButtonModifier(action: {
                            selectedQuestionIndex += 1
                        }))
                        .padding(.bottom, 54.0)
                        .padding(.trailing, 20.0)
                }
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
