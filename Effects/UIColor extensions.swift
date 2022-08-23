//
//  UIColor extensions.swift
//  Zenmob
//
//  Created by Frédéric ADDA on 29/05/2016.
//  Copyright © 2016 Geodis. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    // MARK: - Utility methods
    
    /** Initializes and returns a color object using RGB component values as integers on 255.*/
    convenience init(R: Int, G: Int, B: Int, alpha: CGFloat = 1) {
        assert(R >= 0 && R <= 255, "Invalid red component")
        assert(G >= 0 && G <= 255, "Invalid green component")
        assert(B >= 0 && B <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(R) / 255.0, green: CGFloat(G) / 255.0, blue: CGFloat(B) / 255.0, alpha: alpha)
    }

    
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: (CharacterSet.alphanumerics.inverted))
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    
    
    // MARK: - Custom app colors
    
    /** Dark blue */
    class var darkBlue: UIColor {
        return UIColor(hexString: "#186b94")
    }
    
    /** Very dark blue, used as a background for the sky */
    class var nightSkyBlue: UIColor {
        return UIColor(hexString: "#12203a")
    }
    
    /** Medium blue */
    class var mediumBlue: UIColor {
        return UIColor(hexString: "#1d9dc8")
    }
    
   }


