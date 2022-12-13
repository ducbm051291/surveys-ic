//
//  HomeView.swift
//  Surveys
//
//  Created by David Bui on 30/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

struct HomeView: View {

    @EnvironmentObject private var navigator: Navigator
    @StateObject private var viewModel = HomeViewModel()
    @State var isMenuVisible = false
    // TODO: Remove dummy surveys
    @State var surveys: [String] = []

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
                .onAppear {
                    // Load stuffs here
                }
        case .loading:
            setUpView(isLoading: true)
        case .loaded:
            setUpView()
        case let .error(message):
            setUpView()
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text(Localize.commonApplicationNameText()),
                        message: Text(message),
                        dismissButton: Alert.Button.default(Text(Localize.commonOkText()))
                    )
                }
        }
    }

    private func setUpView(isLoading: Bool = false) -> some View {
        ZStack {
            if isLoading {
                // Skeleton here
            } else {
                setUpTabView()
            }
            HomeHeaderView(imageURL: .empty, isMenuVisible: $isMenuVisible)
                .overlay {
                    // Set up right menu here
                }
        }
    }

    private func setUpTabView() -> some View {
        TabView {
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .leading) {
            setUpPageControl()
        }
    }

    private func setUpPageControl() -> some View {
        VStack(alignment: .leading) {}
    }
}

struct HomeViewPreView: PreviewProvider {

    static var previews: some View {
        HomeView()
    }
}
