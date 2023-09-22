//
//  Navigator.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 22.09.23.
//

import Foundation
import ViewModel

// /////////////////////////////////////////////////////////////////////////
// MARK: - UIViewController Navigator -
// /////////////////////////////////////////////////////////////////////////

extension UIViewController: Navigator {
    public func route(to route: Routeable, animated: Bool, completion: (() -> Void)? = nil) {
        if let route = route as? Route {
            self.specificRoute(to: route, animated: animated, completion: completion)
        }
    }
}

// /////////////////////////////////////////////////////////////////////////
// MARK: - SpecificNavigator -
// /////////////////////////////////////////////////////////////////////////

protocol SpecificNavigator {
    func specificRoute(to route: Route, animated: Bool, completion: (() -> Void)?)
}
