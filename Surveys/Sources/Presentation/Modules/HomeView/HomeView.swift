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
    @State private var selectedTab = 0
    // TODO: Remove dummy surveys
    let surveys = [
        APISurvey(id: "1"),
        APISurvey(id: "2"),
        APISurvey(id: "3"),
        APISurvey(id: "4")
    ]

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
                    .overlay(alignment: .top) {
                        HomeHeaderView(imageURL: .empty, isMenuVisible: $isMenuVisible)
                            .padding(.top, 60.0)
                            .padding(.leading, 20.0)
                            .overlay {
                                // Set up right menu here
                            }
                    }
            }
        }
        .ignoresSafeArea()
    }

    private func setUpTabView() -> some View {
        TabView {
            ForEach(surveys, id: \.id) { survey in
                HomeSurveyItemView(survey: survey)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .leading) {
            setUpPageControl()
        }
        .edgesIgnoringSafeArea(.all)
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
