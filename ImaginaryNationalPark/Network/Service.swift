//
//  Service.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 19.09.23.
//

import Foundation
import BIFiOSUtils
import Alamofire

// /////////////////////////////////////////////////////////////////////////
// MARK: - Service -
// /////////////////////////////////////////////////////////////////////////

enum Service: ServiceProtocol {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Cases

    case allTours
    case topFive
    case tourDetail(Int)
    case contact
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    static var configuration: ServiceConfiguration!
    
    var path: String {
        switch self {
        case .allTours:
            return "tours/"
        case .topFive:
            return "tours/top5/"
        case .tourDetail(let id):
            return "tours/\(id)/"
        case .contact:
            return "contact/"
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding()
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allTours, .topFive, .tourDetail(_), .contact:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        let headers: HTTPHeaders = [.accept("application/json")]
        return headers
    }
}
