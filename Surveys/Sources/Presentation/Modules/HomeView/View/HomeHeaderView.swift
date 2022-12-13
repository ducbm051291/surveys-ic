//
//  HomeHeaderView.swift
//  Surveys
//
//  Created by David Bui on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct HomeHeaderView: View {

    var imageURL: String
    @Binding var isMenuVisible: Bool

    var body: some View {
        VStack {
            Text("Monday, JUNE 15")
                .font(.regular(ofSize: .xSmall))
                .foregroundColor(.white)
                .padding(.bottom, 1.0)
            HStack {
                Text("Today")
                    .font(.bold(ofSize: .xLarge))
                    .foregroundColor(.white)
                Spacer()
                setUpAvatar()
            }
        }
    }

    private func setUpAvatar() -> some View {
        Button(action: {
            withAnimation(.easeIn) {
                isMenuVisible.toggle()
            }
        }, label: {
            AsyncImage(
                url: URL(string: imageURL)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView().hidden()
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                case .failure:
                    Assets.userPlaceholderIcon.image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 36.0, height: 36.0)
        })
        .hidden(withAnimation(.easeIn) { isMenuVisible })
        .padding()
    }
}
