//
//  StringExtension.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 25.09.23.
//

import Foundation

// /////////////////////////////////////////////////////////////////////////
// MARK: - String.Extension -
// /////////////////////////////////////////////////////////////////////////

extension String {
    
    func formattedDate() -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
    
    func toURL() -> URL? {
        return URL(string: self)
    }
}
