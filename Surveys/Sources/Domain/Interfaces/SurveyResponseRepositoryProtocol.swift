//
//  SurveyResponseRepositoryProtocol.swift
//  Surveys
//
//  Created by David Bui on 04/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine

// sourcery: AutoMockable
protocol SurveyResponseRepositoryProtocol: AnyObject {

    func submitResponse(_ survey: Survey) -> Observable<NoReply>
}
