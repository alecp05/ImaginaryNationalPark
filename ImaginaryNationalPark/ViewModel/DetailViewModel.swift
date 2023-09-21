//
//  DetailViewModel.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 20.09.23.
//

import Foundation
import ViewModel
import RxSwift
import RxCocoa

// /////////////////////////////////////////////////////////////////////////
// MARK: - DetailViewModel -
// /////////////////////////////////////////////////////////////////////////

class DetailViewModel: ViewModel {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private let repository: ApiRepository = ApiRepository()
    let tour: BehaviorRelay<Tour>
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    init(tour: Tour) {
        self.tour = BehaviorRelay(value: tour)
        super.init()
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - ViewModel
    // /////////////////////////////////////////////////////////////////////////
    
    override func didBecomeActive() {
        
        self.repository.getTourWithID(id: self.tour.value.id, completed: { tour in
            self.tour.accept(tour)
        })
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func getContactInfo(completion: @escaping (Contact) -> Void ) {
        
        self.repository.getContactInfo(completed: { contact in
            completion(contact)
        })
    }
}
