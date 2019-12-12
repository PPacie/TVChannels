//
//  PresentationLayerTests.swift
//  PresentationLayerTests
//
//  Created by Pablo Paciello on 18/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import XCTest
@testable import PresentationLayer
@testable import DomainLayer

class PresentationLayerTests: XCTestCase {
    var parser: Parser!
    var channels: [Channel]!
    var parsedDisplayData: [ChannelDisplayData]!

    override func setUp() {
        parser = Parser()
        channels = [Channel(name: "Off", progress: 0.14519550677976), Channel(name: "FuelTV", progress: 0.63291992820635)]
    }

    override func tearDown() {
        parser = nil
        channels = nil
        parsedDisplayData = nil
    }

    func testParser() {
        XCTAssertNil(parsedDisplayData)
        parsedDisplayData = parser.createDisplayDataFrom(channelList: channels)
        XCTAssertNotNil(parsedDisplayData)
        XCTAssertEqual(parsedDisplayData.count, 2)
        
        //Parsing Tests
        XCTAssertEqual(parsedDisplayData[0].name, channels[0].name)
        XCTAssertEqual(parsedDisplayData[0].progress, channels[0].progress)
        XCTAssertEqual(parsedDisplayData[1].name, channels[1].name)
        XCTAssertEqual(parsedDisplayData[1].progress, channels[1].progress)
        
        //DisplatyData roundedProgress
        XCTAssertEqual(parsedDisplayData[0].roundedProgress(), "14%")
        XCTAssertEqual(parsedDisplayData[1].roundedProgress(), "63%")
    }
}
