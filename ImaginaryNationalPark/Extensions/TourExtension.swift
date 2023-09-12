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
    
    func formattedDate(using formatter: DateFormatter, date: String) -> String? {
    
        if let date = formatter.date(from: date) {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            return formatter.string(from: date)

        }
        return nil
    }
}
