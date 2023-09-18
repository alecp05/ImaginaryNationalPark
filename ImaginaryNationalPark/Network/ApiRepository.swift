//
//  ApiRepository.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 11.09.23.
//

import Alamofire
import Foundation

// /////////////////////////////////////////////////////////////////////////
// MARK: - ApiRepository -
// /////////////////////////////////////////////////////////////////////////

class ApiRepository {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private let headers: HTTPHeaders = [.accept("application/json")]
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func getTours(type: Request, completed: @escaping ([Tour]) -> Void) {
        
        AF.request(type.value, headers: self.headers)
            .responseDecodable(of: [Tour].self) { response in
                
                switch response.result {
                case .success(let tours):
                    completed(tours)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getTourWithID(id: Int, completed: @escaping (Tour) -> Void) {
        
        AF.request(Request.tourDetail(id).value, headers: self.headers)
            .responseDecodable(of: Tour.self) { response in
                
                switch response.result {
                case .success(let tour):
                    completed(tour)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getContactInfo(completed: @escaping (Contact) -> Void) {
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
