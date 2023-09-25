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
    
    func formattedDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm"
        return formatter.string(from: self)
    }
}
