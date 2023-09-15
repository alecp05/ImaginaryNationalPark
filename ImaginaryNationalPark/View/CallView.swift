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
    
    private var systemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        return imageView
    }()
    
    private var buttonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(20)
        label.text = "CALL TO BOOK"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
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
