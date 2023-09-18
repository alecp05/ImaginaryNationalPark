//
//  HomeViewController.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 11.09.23.
//

import Alamofire
import AlamofireImage
import BIFiOSUtils
import SnapKit
import UIKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - HomeViewController Delegate -
// /////////////////////////////////////////////////////////////////////////

protocol HomeViewControllerDelegate: NSObjectProtocol {
    func didSelectTour(tour: Tour)
}

// /////////////////////////////////////////////////////////////////////////
// MARK: - HomeViewController -
// /////////////////////////////////////////////////////////////////////////

class HomeViewController: UIViewController, UITableViewDelegate {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private let imageLogo: UIImageView = UIImageView().configure { imageView in
        imageView.image = UIImage(named: "imaginaryLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
    
    private lazy var allTourButton: UIButton = UIButton().configure { button in
        button.setTitle("ALL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(clickedAllTourButton), for: .touchUpInside)
        button.backgroundColor = .brown
    }
    
    private lazy var topFiveButton: UIButton = UIButton().configure { button in
        button.setTitle("TOP 5", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(clickedTopFiveButton), for: .touchUpInside)
        button.backgroundColor = .brown
    }
    
    private lazy var tableView: UITableView = UITableView().configure { tableView in 
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.estimatedRowHeight = 120
        tableView.register(TourCell.self, forCellReuseIdentifier: TourCell.reuseIdentifier)
        tableView.delegate = self
    }
    
    private lazy var dataSource: TourDataSource = self.configureDataSource()
    
    private let repository: ApiRepository = ApiRepository()
    
    weak var delegate: HomeViewControllerDelegate?
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - HomeViewController
    // /////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Imaginary"
        
        // navigation
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.imageLogo)
        
        // tableView
        self.dataSource.update(requestType: .allTours, repository: self.repository)
        
        // subviews
        self.view.addSubview(self.allTourButton)
        self.view.addSubview(self.topFiveButton)
        self.view.addSubview(self.tableView)
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        
        self.imageLogo.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        
        self.allTourButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(1)
            make.height.equalTo(50)
            make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width).dividedBy(2)
        }
        
        self.topFiveButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.allTourButton.snp.trailing).offset(1)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(1)
            make.height.equalTo(50)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.allTourButton.snp.bottom)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    @objc
    func clickedAllTourButton() {
        self.dataSource.update(requestType: .allTours, repository: self.repository)
        self.tableView.reloadData()
    }
    
    @objc
    func clickedTopFiveButton() {
        self.dataSource.update(requestType: .topFive, repository: self.repository)
        self.tableView.reloadData()
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - DiffableDataSource
    // /////////////////////////////////////////////////////////////////////////
    
    func configureDataSource() -> TourDataSource {
        return TourDataSource(tableView: self.tableView) { tableView, indexPath, tour -> UITableViewCell in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TourCell.reuseIdentifier, for: indexPath) as? TourCell
            else { fatalError("Couldn't create TourCell") }
            
            // image
            AF.request(tour.thumbnail).responseImage { response in
                if let image = response.value {
                    cell.thumbnail.image = image
                }
            }
            
            cell.titleLabel.text = tour.title
            cell.priceLabel.text = "PRICE: \(tour.price)0€"
            cell.descriptionLabel.text = tour.shortDescription
            
            // end Date
            if let date = Date().formattedDate(date: tour.endDate) {
                cell.availableLabel.text = date
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDelegate
    // /////////////////////////////////////////////////////////////////////////
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let tour = self.dataSource.itemIdentifier(for: indexPath) {
            
            self.repository.getTourWithID(id: tour.id, completed: { tour in
                
                if UIScreen.main.bounds.width > UIScreen.main.bounds.height || UIDevice.current.userInterfaceIdiom == .pad {
                    self.delegate?.didSelectTour(tour: tour)
                } else {
                    let controller = DetailViewController(repository: self.repository)
                    controller.tour = tour
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            })
        }
    }
}
