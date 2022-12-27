//
//  Bundle+Version.swift
//  Surveys
//
//  Created by David Bui on 14/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension Bundle {

    var version: String {
        "v" + (infoDictionary?["CFBundleShortVersionString"] as? String ?? .empty)
    }
}
