//
//  PassthroughSubject+ErrorCatcher.swift
//  Surveys
//
//  Created by David Bui on 05/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

extension PassthroughSubject {

    func catchError() -> Driver<String> {
        return map { error -> String in
            guard let error = error as? NetworkAPIError else {
                return Localize.commonErrorText()
            }
            switch error {
            case let .responseErrors(errors):
                return errors.first?.detail ?? Localize.commonErrorText()
            default:
                return Localize.commonErrorText()
            }
        }
        .asDriver()
    }
}
