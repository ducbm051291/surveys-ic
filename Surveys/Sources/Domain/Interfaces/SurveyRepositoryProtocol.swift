//
//  SurveyRepositoryProtocol.swift
//  Surveys
//
//  Created by David Bui on 19/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

// sourcery: AutoMockable
protocol SurveyRepositoryProtocol: AnyObject {

    func getSurveyList(pageNumber: Int, pageSize: Int) -> Driver<[Survey]>
}
