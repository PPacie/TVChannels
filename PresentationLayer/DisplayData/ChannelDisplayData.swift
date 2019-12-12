//
//  ChannelDisplayData.swift
//  PresentationLayer
//
//  Created by Pablo Paciello on 18/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import Foundation

public struct ChannelDisplayData {
    public let name: String
    public let progress: Double
    
    public func roundedProgress() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.roundingMode = .down
        return numberFormatter.string(from: NSNumber(value: progress*100))?.appending("%")
    }
}
