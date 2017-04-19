//
//  UIColor.swift
//  Swift extensions
//
//  Created by Anatoliy Voropay on 5/7/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /**
        This will create UIColor from a hex string. It will work correctly if hex string will contain # prefix or not.
        It will return nil if string could not be converted to UIColor (i.e. when color string is less than 6 symbols length)
        In a returned UIColor alpha component always will be 1
    
        :param: string is a hex color string. I.e. *#FFAD12* or *DDAA55*
    
        :returns: UIColor from hex string
    */

    public convenience init(hexString: String) {
        let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner            = Scanner(string: hexString as String)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color:UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:1)
    }


    // MARK: - Flat UI Colors (http://www.flatuicolors.com)

    public static var turquoise: UIColor { return UIColor(hexString: "#1abc9c") }
    public static var greenEmerald: UIColor { return UIColor(hexString: "#2ecc71") }
    public static var blueSky: UIColor { return UIColor(hexString: "#3498db") }
    public static var purpleAmethyst: UIColor { return UIColor(hexString: "#9b59b6") }
    public static var blueAsphalt: UIColor { return UIColor(hexString: "#34495e") }
    public static var greenSea: UIColor { return UIColor(hexString: "#16a085") }
    public static var greenNephritis: UIColor { return UIColor(hexString: "#16a085") }
    public static var blueBelize: UIColor { return UIColor(hexString: "#2980b9") }
    public static var purpleWisteria: UIColor { return UIColor(hexString: "#8e44ad") }
    public static var blueMidnight: UIColor { return UIColor(hexString: "#2c3e50") }
    public static var yellowSunFlower: UIColor { return UIColor(hexString: "#f1c40f") }
    public static var orangeCarrot: UIColor { return UIColor(hexString: "#e67e22") }
    public static var redAlizarin: UIColor { return UIColor(hexString: "#e74c3c") }
    public static var whiteClouds: UIColor { return UIColor(hexString: "#ecf0f1") }
    public static var grayConcrete: UIColor { return UIColor(hexString: "#95a5a6") }
    public static var orangeFlat: UIColor { return UIColor(hexString: "#f39c12") }
    public static var pumpkin: UIColor { return UIColor(hexString: "#d35400") }
    public static var redPomegranate: UIColor { return UIColor(hexString: "#c0392b") }
    public static var silverFlat: UIColor { return UIColor(hexString: "#bdc3c7") }
    public static var grayAsbestos: UIColor { return UIColor(hexString: "#7f8c8d") }

    // MARK: - ResearchKit Colors

    public static var lightGreenResearchKit: UIColor { return UIColor(hexString: "#22e299") }
    public static var darkGreenResearchKit: UIColor { return UIColor(hexString: "#2c9e88") }

    // MARK: - CareKit Colors

    public static var lightPurpleCareKit: UIColor { return UIColor(hexString: "#6e81ee") }
    public static var darkPurpleCareKit: UIColor { return UIColor(hexString: "#43519b") }

    // MARK: - CareKit-ResearchKit Marketing Colors

    public static var pinkCareKitMarketing: UIColor { return UIColor(hexString: "#fe2e6a") }
    public static var blueCareKitMarketing: UIColor { return UIColor(hexString: "#18c3e2") }
    public static var greenCareKitMarketing: UIColor { return UIColor(hexString: "#8bce26") }
    public static var orangeCareKitMarketing: UIColor { return UIColor(hexString: "#fe7700") }
    public static var darkPinkCareKitMarketing: UIColor { return UIColor(hexString: "#a01949") }
    public static var darkBlueCareKitMarketing: UIColor { return UIColor(hexString: "#1a6d7c") }
    public static var darkGreenCareKitMarketing: UIColor { return UIColor(hexString: "#53771f") }
    public static var darkOrangeCareKitMarketing: UIColor { return UIColor(hexString: "#a24e04") }
    public static var blackCareKitMarketing: UIColor { return UIColor(hexString: "#1b1b1b") }
    public static var darkGrayCareKitMarketing: UIColor { return UIColor(hexString: "#2d2d2d") }
    public static var grayCareKitMarketing: UIColor { return UIColor(hexString: "#494949") }
    public static var lightGrayCareKitMarketing: UIColor { return UIColor(hexString: "#9a999a") }


    // MARK: - Tesla Paint Colors

    public static var solidBlack: UIColor { return UIColor(hexString: "#000101") }
    public static var solidWhite: UIColor { return UIColor(hexString: "#c2c2c2") }
    public static var titaniumMetallic: UIColor { return UIColor(hexString: "#3b3531") }
    public static var midnightSilverMetallic: UIColor { return UIColor(hexString: "#121114") }
    public static var obsidianBlackMetallic: UIColor { return UIColor(hexString: "#110f10") }
    public static var deepBlueMetallic: UIColor { return UIColor(hexString: "#051137") }
    public static var silverMetallic: UIColor { return UIColor(hexString: "#7f8281") }
    public static var pearlWhiteMultiCoat: UIColor { return UIColor(hexString: "#c8caca") }
    public static var redMultiCoat: UIColor { return UIColor(hexString: "#7b131b") }

    public static var solidBlackHighlight: UIColor { return UIColor(hexString: "#212323") }
    public static var solidWhiteHighlight: UIColor { return UIColor(hexString: "#fefefe") }
    public static var titaniumMetallicHighlight: UIColor { return UIColor(hexString: "#948a81") }
    public static var midnightSilverMetallicHighlight: UIColor { return UIColor(hexString: "#2d2f35") }
    public static var obsidianBlackMetallicHighlight: UIColor { return UIColor(hexString: "#2a292c") }
    public static var deepBlueMetallicHighlight: UIColor { return UIColor(hexString: "#042c6f") }
    public static var silverMetallicHighlight: UIColor { return UIColor(hexString: "#e7e7e7") }
    public static var pearlWhiteMultiCoatHighlight: UIColor { return UIColor(hexString: "#fefefe") }
    public static var redMultiCoatHighlight: UIColor { return UIColor(hexString: "#df3848") }

    // MARK: Status

    public static var greenStatus: UIColor { return UIColor(red: 220/255.0, green: 237/255.0, blue: 200/255.0, alpha: 1) }

    public static var amberStatus: UIColor { return UIColor(red: 255/255.0, green: 236/255.0, blue: 179/255.0, alpha: 1) }

    public static var redStatus: UIColor { return UIColor(red: 255/255.0, green: 217/255.0, blue: 223/255.0, alpha: 1) }

    public static var redWarning: UIColor { return UIColor(hexString: "#ff6666") }

    public static var redError: UIColor { return UIColor(red: 255/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.6) }


    // MARK: Backgrounds

    public static var lightGrayBackground: UIColor { return UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1) }

    // MARK: Others
    public static var grayPlaceholder: UIColor { return UIColor(hexString: "#d0d3d4") }
    
    public static var flipside: UIColor { return UIColor(hexString: "#18191B") }

    // MARK: - Molina Colors

    public static var molinaTeal: UIColor { return UIColor(hexString: "#0096A5") }
    public static var molinaYellow: UIColor { return UIColor(red: 222/255.0, green: 180/255.0, blue: 8/255.0, alpha: 1) }
    public static var molinaGreen: UIColor { return UIColor(red: 159/255.0, green: 166/255.0, blue: 23/255.0, alpha: 1) }
    public static var molinaBlue: UIColor { return UIColor(red: 0/255.0, green: 45/255.0, blue: 98/255.0, alpha: 1) }
    public static var molinaOrange: UIColor { return UIColor(red: 227/255.0, green: 111/255.0, blue: 30/255.0, alpha: 1) }
    public static var molinaRed: UIColor { return UIColor(red: 130/255.0, green: 0/255.0, blue: 36/255.0, alpha: 1) }
    public static var molinaBlack: UIColor { return UIColor(red: 77/255.0, green: 77/255.0, blue: 79/255.0, alpha: 1) }
    
    
    // MARK: - HIH Colors
    
    public static var darkishPurple: UIColor { return UIColor(hexString: "#9C1F60") }
    public static var mediumGray: UIColor { return UIColor(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1) }
    public static var greyishBrown: UIColor { return UIColor(red: 61/255.0, green: 61/255.0, blue: 61/255.0, alpha: 1) }
}
