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
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func getContactInfo(completion: @escaping (Contact) -> Void ) {
        
        self.repository.getContactInfo(completed: { contact in
            
            completion(contact)
        })
    }
}
