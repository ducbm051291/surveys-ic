//
//  SurveyAnswerTextAreaView.swift
//  Surveys
//
//  Created by David Bui on 10/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyAnswerTextAreaView: View {

    @State var text: String = .empty

    var body: some View {
        VStack {
            TextEditor(text: $text)
                .modifier(
                    TextEditorFormModifier(
                        isPlaceholderVisible: text.isEmpty,
                        placeholder: Localize.textAreaQuestionYourThoughtsText()
                    )
                )
                .scrollContentBackground(.hidden)
                .font(.regular())
                .background(.white.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .onAppear {
                    UITextView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITextView.appearance().backgroundColor = nil
                }
        }
    }
}
