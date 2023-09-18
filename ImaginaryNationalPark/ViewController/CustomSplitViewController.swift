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
    
    private lazy var homeViewController = HomeViewController().configure { controller in
        controller.delegate = self
    }
    
    private lazy var homeNavigationController = UINavigationController(rootViewController: self.homeViewController)
    private let detailViewController = DetailViewController(repository: ApiRepository())
    private let emptyViewController = EmptyViewController()
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)

        self.viewControllers = [self.homeNavigationController, self.emptyViewController]
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - CustomSplitViewController
    // /////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self

        self.preferredDisplayMode = .oneBesideSecondary
        self.preferredPrimaryColumnWidthFraction = 0.5
        self.maximumPrimaryColumnWidth = self.view.bounds.size.width;
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
