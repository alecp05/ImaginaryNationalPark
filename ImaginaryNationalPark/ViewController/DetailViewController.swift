//
//  DetailViewController.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 12.09.23.
//

import UIKit
import SnapKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - DetailViewController -
// /////////////////////////////////////////////////////////////////////////

class DetailViewController: UIViewController {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private let imageLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imaginaryLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var allTourButton: UIButton = {
        let button = UIButton()
        button.setTitle("ALL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(clickedAllTourButton), for: .touchUpInside)
        button.backgroundColor = .brown
        return button
    }()
    
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - HomeViewController
    // /////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Imaginary"
        
        // subviews
        self.view.addSubview(self.allTourButton)
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        
        self.imageLogo.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        self.allTourButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().dividedBy(2)
        }
        
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    @objc
    func clickedAllTourButton() {
        
    }
}

