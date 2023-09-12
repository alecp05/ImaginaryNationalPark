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
    
    var titleLabel: UILabel = UILabel()
    
    var containerView: UIView = UIView()
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - BookCell
    // /////////////////////////////////////////////////////////////////////////
    
    func makeConstraints() {
        
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
