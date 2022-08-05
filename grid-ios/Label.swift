//
//  Label.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/5/22.
//

import Foundation

/**
 * Grid Label
 */
class Label {
    
    /**
     * Name
     */
    var name: String
    
    /**
     * Center point
     */
    var center: Point
    
    /**
     * Bounds
     */
    var bounds: Bounds
    
    /**
     * Initialize
     *
     * @param width
     *            tile width
     * @param height
     *            tile height
     * @param x
     *            x coordinate
     * @param y
     *            y coordinate
     * @param zoom
     *            zoom level
     */
    init(name: String, center: Point, bounds: Bounds) {
        self.name = name
        self.center = center
        self.bounds = bounds
    }

}
