//
//  DateFormatter+Formats.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension DateFormatter {

    static let iso8601WithoutTimeZone = DateFormatter(with: "yyyy-MM-dd'T'HH:mm:ss.SSS")

    private convenience init(with format: String) {
        self.init()
        dateFormat = format
    }
}
