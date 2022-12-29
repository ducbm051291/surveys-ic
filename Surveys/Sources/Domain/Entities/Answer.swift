//
//  Answer.swift
//  Surveys
//
//  Created by David Bui on 28/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol Answer {

    var id: String { get }
    var type: String { get }
    var displayOrder: Int { get }
    var text: String? { get }
    var inputMaskPlaceholder: String? { get }
}
