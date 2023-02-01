//
//  StoreQuestionResponseUseCase.swift
//  Surveys
//
//  Created by David Bui on 01/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

// sourcery: AutoMockable
protocol StoreQuestionResponseUseCaseProtocol {

    func execute(questionResponse: APIQuestionResponse)
}

struct StoreQuestionResponseUseCase: StoreQuestionResponseUseCaseProtocol {

    @Injected private var questionResponseCache: QuestionResponseCache

    func execute(questionResponse: APIQuestionResponse) {
        questionResponseCache.set(questionResponse)
    }
}
