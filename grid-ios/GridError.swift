//
//  GridError.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/3/22.
//

import Foundation

struct GridError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
