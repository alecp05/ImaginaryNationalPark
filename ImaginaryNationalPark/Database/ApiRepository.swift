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
    var detailTour: Tour?
    
    private let headers: HTTPHeaders = [.accept("application/json")]
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func getTours(type: Request, completed: @escaping () -> ()) {
        
        AF.request(type.value, headers: self.headers)
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
    
    func getTourWithID(id: Int, completed: @escaping (Tour) -> ()) {
        
        AF.request(Request.tourDetail(id).value, headers: self.headers)
            .responseDecodable(of: Tour.self) { response in
                
                switch response.result {
                case .success(let tour):
                
                    self.detailTour = tour
                    completed(tour)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getContactInfo(completed: @escaping (Contact) -> ()) {
        AF.request(Request.contact.value, headers: self.headers)
            .responseDecodable(of: Contact.self) { response in
                
                switch response.result {
                case .success(let contact):
                    completed(contact)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
