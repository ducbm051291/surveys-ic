//
//  HomeHeaderView.swift
//  Surveys
//
//  Created by David Bui on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Kingfisher
import SwiftUI

struct HomeHeaderView: View {

    var imageURL: String
    @Binding var isMenuVisible: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            // TODO: Remove dummy data
            Text("Monday, JUNE 15")
                .font(.bold(ofSize: .xSmall))
                .foregroundColor(.white)
            HStack(alignment: .center) {
                Text("Today")
                    .font(.bold(ofSize: .xLarge))
                    .foregroundColor(.white)
                Spacer()
                setUpAvatar()
            }
            .frame(height: 36.0)
        }
    }

    private func setUpAvatar() -> some View {
        Button(action: {
            withAnimation(.easeIn) {
                isMenuVisible.toggle()
            }
        }, label: {
            KFImage(URL(string: imageURL))
                .onFailureImage(Assets.userPlaceholderIcon())
                .placeholder { _ in
                    Circle().foregroundColor(.black)
                }
                .fade(duration: 0.3)
                .frame(width: 36.0, height: 36.0)
        })
        .padding()
    }
}
