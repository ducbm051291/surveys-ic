//
//  Notification+Instance.swift
//  Surveys
//
//  Created by David Bui on 30/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension Notification {

    static let unauthenticated = Notification(name: .unauthenticated)
}

extension Notification.Name {

    static let unauthenticated = Notification.Name("unauthenticated")
}
