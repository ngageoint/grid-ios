//
//  Hemisphere.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/5/22.
//

import Foundation

/**
 * Hemisphere enumeration
 */
enum Hemisphere: Int {
    
    /**
     * Northern hemisphere
     */
    case NORTH
    
    /**
     * Southern hemisphere
     */
    case SOUTH
    
    /**
     * Get the hemisphere for the latitude
     *
     * @param latitude
     *            latitude
     * @return hemisphere
     */
    static func from(latitude: Double) -> Hemisphere {
        return latitude >= 0 ? Hemisphere.NORTH : Hemisphere.SOUTH
    }

    /**
     * Get the hemisphere for the point
     *
     * @param point
     *            point
     * @return hemisphere
     */
    static func from(point: Point) -> Hemisphere {
        return from(latitude: point.latitide)
    }
    
}
