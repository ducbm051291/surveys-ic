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
    @State var selectedSurveyIndex = 0
    // TODO: Remove dummy surveys
    let surveys = [
        APISurvey(id: 0),
        APISurvey(id: 1),
        APISurvey(id: 2),
        APISurvey(id: 3)
    ]

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
        case .loading:
            setUpView(isLoading: true)
                .onAppear {
                    // TODO: Remove loading demo code
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        viewModel.state = .loaded
                    }
                }
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
                HomeSkeletonLoadingView()
            } else {
                setUpTabView()
                    .overlay(alignment: .top) {
                        setUpHeaderHomeView()
                    }
                    .overlay(alignment: .top) {
                        if isMenuVisible {
                            HomeUserMenuView(isVisible: $isMenuVisible)
                        }
                    }
            }
        }
        .ignoresSafeArea()
    }

    private func setUpTabView() -> some View {
        TabView(selection: $selectedSurveyIndex) {
            ForEach(surveys, id: \.id) { survey in
                HomeSurveyItemView(survey: survey)
                    .tag(survey.id)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: selectedSurveyIndex)
        .transition(.slide)
        .overlay(alignment: .leading) {
            setUpPageControl()
        }
        .ignoresSafeArea(.all)
    }

    private func setUpHeaderHomeView() -> some View {
        HomeHeaderView(imageURL: .empty, isMenuVisible: $isMenuVisible)
            .padding(.top, 60.0)
            .padding(.leading, 20.0)
    }

    private func setUpPageControl() -> some View {
        VStack(alignment: .leading) {
            Spacer()
            PageControlView(
                currentPage: $selectedSurveyIndex,
                // TODO: Update number of pages with real data
                numberOfPages: 4
            )
            .frame(
                width: .zero,
                height: 8.0,
                alignment: .leading
            )
            .padding(.leading, 10.0)
            .padding(.bottom, 226.0)
        }
    }
}

struct HomeViewPreView: PreviewProvider {

    static var previews: some View {
        HomeView()
    }
}
