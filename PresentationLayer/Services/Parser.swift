//
//  Parser.swift
//  PresentationLayer
//
//  Created by Pablo Paciello on 18/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import Foundation
import DomainLayer

struct Parser {    
    func createDisplayDataFrom(channelList channels: [Channel]) -> [ChannelDisplayData] {
        var displayData = [ChannelDisplayData]()
        
        channels.forEach {
            let channel = ChannelDisplayData(name: $0.name, progress: $0.progress)
            displayData.append(channel)
        }
        
        return displayData
    }
}
