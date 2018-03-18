//
//  UIFont+Shared.swift
//  Fitness
//
//  Created by Keivan Shahida on 3/14/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

extension UIFont {
    //SYSTEM
    static let _14SFLight = UIFont.systemFont(ofSize: 14, weight: .light)
    static let _16SFLight = UIFont.systemFont(ofSize: 16, weight: .light)
    
    static let _14SFRegular = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    static let _8SFBold = UIFont.systemFont(ofSize: 8, weight: .bold)
    static let _16SFBold = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let _18SFBold = UIFont.systemFont(ofSize: 18, weight: .bold)
    
    //BEBAS
    static let _18Bebas = UIFont(name: "BebasNeue-Regular", size: 18)
    static let _48Bebas = UIFont(name: "BebasNeue-Regular", size: 48)
    
    //MONTSERRAT
    static let _14MontserratLight = UIFont(name: "Montserrat-Light", size: 14)
    static let _16MontserratLight = UIFont(name: "Montserrat-Light", size: 16)

    static let _16MontserratMedium = UIFont(name: "Montserrat-Medium", size: 16)
}
