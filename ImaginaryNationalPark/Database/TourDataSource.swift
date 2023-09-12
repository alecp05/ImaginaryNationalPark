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
    // MARK: - Properties
    
    private let repository: ApiRepository = ApiRepository()
    
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func update(requestType: Request) {
        
        self.repository.getTours(type: requestType, completed: {
            
            var newSnapshot = NSDiffableDataSourceSnapshot<Section, Tour>()
            
            newSnapshot.appendSections(Section.allCases)
            
            newSnapshot.appendItems(self.repository.allTours, toSection: .main)
            
            self.apply(newSnapshot, animatingDifferences: false)
        })
    }
}
