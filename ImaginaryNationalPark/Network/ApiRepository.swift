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
            .responseDecodable(of: [TourDTO].self) { response in
            
            switch response.result {
            case .success(let tours):
                completed(tours.map({ $0.toObject() }))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTourWithID(id: Int, completed: @escaping (Tour) -> Void) {
        AF.request(Service.tourDetail(id))
            .responseDecodable(of: TourDTO.self) { response in
                
                switch response.result {
                case .success(let tour):
                    completed(tour.toObject())
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getContactInfo(completed: @escaping (Contact) -> Void) {
        AF.request(Service.contact)
            .responseDecodable(of: ContactDTO.self) { response in
                
                switch response.result {
                case .success(let contact):
                    completed(contact.toObject())
                case .failure(let error):
                    print(error)
                }
            }
    }
}
