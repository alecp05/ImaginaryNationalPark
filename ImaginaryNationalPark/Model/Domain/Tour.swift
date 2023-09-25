//
//  Tour.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 11.09.23.
//

import UIKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - Tour -
// /////////////////////////////////////////////////////////////////////////

struct Tour: Hashable {

    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties

    let id: Int
    let title: String
    let shortDescription: String
    let description: String?
    let thumbnail: URL?
    let image: URL?
    let startDate: Date?
    let endDate: Date?
    let price: Double?
}
