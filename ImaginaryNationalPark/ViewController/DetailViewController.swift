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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var containerView: UIView = UIView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(24)
        return label
    }()
    
    private var descriptionLabel:  UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    private var bookableLabel:  UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(20)
        label.text = "BOOKABLE"
        return label
    }()
    
    private var availableLabel: UILabel = UILabel()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setTitle("CALL TO BOOK", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .gray.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(clickedAllTourButton), for: .touchUpInside)
        return button
    }()
    
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    
    var tour: Tour
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    
    init(tour: Tour) {
        self.tour = tour
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - HomeViewController
    // /////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = self.tour.title
        self.titleLabel.text = self.tour.title
        self.descriptionLabel.text = self.tour.description
        
        if let startDate = self.tour.formattedDate(using: self.dateFormatter, date: self.tour.startDate),
           let endDate = (self.tour.formattedDate(using: self.dateFormatter, date: self.tour.endDate)) {
            
            self.availableLabel.text = "\(startDate) - \(endDate)"
        }
        
        if let url = URL(string: self.tour.thumbnail) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    
                    self.imageView.image = UIImage(data: imageData)
                }
            }.resume()
        }

        // subviews
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.containerView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.descriptionLabel)
        self.containerView.addSubview(self.bookableLabel)
        self.containerView.addSubview(self.availableLabel)
        self.view.addSubview(self.callButton)
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        
        if UIDevice.current.orientation.isLandscape {
            self.imageView.snp.remakeConstraints { make in
                make.leading.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.size.equalTo(100)
            }
            self.titleLabel.snp.remakeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)

                make.leading.equalTo(self.imageView.snp.trailing)
                make.trailing.equalToSuperview()
            }

            self.descriptionLabel.snp.remakeConstraints { make in
                make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
                make.leading.equalTo(self.imageView.snp.trailing)
                make.trailing.equalToSuperview()
            }

            self.availableLabel.snp.remakeConstraints { make in
                make.top.equalTo(self.descriptionLabel.snp.bottom).offset(5)
                make.leading.equalTo(self.imageView.snp.trailing)
                make.trailing.equalToSuperview()
            }
            
         } else {
             
             self.imageView.snp.remakeConstraints { make in
                 make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                 make.leading.trailing.equalToSuperview().inset(16)
                 make.height.equalTo(200)
             }
             
             self.containerView.snp.remakeConstraints { make in
                 make.top.equalTo(self.imageView.snp.bottom)
                 make.leading.trailing.equalToSuperview().inset(16)
                 make.bottom.equalTo(self.callButton.snp.top)
             }
             
             // in container
             self.titleLabel.snp.remakeConstraints { make in
                 make.top.equalToSuperview()
                 make.leading.trailing.equalToSuperview()
             }
             
             self.descriptionLabel.snp.remakeConstraints { make in
                 make.top.equalTo(self.titleLabel.snp.bottom)
                 make.leading.trailing.equalToSuperview()
                 make.height.equalTo(300)
             }
             
             self.bookableLabel.snp.remakeConstraints { make in
                 make.top.equalTo(self.descriptionLabel.snp.bottom).offset(10)
                 make.leading.trailing.equalToSuperview()
             }
             
             self.availableLabel.snp.remakeConstraints { make in
                 make.top.equalTo(self.bookableLabel.snp.bottom).offset(5)
                 make.leading.trailing.equalToSuperview()
                 make.bottom.equalToSuperview()
             }
             //
             
             self.callButton.snp.remakeConstraints { make in
                 make.height.equalTo(50)
                 make.leading.trailing.equalToSuperview().inset(16)
                 make.bottom.equalToSuperview().inset(40)
             }
         }

    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    @objc
    func clickedAllTourButton() {
        print("call")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.makeConstraints()
    }
}

