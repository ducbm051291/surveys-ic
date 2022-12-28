//
//  HomeViewModel.swift
//  Surveys
//
//  Created by David Bui on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class HomeViewModel: ObservableObject {

    @Injected private var getSurveyListUseCase: GetSurveyListUseCaseProtocol

    @Published var state: State = .idle
    @Published var version: String = .empty
    @Published var surveys: [Survey] = []
    @Published var pageNumber: Int = 1

    private let pageSize = 10
    private let errorTracker = ErrorTracker()
    private let activityTracker = ActivityTracker(false)

    init(bundle: Bundle) {
        version = bundle.version

        let errorState = errorTracker
            .catchError()
            .map { State.error($0) }

        let loadingState = activityTracker
            .filter { $0 }
            .map { _ in State.loading }

        Publishers.Merge(errorState, loadingState)
            .receive(on: DispatchQueue.main)
            .assign(to: &$state)
    }

    func reloadSurveys() {
        pageNumber = 1
        surveys = []
        loadSurveys()
    }

    func loadSurveys() {
        state = .loading

        let getSurveyList = getSurveyListUseCase
            .execute(pageNumber: pageNumber, pageSize: pageSize)
            .trackError(errorTracker)
            .asDriver()
            .share()

        getSurveyList
            .map { _ in self.pageNumber + 1 }
            .assign(to: &$pageNumber)

        getSurveyList
            .assign(to: &$surveys)

        getSurveyList
            .map { _ in State.loaded }
            .assign(to: &$state)
    }
}

extension HomeViewModel {

    enum State: Equatable {

        case idle, loading, loaded
        case error(String)
    }
}
