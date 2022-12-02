//  swiftlint:disable:closure_body_length
//  BannerModifier.swift
//  Surveys
//
//  Created by David Bui on 02/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct BannerModifier: ViewModifier {

    @Binding var data: BannerData
    @Binding var isVisible: Bool

    func body(content: Content) -> some View {
        content.overlay {
            GeometryReader { geometry in
                if isVisible {
                    setUpBanner()
                        .padding(.top, geometry.safeAreaInsets.top + 20.0)
                        .edgesIgnoringSafeArea(.horizontal)
                        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                        .onTapGesture {
                            withAnimation {
                                isVisible = false
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                withAnimation {
                                    isVisible = false
                                }
                            }
                        }
                        .animation(.easeInOut, value: isVisible)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    private func setUpBanner() -> VStack<TupleView<(some View, Spacer)>> {
        return VStack {
            HStack(spacing: 16.0) {
                Assets.notificaitonWhiteIcon.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22.0, height: 22.0)
                VStack(alignment: .leading) {
                    Text(data.title)
                        .font(.bold(ofSize: .small))
                        .foregroundColor(.white)
                    Text(data.detail)
                        .font(.regular(ofSize: .xSmall))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(20.0)
            .background(Colors.mineShaft.color.opacity(0.6))
            Spacer()
        }
    }
}
