//
//  ClearQuestionResponseUseCase.swift
//  Surveys
//
//  Created by David Bui on 02/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

// sourcery: AutoMockable
protocol ClearQuestionResponseUseCaseProtocol {

    func execute(id: String)
}

struct ClearQuestionResponseUseCase: ClearQuestionResponseUseCaseProtocol {

    @Injected private var questionResponseCache: QuestionResponseCache

    func execute(id: String) {
        questionResponseCache.remove(id: id)
    }
}
