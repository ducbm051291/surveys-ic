//
//  Navigator.swift
//  Surveys
//
//  Created by David Bui on 02/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import FlowStacks
import Resolver
import SwiftUI

final class Navigator: ObservableObject {

    @Injected private var getTokenUseCase: GetTokenUseCaseProtocol
    private var cancelBag = CancelBag()

    @Published var routes: Routes<Screen> = []

    init() {
        getTokenUseCase.execute()
            .sink { _ in
            } receiveValue: { token in
                guard token != nil else {
                    self.routes = [.root(.login, embedInNavigationView: true)]
                    return
                }
                self.routes = [.root(.home)]
            }
            .store(in: &cancelBag)
    }

    func show(screen: Screen, by transition: Transition, embedInNavigationView: Bool = false) {
        switch transition {
        case .root:
            routes = [.root(screen, embedInNavigationView: embedInNavigationView)]
        case .push:
            routes.push(screen)
        case .presentSheet:
            routes.presentSheet(screen, embedInNavigationView: embedInNavigationView)
        case .presentCover:
            routes.presentCover(screen, embedInNavigationView: embedInNavigationView)
        }
    }

    func goBack() {
        routes.goBack()
    }

    func goBackToRoot() {
        routes.goBackToRoot()
    }

    func pop() {
        routes.pop()
    }

    func dismiss() {
        routes.dismiss()
    }
}

extension Navigator {

    enum Transition {

        case root
        case push
        case presentSheet
        case presentCover
    }
}
