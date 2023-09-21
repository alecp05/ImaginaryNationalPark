//
//  HomeViewModel.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 20.09.23.
//

import Foundation
import ViewModel
import RxSwift
import RxCocoa

// /////////////////////////////////////////////////////////////////////////
// MARK: - HomeViewModel -
// /////////////////////////////////////////////////////////////////////////

class HomeViewModel: ViewModel {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private let repository: ApiRepository = ApiRepository()
    let tours: BehaviorRelay<[Tour]> = BehaviorRelay<[Tour]>(value: [])
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    override init() {
        super.init()
        
        self.getTours(service: Service.allTours)
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func getTours(service: Service) {
        self.repository.getTours(service: service, completed: { tours in
            
            self.tours.accept(tours)
        })
    }
    
    func getTourWithId(id: Int, completion: @escaping (Tour) -> Void ) {
        self.repository.getTourWithID(id: id, completed: { tour in

            completion(tour)
        })
    }
}
