//
//  UIColorExtension.swift
//  TVChannels
//
//  Created by Pablo Paciello on 19/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import UIKit

extension UIColor {    
    class func loadingRedToGreenColor(progress: Double) -> UIColor {
        UIColor(hue: 0.35*CGFloat(progress), saturation: 0.83, brightness: 0.99, alpha: 1.0)
    }
}
