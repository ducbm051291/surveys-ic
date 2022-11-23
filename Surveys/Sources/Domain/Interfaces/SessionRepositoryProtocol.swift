//
//  SessionRepositoryProtocol.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

// sourcery: AutoMockable
protocol SessionRepositoryProtocol {

    func hasToken() -> Observable<Bool>
    func getToken() -> Observable<Token?>
    func removeToken() -> Observable<Bool>
    func saveToken(_ token: Token) -> Observable<Bool>
}
