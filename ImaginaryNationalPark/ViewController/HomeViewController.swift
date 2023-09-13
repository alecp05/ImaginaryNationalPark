//
//  HomeViewController.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 11.09.23.
//

import UIKit
import SnapKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - HomeViewController -
// /////////////////////////////////////////////////////////////////////////

class HomeViewController: UIViewController, UITableViewDelegate {
    
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
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var topFiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("TOP 5", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(clickedTopFiveButton), for: .touchUpInside)
        button.backgroundColor = .brown
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TourCell.self, forCellReuseIdentifier: TourCell.reuseIdentifier)
        tableView.delegate = self
        return tableView
    }()
    
    private var dataSource: TourDataSource?
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    private let repository: ApiRepository = ApiRepository()
    
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
        self.configureDataSource()
        self.dataSource?.update(requestType: .allTours, repository: self.repository)
        
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
            make.leading.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().dividedBy(2)
        }
        
        self.topFiveButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.allTourButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.allTourButton.snp.bottom)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.bottom.equalToSuperview()
        }
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    @objc
    func clickedAllTourButton() {
        self.dataSource?.update(requestType: .allTours, repository: self.repository)
        self.tableView.reloadData()
    }
    
    @objc
    func clickedTopFiveButton() {
        self.dataSource?.update(requestType: .topFive, repository: self.repository)
        self.tableView.reloadData()
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - DiffableDataSource
    // /////////////////////////////////////////////////////////////////////////
    
    func configureDataSource() {
        self.dataSource = TourDataSource(tableView: self.tableView) { tableView, indexPath, tour -> UITableViewCell in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TourCell.reuseIdentifier, for: indexPath) as? TourCell
            else { fatalError("Couldn't create TourCell") }
            
            // image
            if let url = URL(string: tour.thumbnail) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let imageData = data else { return }
                    DispatchQueue.main.async {
                        cell.thumbnail.image = UIImage(data: imageData)
                    }
                }.resume()
            }
            
            cell.titleLabel.text = tour.title
            cell.priceLabel.text = "PRICE: \(tour.price)€"
            cell.descriptionLabel.text = tour.shortDescription
            
            // end Date
            if let date = tour.formattedDate(using: self.dateFormatter, date: tour.endDate) {
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
        
        if let tour = self.dataSource?.itemIdentifier(for: indexPath) {
            self.repository.getTourWithID(id: tour.id, completed: { tour in

                let controller = DetailViewController(tour: tour, repository: self.repository)

                self.navigationController?.pushViewController(controller, animated: true)
            })
        }
    }
    
}

