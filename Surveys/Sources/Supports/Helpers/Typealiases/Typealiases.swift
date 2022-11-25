//  swiftlint:disable:this file_name
//
//  Typealiases.swift
//

import Combine
import UIKit

typealias AlertCompletion = (UIAlertAction) -> Void
typealias Assets = R.image
typealias Colors = R.color
typealias CancelBag = Set<AnyCancellable>
typealias HTTPHeaders = [String: String]
typealias Localize = R.string.localizable
/// Publisher with error `AnyPublisher<T, Error>`
typealias Observable<T> = AnyPublisher<T, Error>
/// Publisher with no error `AnyPublisher<T, Never>`
typealias Driver<T> = AnyPublisher<T, Never>
