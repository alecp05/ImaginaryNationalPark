//
//  ApiRepository.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 11.09.23.
//

import Foundation
import Alamofire

// /////////////////////////////////////////////////////////////////////////
// MARK: - ApiRepository -
// /////////////////////////////////////////////////////////////////////////

class ApiRepository {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    var allTours: [Tour] = [Tour]()

    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func getTours(type: Request,completed: @escaping () -> ()) {
        
        let headers: HTTPHeaders = [.accept("application/json")]
        
        AF.request(type.value, headers: headers)
            .responseDecodable(of: [Tour].self) { response in
                
                switch response.result {
                case .success(let tours):
                    
                    if !self.allTours.isEmpty {
                        self.allTours.removeAll()
                    }
                    
                    for tour in tours {
                        self.allTours.append(tour)
                    }
                    
                    completed()
                case .failure(let error):
                    print(error)
                }
            }
    }
}
