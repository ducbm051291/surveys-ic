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

    var body: some View {
        ZStack {
            setUpBackgroundImage()
                .overlay {
                    setUpSurvey()
                }
        }
    }

    private func setUpSurvey() -> some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading, spacing: 16.0) {
                // TODO: Remove dummy data
                Text("Working from home Check-In")
                    .modifier(TextTitleModifier())
                    .lineLimit(2)
                HStack(alignment: .center, spacing: 20.0) {
                    Text("We would like to know how you feel about our work from home...")
                        .modifier(TextDescriptionModifier())
                        .lineLimit(2)
                    Button(String.empty) {}
                        .modifier(RoundNextButtonModifier(action: {}))
                }
            }
            .padding(.bottom, 54.0)
            .frame(height: 200.0)
        }
        .padding(.horizontal, 20.0)
    }

    private func setUpBackgroundImage() -> some View {
        KFImage(URL(string: String.empty))
            .placeholder { _ in
                Assets.surveyBackgroundImage.image
                    .resizable()
                    .scaledToFill()
            }
            .fade(duration: 0.3)
            .overlay {
                Constants.Gradient.surveyBackground.opacity(0.6)
            }
    }
}
