//
//  TourCell.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 12.09.23.
//

import UIKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - TourCell -
// /////////////////////////////////////////////////////////////////////////

class TourCell: UITableViewCell {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    static let reuseIdentifier = String(describing: TourCell.self)
    
    var containerView: UIView = UIView()
    
    var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var informationContainerView: UIView = UIView()
    
    var titleLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    var priceLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    var descriptionLabel: UILabel = UILabel()
    var availableLabel: UILabel = UILabel()

    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.containerView)
        
        self.containerView.addSubview(self.thumbnail)
        self.containerView.addSubview(self.informationContainerView)
        self.containerView.addSubview(self.priceLabel)
        
        self.informationContainerView.addSubview(self.titleLabel)
        self.informationContainerView.addSubview(self.descriptionLabel)
        
        self.informationContainerView.addSubview(self.availableLabel)
        
        self.containerView.backgroundColor = .brown.withAlphaComponent(0.5)
        
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - TourCell
    // /////////////////////////////////////////////////////////////////////////
    
    func makeConstraints() {
        
        self.containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        self.thumbnail.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(100)
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
        }
        
        self.informationContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(self.thumbnail.snp.trailing).offset(10)
            make.trailing.equalTo(self.priceLabel.snp.leading).offset(-10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        self.availableLabel.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(110)
            make.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().inset(10)
        }
    }
}
