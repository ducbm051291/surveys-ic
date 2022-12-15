//
//  HomeUserMenuView.swift
//  Surveys
//
//  Created by David Bui on 14/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Kingfisher
import SwiftUI

struct HomeUserMenuView: View {

    @State var isConfirmAlertVisible: Bool = false
    @Binding var isVisible: Bool

    var body: some View {
        HStack {
            setUpSpaceView()
            setUpMenu()
                .overlay {
                    setUpVersion()
                }
                .padding()
                .frame(width: 240.0)
                .background(Colors.eerieBlack.color)
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $isConfirmAlertVisible) {
            Alert(
                title: Text(Localize.commonApplicationNameText()),
                message: Text(Localize.homeLogOutConfirmText()),
                primaryButton: .destructive(
                    Text(Localize.commonOkText()),
                    // TODO: Update log out action
                    action: { isConfirmAlertVisible = false }
                ),
                secondaryButton: .default(
                    Text(Localize.commonCancelText()),
                    action: { isConfirmAlertVisible = false }
                )
            )
        }
    }

    private func setUpAvatarButton() -> some View {
        Button(action: {}, label: {
            KFImage(URL(string: .empty))
                .placeholder { _ in
                    Assets.userPlaceholderIcon.image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                }
                .fade(duration: 0.3)
                .frame(width: 36.0, height: 36.0)
        })
        .padding()
    }

    private func setUpMenu() -> some View {
        VStack {
            HStack(alignment: .center) {
                // TODO: Remove dummy data
                Text("Mai")
                    .font(.bold(ofSize: .xLarge))
                    .foregroundColor(.white)
                Spacer()
                setUpAvatarButton()
            }
            .padding(.top, 40.0)
            Divider()
                .background(.white)
                .frame(height: 0.5)
            HStack {
                Button(Localize.homeLogOutText()) {
                    isConfirmAlertVisible.toggle()
                }
                .font(.regular(ofSize: .medium))
                .foregroundColor(.white)
                .opacity(0.5)
                Spacer()
            }
            .padding(.top, 35.0)
            Spacer()
        }
    }

    private func setUpSpaceView() -> some View {
        ZStack {
            Color.black.opacity(0.0)
            Rectangle()
                .frame(
                    width: UIScreen.main.bounds.width - 240.0,
                    height: UIScreen.main.bounds.height
                )
                .blendMode(.destinationOut)
                .onTapGesture {
                    withAnimation(.easeOut) {
                        isVisible = false
                    }
                }
        }
        .compositingGroup()
    }

    private func setUpVersion() -> some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text(Bundle.main.version)
                    .font(.regular(ofSize: .xxSmall))
                    .foregroundColor(.white)
                    .opacity(0.5)
                Spacer()
            }
            .padding()
        }
    }
}

struct HomeUserMenuViewPreview: PreviewProvider {

    static var previews: some View {
        HomeUserMenuView(isVisible: .constant(true))
    }
}
