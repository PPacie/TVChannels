//
//  UIViewExtension.swift
//  TVChannels
//
//  Created by Pablo Paciello on 19/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import UIKit

extension UIView {    
    static var reuseIdentifier: String { return "\(self)" }
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
