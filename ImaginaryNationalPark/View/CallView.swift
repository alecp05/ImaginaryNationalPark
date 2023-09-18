//
//  CallButton.swift
//  ImaginaryNationalPark
//
//  Created by Alec on 13.09.23.
//

import SnapKit
import UIKit

// /////////////////////////////////////////////////////////////////////////
// MARK: - CallView -
// /////////////////////////////////////////////////////////////////////////

class CallView: UIView {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    private var systemImageView: UIImageView = UIImageView().configure { imageView in
        imageView.image = UIImage(systemName: "phone")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .black
    }
    
    private var buttonLabel: UILabel = UILabel().configure { label in
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(20)
        label.text = "CALL TO BOOK"
        label.textColor = .black
        label.textAlignment = .center
    }
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .brown.withAlphaComponent(0.5)
        
        self.addSubview(self.systemImageView)
        self.addSubview(self.buttonLabel)
        
        self.makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        
        self.systemImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(self.systemImageView.snp.height)
        }
        
        self.buttonLabel.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(self.systemImageView.snp.trailing)
        }
    }
}
