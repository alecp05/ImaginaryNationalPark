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
    
    // TODO: remove ApiLogic here and move it to ViewModel when refactoring to MVVM
    
    func update(service: Service, repository: ApiRepository) {
        
        repository.getTours(service: service, completed: { tours in
            
            var newSnapshot = NSDiffableDataSourceSnapshot<Section, Tour>()
            
            newSnapshot.appendSections(Section.allCases)
            
            newSnapshot.appendItems(tours, toSection: .main)
            
            self.apply(newSnapshot, animatingDifferences: false)
        })
    }
}
