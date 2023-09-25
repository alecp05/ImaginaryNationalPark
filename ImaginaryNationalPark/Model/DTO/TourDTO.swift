//
//  TourDTO.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 21.09.23.
//

import Foundation

// /////////////////////////////////////////////////////////////////////////
// MARK: - TourDTO -
// /////////////////////////////////////////////////////////////////////////

struct TourDTO: Codable {

    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties

    let id: Int
    let title: String
    let shortDescription: String
    let description: String?
    let thumbnail: String
    let image: String?
    let startDate: String
    let endDate: String
    let price: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case shortDescription
        case description
        case startDate
        case endDate
        case price
        case thumbnail = "thumb"
        case image
    }
}

// /////////////////////////////////////////////////////////////////////////
// MARK: - TourDTO.Extension
// /////////////////////////////////////////////////////////////////////////

extension TourDTO {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Function
    
    func toDomain() -> Tour {
        
        return Tour(id: self.id,
                    title: self.title,
                    shortDescription: self.shortDescription,
                    description: self.description,
                    thumbnail: self.thumbnail.toURL(),
                    image: self.image?.toURL(),
                    startDate: self.startDate.formattedDate(),
                    endDate: self.endDate.formattedDate(),
                    price: Double(self.price))
    }
}
