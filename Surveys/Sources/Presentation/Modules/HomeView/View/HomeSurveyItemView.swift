//
//  HomeSurveyItemView.swift
//  Surveys
//
//  Created by David Bui on 13/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Kingfisher
import SwiftUI

struct HomeSurveyItemView: View {

    var survey: Survey
    var action: () -> Void

    var body: some View {
        ZStack {
            setUpBackgroundImage()
            setUpSurvey()
        }
    }

    private func setUpSurvey() -> some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 16.0) {
                Text(survey.title)
                    .modifier(TextTitleModifier())
                    .lineLimit(2)
                HStack(alignment: .center, spacing: 20.0) {
                    Text(survey.description)
                        .modifier(TextDescriptionModifier())
                        .lineLimit(2)
                    Spacer()
                    Button(String.empty) {}
                        .modifier(RoundNextButtonModifier(action: action))
                }
            }
            .padding(.bottom, 54.0)
            .frame(height: 200.0)
        }
        .padding(.horizontal, 20.0)
    }

    private func setUpBackgroundImage() -> some View {
        GeometryReader { geometry in
            KFImage(URL(string: survey.coverImageUrl))
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
}
