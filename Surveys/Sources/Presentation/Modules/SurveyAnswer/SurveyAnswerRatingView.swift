//
//  SurveyAnswerRatingView.swift
//  Surveys
//
//  Created by David Bui on 06/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyAnswerRatingView: View {

    @ObservedObject var viewModel: SurveyAnswerViewModel
    @State var rating: Int = 0
    private let maximumRating = 5
    private var ratingItems: [String]

    var body: some View {
        HStack(alignment: .center, spacing: 20.0) {
            ForEach(0 ..< maximumRating, id: \.self) { index in
                Text(ratingItems[index])
                    .font(.regular(ofSize: .large))
                    .opacity(getRatingOpacityOf(index))
                    .onTapGesture {
                        rating = index + 1
                    }
                    .onChange(of: rating) { index in
                        viewModel.handleSingleAnswer(index)
                    }
                    .frame(width: 28.0, height: 34.0)
                    .tag(index)
            }
        }
    }

    init(viewModel: SurveyAnswerViewModel) {
        self.viewModel = viewModel
        switch viewModel.displayType {
        case .smiley:
            ratingItems = ["😡", "😕", "😐", "🙂", "😄"]
        case .heart:
            ratingItems = Array(repeating: "❤️", count: maximumRating)
        case .star:
            ratingItems = Array(repeating: "⭐️", count: maximumRating)
        default:
            ratingItems = Array(repeating: "👍🏻", count: maximumRating)
        }
    }
}

extension SurveyAnswerRatingView {

    private func getRatingOpacityOf(_ index: Int) -> Double {
        switch viewModel.displayType {
        case .smiley:
            return index == rating - 1 ? 1.0 : 0.5
        default:
            return index >= rating ? 0.5 : 1.0
        }
    }
}
