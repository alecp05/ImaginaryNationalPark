//
//  ApiDataSource.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 11.09.23.
//

import Foundation
import Alamofire

// /////////////////////////////////////////////////////////////////////////
// MARK: - ApiDataSource -
// /////////////////////////////////////////////////////////////////////////

class ApiDataSource {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func getTours() {
        let headers: HTTPHeaders = [.accept("application/json")]
        
        AF.request(Request.topFive.value, headers: headers)
            .responseDecodable(of: [Tour].self) { response in
                
                switch response.result {
                case .success(let tours):
                    print(tours)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
