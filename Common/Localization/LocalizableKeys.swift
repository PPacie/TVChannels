//
//  LocalizableKeys.swift
//  TVChannels
//
//  Created by Pablo Paciello on 19/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import Foundation

public enum LocalizableKeys: String {    
    case errorTitle,
    ok,
    networkRequestFailed,
    retry,
    completed
}

public func localized<T: RawRepresentable>(_ key: T) -> String where T.RawValue == String {
     return NSLocalizedString(key.rawValue, comment: "")
}
