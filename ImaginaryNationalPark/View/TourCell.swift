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
    
    private var containerView: UIView = UIView()
    private var informationContainerView: UIView = UIView()
    
    var thumbnail: UIImageView = UIImageView().configure { imageView in
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    var titleLabel: UILabel = UILabel().configure { label in
        label.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    var priceLabel: UILabel = UILabel().configure { label in
        label.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    var descriptionLabel: UILabel = UILabel().configure { label in
        label.numberOfLines = 0
    }

    var availableLabel: UILabel = UILabel()

    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.containerView)
        
        self.containerView.addSubview(self.thumbnail)
        self.containerView.addSubview(self.informationContainerView)
        
        self.informationContainerView.addSubview(self.titleLabel)
        self.informationContainerView.addSubview(self.priceLabel)
        
        self.containerView.addSubview(self.descriptionLabel)
        self.containerView.addSubview(self.availableLabel)
        
        self.containerView.backgroundColor = .brown.withAlphaComponent(0.5)
        
        self.makeConstraints()
    }
    
    @available(*, unavailable)
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
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(80)
            make.width.equalTo(100)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
        }
        
        self.informationContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(self.thumbnail.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(self.priceLabel.snp.leading)
        }
        
        self.priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(120)
            make.trailing.equalToSuperview()
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.informationContainerView.snp.bottom)
            make.leading.equalTo(self.thumbnail.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        self.availableLabel.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.thumbnail.snp.trailing).offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
}
