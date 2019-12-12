//
//  MainScreenViewModel.swift
//  PresentationLayer
//
//  Created by Pablo Paciello on 18/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import Foundation
import DomainLayer
import Combine

public final class MainScreenViewModel: ObservableObject {
    @Published public private(set) var channelList: [ChannelDisplayData] = []
    private let parser: Parser
       
    public convenience init() {
        self.init(parser: Parser())
    }
    
    init(parser: Parser) {
        //Set private properties
        self.parser = parser
        
        //Fetch Data
        fetchData()
    }
    
    func fetchData() {
        channelList = parser.createDisplayDataFrom(channelList: DiskData.channels).sorted { $0.name < $1.name }
    }
}
