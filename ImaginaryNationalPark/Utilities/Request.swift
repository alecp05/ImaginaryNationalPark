//
//  Requests.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 11.09.23.
//

import Foundation

// /////////////////////////////////////////////////////////////////////////
// MARK: - Request -
// /////////////////////////////////////////////////////////////////////////

enum Request {

    case allTours
    case topFive
    case tourDetail(Int)
    case contact

    var value: String {
        switch self {
        case .allTours:
            return "http://api.foxtur.com/v1/tours/"
        case .topFive:
            return "http://api.foxtur.com/v1/tours/top5/"
        case .tourDetail(let tourID):
            return "http://api.foxtur.com/v1/tours/\(tourID)/"
        case .contact:
            return "http://api.foxtur.com/v1/contact/"
        }
    }
}
