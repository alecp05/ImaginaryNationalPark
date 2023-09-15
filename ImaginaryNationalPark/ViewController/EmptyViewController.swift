//
//  EmptyViewController.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 14.09.23.
//

import UIKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - EmptyViewController -
// /////////////////////////////////////////////////////////////////////////

class EmptyViewController: UIViewController {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imaginaryLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - EmptyViewController
    // /////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    
        self.view.addSubview(self.logoImageView)
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        
        self.logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
}
