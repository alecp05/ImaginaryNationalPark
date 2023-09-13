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

class DetailViewController: UIViewController, HomeViewControllerDelegate {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imaginaryLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()
    
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
    
    private let scrollView: UIScrollView = UIScrollView()
    
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
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .brown.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(clickedAllTourButton), for: .touchUpInside)
        return button
    }()
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    var tour: Tour?
    var repository: ApiRepository
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    
    init(tour: Tour?, repository: ApiRepository) {
        self.tour = tour
        self.repository = repository
        
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
        
        if let tour = self.tour {
            self.title = tour.title
            self.titleLabel.text = tour.title
            self.descriptionLabel.text = tour.description
            
            if let startDate = tour.formattedDate(using: self.dateFormatter, date: tour.startDate),
               let endDate = (tour.formattedDate(using: self.dateFormatter, date: tour.endDate)) {
                
                self.availableLabel.text = "\(startDate) - \(endDate)"
            }
            
            if let url = URL(string: tour.thumbnail) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let imageData = data else { return }
                    DispatchQueue.main.async {
                        
                        self.imageView.image = UIImage(data: imageData)
                    }
                }.resume()
            }
        } else {
            
            self.logoImageView.isHidden = false
            self.bookableLabel.isHidden = true
            self.callButton.isHidden = true
        }
        
        // logo when its empty
        self.view.addSubview(self.logoImageView)
        
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
        
        self.logoImageView.snp.remakeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        // check if manually because on launch orientation is unknown
        // portrait
        if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
            
            self.imageView.snp.remakeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(200)
            }
        } else {
            
            self.imageView.snp.remakeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
                make.centerX.equalToSuperview()
                make.height.equalTo(100)
                make.width.equalTo(200)
            }
        }
        
        self.containerView.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(16)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(16)
            make.bottom.equalTo(self.callButton.snp.top).offset(-24)
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
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    @objc
    func clickedAllTourButton() {
        self.repository.getContactInfo(completed: { contact in
            
            let alert = UIAlertController(title: contact.companyName, message: contact.phone, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        // change if orientation changes while in DetailViewController
        
        if UIDevice.current.orientation.isLandscape {
            self.imageView.snp.remakeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
                make.centerX.equalToSuperview()
                make.height.equalTo(100)
                make.width.equalTo(200)
            }
        } else {
            self.imageView.snp.remakeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(200)
            }
        }
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - HomeViewControllerDelegate -
    // /////////////////////////////////////////////////////////////////////////
    
    func didSelectTour(tour: Tour) {
        
        // components hidden
        self.logoImageView.isHidden = true
        self.bookableLabel.isHidden = false
        self.callButton.isHidden = false
        
        self.titleLabel.text = tour.title
        self.descriptionLabel.text = tour.description
        
        if let startDate = tour.formattedDate(using: self.dateFormatter, date: tour.startDate),
           let endDate = (tour.formattedDate(using: self.dateFormatter, date: tour.endDate)) {
            
            self.availableLabel.text = "\(startDate) - \(endDate)"
        }
        
        if let url = URL(string: tour.thumbnail) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    
                    self.imageView.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }
    
}

