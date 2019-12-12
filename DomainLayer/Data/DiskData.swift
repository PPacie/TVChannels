//
//  DiskData.swift
//  DomainLayer
//
//  Created by Pablo Paciello on 12/12/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import Foundation

//Note: We use this class to get the Bundle of DomainLayer as we don't have any other Class.
fileprivate final class BundleClass {}

public struct DiskData {
    public static let channels: [Channel] = load("TVChannels.json")
    
    private static func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
        let data: Data
        
        guard let file = Bundle(for: BundleClass.self).url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
