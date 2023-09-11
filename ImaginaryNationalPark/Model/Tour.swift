//
//  Tour.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 11.09.23.
//

import Foundation

// /////////////////////////////////////////////////////////////////////////
// MARK: - Tour -
// /////////////////////////////////////////////////////////////////////////

struct Tour: Codable {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    let id: Int
    let title: String
    let shortDescription: String
    let thumbnail: String
    let startDate: String
    let endDate: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case shortDescription
        case startDate
        case endDate
        case price
        case thumbnail = "thumb"
    }
}
