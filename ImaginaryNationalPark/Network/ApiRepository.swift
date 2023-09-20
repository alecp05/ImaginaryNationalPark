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
    // MARK: - Functions
    
    func getTours(service: Service, completed: @escaping ([Tour]) -> Void) {
        AF.request(service)
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
        AF.request(Service.tourDetail(id))
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
        AF.request(Service.contact)
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
