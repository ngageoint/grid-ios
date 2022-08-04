//
//  GridConstants.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/4/22.
//

import Foundation
import sf_ios

/**
 * Grid Constants
 */
struct GridConstants {
    
    /**
     * Minimum longitude
     */
    static let MIN_LON = -SF_WGS84_HALF_WORLD_LON_WIDTH
    
    /**
     * Maximum longitude
     */
    static let MAX_LON = SF_WGS84_HALF_WORLD_LON_WIDTH

    /**
     * Minimum latitude
     */
    static let MIN_LAT = -SF_WGS84_HALF_WORLD_LAT_HEIGHT

    /**
     * Maximum latitude
     */
    static let MAX_LAT = SF_WGS84_HALF_WORLD_LAT_HEIGHT

    /**
     * Omitted band letter 'I'
     */
    static let BAND_LETTER_OMIT_I: Character = "I"

    /**
     * Omitted band letter 'O'
     */
    static let BAND_LETTER_OMIT_O: Character = "O"

    /**
     * Max map zoom level
     */
    static let MAX_MAP_ZOOM_LEVEL = 21

    /**
     * North single character as a string
     */
    static let NORTH_CHAR = "N"

    /**
     * South single character as a string
     */
    static let SOUTH_CHAR = "S"

    /**
     * West single character as a string
     */
    static let WEST_CHAR = "W"

    /**
     * East single character as a string
     */
    static let EAST_CHAR = "E"
    
}
