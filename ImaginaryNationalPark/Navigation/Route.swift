//
//  Route.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 22.09.23.
//

import Foundation
import ViewModel

// /////////////////////////////////////////////////////////////////////////
// MARK: - Route -
// /////////////////////////////////////////////////////////////////////////

enum Route: Routeable {
    case detail(Tour)
}

// /////////////////////////////////////////////////////////////////////////
// MARK: - UIViewController.Extension
// /////////////////////////////////////////////////////////////////////////

extension UIViewController: SpecificNavigator {
    
    func specificRoute(to route: Route, animated: Bool, completion: (() -> Void)?) {
        switch route {
        case .detail(let tour):
            let controller = DetailViewController(viewModel: DetailViewModel(tour: tour))
            self.push(viewController: controller)
        }
    }
}
