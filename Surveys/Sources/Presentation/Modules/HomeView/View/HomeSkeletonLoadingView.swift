//
//  HomeSkeletonLoadingView.swift
//  Surveys
//
//  Created by David Bui on 14/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import ShimmerView
import SwiftUI

struct HomeSkeletonLoadingView: View {

    var body: some View {
        ShimmerScope(style: ShimmerViewStyle.common, isAnimating: .constant(true)) {
            VStack(alignment: .leading) {
                setUpHeaderComponents()
                Spacer()
                ShimmerElement(width: 50.0, height: 20.0)
                    .cornerRadius(14.0)
                ShimmerElement(width: 250.0, height: 20.0)
                    .cornerRadius(14.0)
                ShimmerElement(width: 117.0, height: 20.0)
                    .cornerRadius(14.0)
                    .padding(.bottom, 16.0)
                ShimmerElement(width: 300.0, height: 20.0)
                    .cornerRadius(14.0)
                ShimmerElement(width: 200.0, height: 20.0)
                    .cornerRadius(14.0)
            }
        }
        .padding(.vertical, 62.0)
        .padding(.horizontal, 20.0)
        .edgesIgnoringSafeArea(.all)
        .background(.black)
    }

    private func setUpHeaderComponents() -> some View {
        HStack {
            VStack(alignment: .leading) {
                ShimmerElement(width: 117.0, height: 20.0)
                    .foregroundColor(.black)
                    .cornerRadius(14.0)
                ShimmerElement(width: 100.0, height: 20.0)
                    .cornerRadius(14.0)
            }
            Spacer()
            ShimmerElement(width: 36.0, height: 36.0)
                .cornerRadius(18.0)
        }
    }
}

struct HomeSkeletonLoadingViewPreView: PreviewProvider {

    static var previews: some View {
        HomeSkeletonLoadingView()
    }
}
