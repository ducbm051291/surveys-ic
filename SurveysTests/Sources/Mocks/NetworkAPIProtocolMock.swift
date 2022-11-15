//  swiftlint:disable force_cast
//  NetworkAPIProtocolMock.swift
//  SurveysTests
//
//  Created by David Bui on 15/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

@testable import Surveys
class NetworkAPIProtocolMock: NetworkAPIProtocol {

    // MARK: - performRequest<T: Decodable>

    private var performRequestForReturnValues: [String: Any] = [:]
    var performRequestForReceivedArguments: (configuration: RequestConfiguration, type: String)?
    var performRequestForReceivedInvocations: [(configuration: RequestConfiguration, type: String)] = []
    var performRequestCallsCount = 0
    var performRequestCalled: Bool {
        performRequestCallsCount > 0
    }

    func performRequest<T: Decodable>(_ configuration: RequestConfiguration, for type: T.Type) -> Observable<T> {
        performRequestCallsCount += 1
        performRequestForReceivedArguments = (configuration: configuration, type: "\(type)")
        performRequestForReceivedInvocations.append((configuration: configuration, type: "\(type)"))
        return getPerformRequestForReturnValue(for: T.self)
    }

    func setPerformRequestForReturnValue<T: Decodable>(_ value: Observable<T>) {
        performRequestForReturnValues["\(T.self)"] = value
    }

    func getPerformRequestForReturnValue<T: Decodable>(for type: T.Type) -> Observable<T> {
        performRequestForReturnValues["\(T.self)"] as! Observable<T>
    }
}
