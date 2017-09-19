//
//  UIColorExtensions.swift
//  FlickrImageViewer
//
//  Created by Alexey Danilov on 19/09/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        var hexInt: UInt64 = 0
        /*
         What does an ampersand (&) mean in the Swift language?
         It works as an inout to make the variable an in-out parameter.
         In-out means in fact passing value by reference, not by value.
         */
        scanner.scanHexInt64(&hexInt)
        
        print(hexInt)
        
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
