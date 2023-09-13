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

class CustomSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.preferredDisplayMode = .oneBesideSecondary
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: -  UISplitViewController
    // /////////////////////////////////////////////////////////////////////////
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
