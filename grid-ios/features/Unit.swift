//
//  Unit.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/3/22.
//

import Foundation

/**
 * Unit
 */
enum Unit: Int {
    
    /**
     * Degrees
     */
    case DEGREE
    
    /**
     * Meters
     */
    case METER

    var descriptor:String{
        switch self{
        case .DEGREE: return "DEGREE"
        case .METER: return "METER"
        }
    }

    init(descriptor: String){
        switch descriptor {
            case "DEGREE": self = .DEGREE
            case "METER": self = .METER
            default: self = .DEGREE
        }
    }
    
}
