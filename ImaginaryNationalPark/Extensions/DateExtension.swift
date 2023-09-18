//
//  DateExtension.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 12.09.23.
//

import UIKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - Date.Extension -
// /////////////////////////////////////////////////////////////////////////

extension Date {

    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions

    func formattedDate(date: String) -> String? {
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: date) {

            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy HH:mm"
            return formatter.string(from: date)
        }
        return nil
    }
}
