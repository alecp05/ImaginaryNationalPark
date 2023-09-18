//
//  DetailViewController.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 12.09.23.
//

import SnapKit
import UIKit
import Alamofire
import AlamofireImage

// /////////////////////////////////////////////////////////////////////////
// MARK: - DetailViewController -
// /////////////////////////////////////////////////////////////////////////

class DetailViewController: UIViewController {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private let imageView: UIImageView = UIImageView().configure { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    private var containerView: UIView = UIView()
    
    private var titleLabel: UILabel = UILabel().configure { label in
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(24)
    }
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private var descriptionLabel: UILabel = UILabel().configure { label in
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
    }
    
    private var bookableLabel: UILabel = UILabel().configure { label in
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(20)
        label.text = "BOOKABLE"
    }
    
    private var availableLabel: UILabel = UILabel()
    
    private lazy var callButton: UIButton = UIButton().configure { button in
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "phone")
        configuration.title = "CALL TO BOOK"
        configuration.imagePlacement = .leading
        configuration.titleAlignment = .center
        configuration.imagePadding = 20
        
        button.configuration = configuration
        button.backgroundColor = .brown.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(callButtonClicked), for: .touchUpInside)
        button.tintColor = .black
    }
    
    var tour: Tour? {
        didSet {
            self.updateTour()
        }
    }
    
    var repository: ApiRepository
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    init(tour: Tour?, repository: ApiRepository) {
        self.tour = tour
        self.repository = repository
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - HomeViewController
    // /////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.updateTour()
        
        // subviews
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.containerView)
        
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.scrollView)
        self.scrollView.addSubview(self.descriptionLabel)
        self.containerView.addSubview(self.bookableLabel)
        self.containerView.addSubview(self.availableLabel)
        
        self.view.addSubview(self.callButton)
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        
        self.imageView.snp.remakeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
            make.centerX.equalToSuperview()
            
            // check if manually because on launch orientation is unknown
            // portrait
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(200)
            } else {
                make.height.equalTo(100)
                make.width.equalTo(200)
            }
        }
        
        self.containerView.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(16)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(16)
            make.bottom.equalTo(self.callButton.snp.top)
        }
        
        // in container
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
        
        self.bookableLabel.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        self.availableLabel.snp.makeConstraints { make in
            make.top.equalTo(self.bookableLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        //
        
        self.callButton.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    func updateTour() {
        if let tour = self.tour {
            self.title = tour.title
            self.titleLabel.text = tour.title
            self.descriptionLabel.text = tour.description
            
            if let startDate = tour.formattedDate(date: tour.startDate),
               let endDate = (tour.formattedDate(date: tour.endDate)) {
                
                self.availableLabel.text = "\(startDate) - \(endDate)"
            }
            
            if let image = tour.image {
                AF.request(image).responseImage { response in
                    if let image = response.value {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    @objc
    func callButtonClicked() {
        self.repository.getContactInfo(completed: { contact in
            
            let alert = UIAlertController(title: contact.companyName, message: contact.phone, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        // update constraints if orientation changes while in DetailViewController
        
        self.imageView.snp.remakeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
            make.centerX.equalToSuperview()
            
            // check if manually because on launch orientation is unknown
            // portrait
            if UIDevice.current.orientation.isLandscape {
                make.height.equalTo(100)
                make.width.equalTo(200)
                
            } else {
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(200)
            }
        }
    }
}
