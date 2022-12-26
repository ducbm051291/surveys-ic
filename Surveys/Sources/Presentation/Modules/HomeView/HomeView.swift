//
//  HomeView.swift
//  Surveys
//
//  Created by David Bui on 30/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI
import SwiftUI_Pull_To_Refresh
import UIKit

struct HomeView: View {

    @EnvironmentObject private var navigator: Navigator
    @StateObject private var viewModel = HomeViewModel(bundle: Bundle.main)
    @State var isMenuVisible = false
    @State var selectedSurveyIndex = 0

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
                .onAppear {
                    viewModel.reloadSurveys()
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
        RefreshableScrollView { _ in
            viewModel.reloadSurveys()
        } progress: { state in
            RefreshActivityIndicator(isAnimating: state == .loading) {
                $0.hidesWhenStopped = false
            }
            .padding(.top, 30.0)
        } content: {
            ZStack {
                if isLoading {
                    HomeSkeletonLoadingView()
                        .fullScreenFrame()
                } else {
                    setUpTabView()
                        .overlay(alignment: .top) {
                            setUpHeaderHomeView()
                        }
                        .overlay {
                            setUpPageControl()
                        }
                        .overlay {
                            if isMenuVisible {
                                setUpUserMenuView()
                            }
                        }
                }
            }
        }
        .ignoresSafeArea()
    }

    private func setUpTabView() -> some View {
        let surveys = Array(viewModel.surveys.enumerated())

        return TabView(selection: $selectedSurveyIndex) {
            ForEach(surveys, id: \.element.id) { index, survey in
                HomeSurveyItemView(survey: survey)
                    .tag(index)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .background(.black)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: selectedSurveyIndex)
        .transition(.slide)
        .fullScreenFrame()
        .edgesIgnoringSafeArea(.all)
    }

    private func setUpHeaderHomeView() -> some View {
        HomeHeaderView(imageURL: .empty, isMenuVisible: $isMenuVisible)
            .padding(.top, 60.0)
            .padding(.leading, 20.0)
    }

    private func setUpUserMenuView() -> some View {
        HomeUserMenuView(isVisible: $isMenuVisible, version: $viewModel.version)
            .transition(.move(edge: .trailing))
    }

    private func setUpPageControl() -> some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                PageControlView(
                    currentPage: $selectedSurveyIndex,
                    numberOfPages: viewModel.surveys.count
                )
                .frame(width: .zero, height: 8.0, alignment: .leading)
                Spacer()
            }
            .padding(.bottom, 200.0)
        }
    }
}

struct HomeViewPreView: PreviewProvider {

    static var previews: some View {
        HomeView()
    }
}
