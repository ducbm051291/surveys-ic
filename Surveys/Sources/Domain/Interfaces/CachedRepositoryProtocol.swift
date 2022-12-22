//
//  CachedRepositoryProtocol.swift
//  Surveys
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol CachedRepositoryProtocol: AnyObject {

    func getSurveyList() -> Observable<[Survey]>
    func setSurveyList(_ surveys: [Survey])
    func clearSurveyList()
}
