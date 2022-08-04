//
//  GridTile.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/3/22.
//

import Foundation

/**
 * Grid Tile
 */
class GridTile {
    
    /**
     * Tile width
     */
    var width: Int
    
    /**
     * Tile height
     */
    var height: Int
    
    /**
     * Zoom level
     */
    var zoom: Int
    
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
    init(width: Int, height: Int, x: Int, y: Int, zoom: Int) {
        self.width = width
        self.height = height
        self.zoom = zoom
        self.bounds = GridUtils.bounds(x: x, y: y, zoom: zoom)
    }
    
    /**
     * Initialize
     *
     * @param width
     *            tile width
     * @param height
     *            tile height
     * @param bounds
     *            tile bounds
     */
    init(width: Int, height: Int, bounds: Bounds) {
        self.width = width
        self.height = height
        self.bounds = bounds
        self.zoom = Int(round(GridUtils.zoomLevel(bounds: bounds)))
    }
    
    /**
     * Get the bounds in the units
     *
     * @param unit
     *            units
     * @return bounds in units
     */
    func bounds(unit: Unit) -> Bounds {
        return bounds.toUnit(unit: unit)
    }
    
    /**
     * Get the bounds in degrees
     *
     * @return bounds in degrees
     */
    func boundsDegrees() -> Bounds {
        return bounds(unit: Unit.DEGREE)
    }
    
    /**
     * Get the bounds in meters
     *
     * @return bounds in meters
     */
    func boundsMeters() -> Bounds {
        return bounds(unit: Unit.METER)
    }
    
    /**
     * Get the point pixel location in the tile
     *
     * @param point
     *            point
     * @return pixel
     */
    func pixel(point: Point) -> Pixel {
        return GridUtils.pixel(width: width, height: height, bounds: bounds, point: point)
    }

    /**
     * Get the longitude in meters x pixel location in the tile
     *
     * @param longitude
     *            longitude in meters
     * @return x pixel
     */
    func xPixel(longitude: Double) -> Float {
        return GridUtils.xPixel(width: width, bounds: bounds, longitude: longitude)
    }

    /**
     * Get the latitude (in meters) y pixel location in the tile
     *
     * @param latitude
     *            latitude in meters
     * @return y pixel
     */
    func yPixel(latitude: Double) -> Float {
        return GridUtils.yPixel(height: height, bounds: bounds, latitude: latitude)
    }
    
}
