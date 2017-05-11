//
//  Common.swift
//  Smulle
//
//  Created by Mattias Almén on 2017-03-06.
//  Copyright © 2017 pixlig.se. All rights reserved.
//

import UIKit

class ColorPalette {
    static var pink: UIColor { return UIColor(red: 0xF2, green: 0x74, blue: 0x90) }
    static var mint: UIColor { return UIColor(red: 0xB0, green: 0xF2, blue: 0xC1) }
    static var darkText: UIColor { return UIColor(red: 0x1F, green: 0x24, blue: 0x21) }
    static var darkGray: UIColor { return UIColor(red: 0x14, green: 0x14, blue: 0x14) }
    static var lightGray: UIColor { return UIColor(red: 0x21, green: 0x21, blue: 0x21) }
}

class Gradients {
    
    static var gray: CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [ColorPalette.darkGray.cgColor, ColorPalette.lightGray.cgColor]
        return gradient
    }
}

class Fonts {
    static var biggerBold: UIFont { return UIFont(name: "AvenirNext-DemiBold", size: 19)! }
    static var big: UIFont { return UIFont(name: "Avenir Next", size: 72)! }
    static var medium: UIFont { return UIFont(name: "Avenir Next", size: 20)! }
}
