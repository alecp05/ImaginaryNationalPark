//
//  Configuration.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 20.09.23.
//

import Foundation
import BIFiOSUtils

// /////////////////////////////////////////////////////////////////////////
// MARK: - Configuration -
// /////////////////////////////////////////////////////////////////////////

class Configuration: NSObject {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    static let baseURLString: String = "http://api.foxtur.com/"
    
    static var serviceConfiguration: ServiceConfiguration = ServiceConfiguration(baseURLString: Configuration.baseURLString, apiPath: "v1/")
}
