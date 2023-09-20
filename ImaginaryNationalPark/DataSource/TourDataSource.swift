//
//  TourDataSource.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 12.09.23.
//

import UIKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - TourDataSource -
// /////////////////////////////////////////////////////////////////////////

class TourDataSource: UITableViewDiffableDataSource<Section, Tour> {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func update(tours: [Tour]) {
        
        var newSnapshot = NSDiffableDataSourceSnapshot<Section, Tour>()
        newSnapshot.appendSections(Section.allCases)
        newSnapshot.appendItems(tours, toSection: .main)
        
        self.apply(newSnapshot, animatingDifferences: false)
    }
}
