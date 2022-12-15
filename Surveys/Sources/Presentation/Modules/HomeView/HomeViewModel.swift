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

    @Published var state: State = .loading
    @Published var version: String = Bundle.main.version
}

extension HomeViewModel {

    enum State: Equatable {

        case idle, loading, loaded
        case error(String)
    }
}
