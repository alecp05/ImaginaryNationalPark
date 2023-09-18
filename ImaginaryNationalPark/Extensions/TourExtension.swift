//
//  Tour.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 12.09.23.
//

import UIKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - Tour.Extension -
// /////////////////////////////////////////////////////////////////////////

extension Tour {

    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions

    func formattedDate(date: String) -> String? {
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: date) {

            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            return formatter.string(from: date)
        }
        return nil
    }
}
