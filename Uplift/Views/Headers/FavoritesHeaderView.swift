//
//  FavoritesHeaderView.swift
//  Uplift
//
//  Created by Joseph Fulgieri on 4/15/18.
//  Copyright © 2018 Uplift. All rights reserved.
//

import SnapKit
import UIKit

class FavoritesHeaderView: UICollectionReusableView {

    // MARK: - INITIALIZAITON
    static let identifier =  Identifiers.favoritesHeaderView
    var nextSessionsLabel: UILabel!
    var quoteLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        // BACKGROUND COLOR
        backgroundColor = .white

        // QUOTE LABEL
        quoteLabel = UILabel()
        quoteLabel.font = ._32Bebas
        quoteLabel.textColor = .primaryBlack
        quoteLabel.textAlignment = .center
        quoteLabel.lineBreakMode = .byWordWrapping
        quoteLabel.numberOfLines = 0
        quoteLabel.text = ClientStrings.Favorites.hasFavoritesText
        addSubview(quoteLabel)

        // SESSIONS LABEL
        nextSessionsLabel = UILabel()
        nextSessionsLabel.font = ._16MontserratBold
        nextSessionsLabel.textColor = .primaryBlack
        nextSessionsLabel.textAlignment = .center
        nextSessionsLabel.text = ClientStrings.Favorites.comingUpNextLabel
        addSubview(nextSessionsLabel)

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - CONSTRAINTS
    func setupConstraints() {
        quoteLabel.snp.updateConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(64)
        }

        nextSessionsLabel.snp.updateConstraints { make in
            make.top.equalTo(quoteLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().offset(40)
            make.height.equalTo(18)
        }
    }
}
