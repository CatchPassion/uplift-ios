//
//  HomeCollectionHeaderView.swift
//  Fitness
//
//  Created by Joseph Fulgieri on 3/18/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//
<<<<<<< HEAD
=======

>>>>>>> master
import UIKit

class HomeSectionHeaderView: UICollectionReusableView {
    
    // MARK: - INITIALIZATION
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
<<<<<<< HEAD
        
=======
    
>>>>>>> master
        backgroundColor = UIColor.clear
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .gray
        addSubview(titleLabel)
        
        // MARK: - CONSTRAINTS
        titleLabel.snp.updateConstraints{make in
            make.left.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
