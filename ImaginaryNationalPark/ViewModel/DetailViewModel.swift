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
    var tour: BehaviorRelay<Tour?> = BehaviorRelay<Tour?>(value: nil)
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    init(tour: Tour) {
        super.init()
        
        self.tour.accept(tour)
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - ViewModel
    // /////////////////////////////////////////////////////////////////////////
    
    override func didBecomeActive() {
        if let tourId = self.tour.value?.id {
            self.repository.getTourWithID(id: tourId, completed: { tour in
                self.tour.accept(tour)
            })
        }
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func getContactInfo(completion: @escaping (Contact) -> Void ) {
        
        self.repository.getContactInfo(completed: { contact in
            
            completion(contact)
        })
    }
}
