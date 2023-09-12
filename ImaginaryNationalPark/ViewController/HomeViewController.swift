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
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(clickedAllTourButton), for: .touchUpInside)
        button.backgroundColor = .green
        return button
    }()
    
    private lazy var topFiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("TOP 5", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(clickedTopFiveButton), for: .touchUpInside)
        button.backgroundColor = .yellow
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private var dataSource: TourDataSource!
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - HomeViewController
    // /////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Imaginary"
        
        // navigation
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.imageLogo)
        
        self.tableView.register(TourCell.self, forCellReuseIdentifier: TourCell.reuseIdentifier)
        
        self.configureDataSource()
        self.dataSource.update(requestType: .allTours)
        
        // subviews
        self.view.addSubview(self.allTourButton)
        self.view.addSubview(self.topFiveButton)
        self.view.addSubview(self.tableView)
        
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
        
        self.topFiveButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.allTourButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.allTourButton.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Functions
    
    @objc
    func clickedAllTourButton() {
        self.dataSource.update(requestType: .allTours)
    }
    
    @objc
    func clickedTopFiveButton() {
        self.dataSource.update(requestType: .topFive)
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - DiffableDataSource
    // /////////////////////////////////////////////////////////////////////////
    
    
    func configureDataSource() {
        self.dataSource = TourDataSource(tableView: self.tableView) { tableView, indexPath, tour -> UITableViewCell in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TourCell.reuseIdentifier, for: indexPath) as? TourCell
            else { fatalError("Couldn't create TourCell") }
            
            cell.backgroundColor = .gray
            cell.titleLabel.text = tour.title
            
            return cell
        }
    }
    
}

