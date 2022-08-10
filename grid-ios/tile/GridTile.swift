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
public class GridTile {
    
    /**
     * Tile width
     */
    public var width: Int
    
    /**
     * Tile height
     */
    public var height: Int
    
    /**
     * Zoom level
     */
    public var zoom: Int
    
    /**
     * Bounds
     */
    public var bounds: Bounds
    
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
    public init(_ width: Int, _ height: Int, _ x: Int, _ y: Int, _ zoom: Int) {
        self.width = width
        self.height = height
        self.zoom = zoom
        self.bounds = GridUtils.bounds(x, y, zoom)
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
    public init(_ width: Int, _ height: Int, _ bounds: Bounds) {
        self.width = width
        self.height = height
        self.bounds = bounds
        self.zoom = Int(round(GridUtils.zoomLevel(bounds)))
    }
    
    /**
     * Get the bounds in the units
     *
     * @param unit
     *            units
     * @return bounds in units
     */
    public func bounds(_ unit: Unit) -> Bounds {
        return bounds.toUnit(unit)
    }
    
    /**
     * Get the bounds in degrees
     *
     * @return bounds in degrees
     */
    public func boundsDegrees() -> Bounds {
        return bounds(Unit.DEGREE)
    }
    
    /**
     * Get the bounds in meters
     *
     * @return bounds in meters
     */
    public func boundsMeters() -> Bounds {
        return bounds(Unit.METER)
    }
    
    /**
     * Get the point pixel location in the tile
     *
     * @param point
     *            point
     * @return pixel
     */
    public func pixel(_ point: GridPoint) -> Pixel {
        return GridUtils.pixel(width, height, bounds, point)
    }

    /**
     * Get the longitude in meters x pixel location in the tile
     *
     * @param longitude
     *            longitude in meters
     * @return x pixel
     */
    public func xPixel(_ longitude: Double) -> Float {
        return GridUtils.xPixel(width, bounds, longitude)
    }

    /**
     * Get the latitude (in meters) y pixel location in the tile
     *
     * @param latitude
     *            latitude in meters
     * @return y pixel
     */
    public func yPixel(_ latitude: Double) -> Float {
        return GridUtils.yPixel(height, bounds, latitude)
    }
    
}
