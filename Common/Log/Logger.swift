//
//  Logger.swift
//  TVChannels
//
//  Created by Pablo Paciello on 19/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import Foundation

public enum Log {
    public static func debug(_ text: String?) {
        guard let text = text else { return }
        
        #if DEBUG
            print(text)
        #endif
    }
}
