//
//  SurveyAnswerNPSView.swift
//  Surveys
//
//  Created by David Bui on 10/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyAnswerNPSView: View {

    @State var rating: Int = 0
    private let maximumRating = 10
    private let horizontalPadding: CGFloat = 20.0
    private let dividerWidth: CGFloat = 0.5

    var body: some View {
        VStack {
            setUpNPS()
            setUpDescription()
        }
        .padding(.horizontal, horizontalPadding)
    }

    private func setUpNPS() -> some View {
        GeometryReader { geometry in
            HStack(spacing: .zero) {
                ForEach(0 ..< maximumRating, id: \.self) { index in
                    setUpNPSPoint(index, width: geometry.size.width)
                        .tag(index)
                }
            }
            .frame(height: Constants.View.defaultHeight)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(.white, lineWidth: dividerWidth)
                    .frame(height: Constants.View.defaultHeight)
            )
        }
        .frame(height: Constants.View.defaultHeight)
        .edgesIgnoringSafeArea(.all)
    }

    private func setUpNPSPoint(_ index: Int, width: CGFloat) -> some View {
        HStack(spacing: .zero) {
            Text("\(index + 1)")
                .font(getRatingFontOf(index))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .opacity(getRatingOpacityOf(index))
                .onTapGesture {
                    rating = index + 1
                }
                .frame(
                    width: calculatePointWidth(width: width),
                    height: dividerWidth
                )
            if index < maximumRating - 1 {
                Divider()
                    .background(.white)
                    .frame(
                        width: dividerWidth,
                        height: Constants.View.defaultHeight
                    )
            }
        }
    }

    private func setUpDescription() -> some View {
        HStack {
            Text(Localize.npsQuestionNotAtAllLikelyText())
                .font(.bold())
                .foregroundColor(.white.opacity(0.5))
            Spacer()
            Text(Localize.npsQuestionExtremelyLikelyText())
                .font(.bold())
                .foregroundColor(.white)
        }
        .frame(height: 22.0)
        .padding(.top, 16.0)
    }

    private func calculatePointWidth(width: CGFloat) -> CGFloat {
        width / CGFloat(maximumRating) - dividerWidth
    }
}

extension SurveyAnswerNPSView {

    private func getRatingFontOf(_ index: Int) -> Font {
        index >= rating ? .regular(ofSize: .medium) : .bold(ofSize: .medium)
    }

    private func getRatingOpacityOf(_ index: Int) -> Double {
        index >= rating ? 0.5 : 1.0
    }
}
