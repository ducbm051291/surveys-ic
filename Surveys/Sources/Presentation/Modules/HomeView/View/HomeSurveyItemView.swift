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

    var survey: APISurvey

    var body: some View {
        ZStack {
            setUpBackgroundImage()
                .overlay {
                    setUpSurvey()
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.height
                        )
                }
        }
    }

    private func setUpSurvey() -> some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    // TODO: Remove dummy data
                    Text("Working from home Check-In")
                        .modifier(TextTitleModifier())
                        .lineLimit(2)
                        .padding(.bottom, 16.0)
                    Text("We would like to know how you feel about our work from home...")
                        .modifier(TextDescriptionModifier())
                        .lineLimit(2)
                }
                .padding(.horizontal, 20.0)
                Button(String.empty) {}
                    .modifier(RoundNextButtonModifier(action: {}))
                    .padding(.trailing, 20.0)
            }
            .frame(height: 126.0)
        }
        .padding(.bottom, 54.0)
    }

    private func setUpBackgroundImage() -> some View {
        KFImage(URL(string: survey.id))
            .placeholder { _ in
                Assets.backgroundImage.image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
            .fade(duration: 0.3)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
            .overlay {
                Constants.Gradient.surveyBackground.opacity(0.6)
            }
            .edgesIgnoringSafeArea(.all)
    }
}
