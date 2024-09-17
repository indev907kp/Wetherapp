//
//  HTTPError.swift
//  Weather App
//
//  Created by niravkumar patel on 9/16/24.
//

import Foundation

enum HttpError: Error {
    case badRequest
    case InvalidRequest
    case authenticationError
    case noData
    case serverSideError
    case failed
}
