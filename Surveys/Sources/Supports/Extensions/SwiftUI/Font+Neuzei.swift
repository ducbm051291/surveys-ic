//
//  Font+Neuzei.swift
//  Surveys
//
//  Created by David Bui on 16/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

protocol FontStyle {

    var name: String { get }
}

extension Font {

    private enum NeuzeiStyle: FontStyle {

        case regular
        case bold

        var name: String {
            switch self {
            case .regular:
                return "NeuzeitSLTStd-Book"
            case .bold:
                return "NeuzeitSLTStd-BookHeavy"
            }
        }
    }

    enum Size: CGFloat {

        /// 14px
        case small = 15.0

        /// 16px
        case regular = 17.0
    }

    static func regular(ofSize size: Font.Size = .regular) -> Font {
        neuzei(style: .regular, size: size.rawValue)
    }

    static func bold(ofSize size: Font.Size = .regular) -> Font {
        neuzei(style: .bold, size: size.rawValue)
    }

    private static func neuzei(style: NeuzeiStyle = .regular, size: CGFloat = 17.0) -> Font {
        Font.custom(style.name, size: size)
    }
}
