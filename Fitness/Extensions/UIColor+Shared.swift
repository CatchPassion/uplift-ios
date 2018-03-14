//
//  UIColor+Shared.swift
//  Fitness
//
//  Created by Keivan Shahida on 3/14/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

extension UIColor {

    @nonobjc static let fitnessWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    @nonobjc static let fitnessBlack = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1.0)
    
    @nonobjc static let fitnessLightGrey = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)


    public static func colorFromCode(_ code: Int) -> UIColor {
        let red = CGFloat(((code & 0xFF0000) >> 16)) / 255
        let green = CGFloat(((code & 0xFF00) >> 8)) / 255
        let blue = CGFloat((code & 0xFF)) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

