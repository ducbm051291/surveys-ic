//
//  HomeSurveyItemView.swift
//  Surveys
//
//  Created by David Bui on 13/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct HomeSurveyItemView: View {

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
                .padding(.vertical, 20.0)
                Button(String.empty) {}
                    .modifier(RoundNextButtonModifier(action: {}))
                    .padding(.trailing, 20.0)
            }
            .frame(height: 126.0)
            .padding(.bottom, 54.0)
        }
    }

    private func setUpBackgroundImage() -> some View {
        Assets.backgroundImage.image
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
//        AsyncImage(url: URL(string: "")) { phase in
//            switch phase {
//            case .empty:
//                ProgressView()
//                    .hidden()
//            case let .success(image):
//                image
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                    .transition(.opacity)
//            case .failure:
//                Assets.backgroundImage.image
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//            @unknown default:
//                EmptyView()
//            }
//        }
//        .opacity(0.6)
//        .frame(
//            width: UIScreen.main.bounds.width,
//            height: UIScreen.main.bounds.height
//        )
    }
}
