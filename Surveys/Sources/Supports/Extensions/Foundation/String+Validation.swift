//
//  String+Validation.swift
//  Surveys
//
//  Created by David Bui on 28/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension String {

    enum Validation {

        typealias Regex = Constants.Regex

        case email
        case password

        var regex: String {
            switch self {
            case .email: return Regex.email
            case .password: return Regex.password
            }
        }
    }

    func validate(_ pattern: Validation) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", "\(pattern.regex)").evaluate(with: self)
    }
}
