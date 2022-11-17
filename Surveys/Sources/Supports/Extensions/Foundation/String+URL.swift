//
//  String+URL.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension String {

    func toURL() -> URL {
        URL(string: self) ?? URL.applicationDirectory
    }
}
