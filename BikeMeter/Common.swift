//
//  Common.swift
//  Smulle
//
//  Created by Mattias Almén on 2017-03-06.
//  Copyright © 2017 pixlig.se. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class ColorPalette {
    static var pink: UIColor { return UIColor(red: 0xF2, green: 0x74, blue: 0x90) }
    static var mint: UIColor { return UIColor(red: 0xB0, green: 0xF2, blue: 0xC1) }
    static var darkText: UIColor { return UIColor(red: 0x1F, green: 0x24, blue: 0x21) }
}

class Fonts {
    static var biggerBold: UIFont { return UIFont(name: "AvenirNext-DemiBold", size: 19)! }
    static var big: UIFont { return UIFont(name: "Avenir Next", size: 72)! }
    static var medium: UIFont { return UIFont(name: "Avenir Next", size: 20)! }
}
