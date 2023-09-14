//
//  CustomSplitViewController.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 13.09.23.
//

import UIKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - CustomSplitViewController -
// /////////////////////////////////////////////////////////////////////////

class CustomSplitViewController: UISplitViewController, UISplitViewControllerDelegate, HomeViewControllerDelegate {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private lazy var homeViewController = {
        let controller = HomeViewController()
        controller.delegate = self
        return controller
    }()
    
    private lazy var homeNavigationController = UINavigationController(rootViewController: self.homeViewController)
    private let detailViewController = DetailViewController(tour: nil, repository: ApiRepository())
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = [homeNavigationController, EmptyViewController()]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - CustomSplitViewController
    // /////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if UIDevice.current.userInterfaceIdiom != .pad {
            self.preferredDisplayMode = .oneBesideSecondary
        }
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func changeViewController() {

    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: -  UISplitViewController
    // /////////////////////////////////////////////////////////////////////////
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - HomeViewController
    // /////////////////////////////////////////////////////////////////////////
    
    func didSelectTour(tour: Tour) {
        self.detailViewController.tour = tour
        self.showDetailViewController(self.detailViewController, sender: self)
    }
    
}
