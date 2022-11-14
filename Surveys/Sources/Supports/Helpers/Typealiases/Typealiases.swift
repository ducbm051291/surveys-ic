//  swiftlint:disable:this file_name
//
//  Typealiases.swift
//

import Combine
import UIKit

typealias AlertCompletion = (UIAlertAction) -> Void
typealias Asset = R.image
typealias CancelBag = Set<AnyCancellable>
typealias Localize = R.string.localizable
typealias Observable<T> = AnyPublisher<T, Error>
