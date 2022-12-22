//
//  CacheRepository.swift
//  Surveys
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class CacheRepository: CacheRepositoryProtocol {

    @Injected private var cache: SurveyCache

    func getSurveyList() -> [Survey] {
        guard let surveys: [APISurvey] = try? cache.get(),
              !surveys.isEmpty else { return [] }
        return surveys
    }

    func setSurveyList(_ surveys: [Survey]) {
        try? cache.set(surveys as? [APISurvey] ?? [])
    }

    func clearSurveyList() {
        try? cache.remove()
    }
}
