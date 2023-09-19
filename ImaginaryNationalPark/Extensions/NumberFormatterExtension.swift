//
//  NumberFormatterExtension.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 19.09.23.
//

import Foundation

// /////////////////////////////////////////////////////////////////////////
// MARK: - NumberFormatter.Extension -
// /////////////////////////////////////////////////////////////////////////

extension NumberFormatter {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func formattedPrice(price: String) -> String? {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "€"
        
        if let floatNumber = NumberFormatter().number(from: price), let tourPrice = numberFormatter.string(from: floatNumber) {
            return tourPrice
        }
        
        return nil
    }
}
