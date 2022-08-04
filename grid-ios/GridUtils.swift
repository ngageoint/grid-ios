//
//  GridUtils.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/4/22.
//

import Foundation
import sf_ios

/**
 * Grid utilities
 */
class GridUtils {

    /**
     * Get the pixel where the point fits into the bounds
     *
     * @param width
     *            width
     * @param height
     *            height
     * @param bounds
     *            bounds
     * @param point
     *            point
     * @return pixel
     */
    static func pixel(width: Int, height: Int, bounds: Bounds, point: Point) -> Pixel {
        
        let pointMeters = point.toMeters()
        let boundsMeters = bounds.toMeters()
        
        let x = xPixel(width: width, bounds: boundsMeters, longitude: pointMeters.longitude)
        let y = yPixel(height: height, bounds: boundsMeters, latitude: pointMeters.latitide)
        return Pixel(x: x, y: y)
    }
    
    /**
     * Get the X pixel for where the longitude in meters fits into the bounds
     *
     * @param width
     *            width
     * @param bounds
     *            bounds
     * @param longitude
     *            longitude in meters
     * @return x pixel
     */
    static func xPixel(width: Int, bounds: Bounds, longitude: Double) -> Float {
        
        let boundsMeters = bounds.toMeters()
        
        let boxWidth = boundsMeters.maxLongitude - boundsMeters.minLongitude
        let offset = longitude - boundsMeters.minLongitude
        let percentage = offset / boxWidth
        let pixel = Float(percentage * Double(width))

        return pixel
    }
    
    /**
     * Get the Y pixel for where the latitude in meters fits into the bounds
     *
     * @param height
     *            height
     * @param bounds
     *            bounds
     * @param latitude
     *            latitude
     * @return y pixel
     */
    static func yPixel(height: Int, bounds: Bounds, latitude: Double) -> Float {
        
        let boundsMeters = bounds.toMeters()
        
        let boxHeight = boundsMeters.maxLatitude - boundsMeters.minLatitude
        let offset = boundsMeters.maxLatitude - latitude
        let percentage = offset / boxHeight
        let pixel = Float(percentage * Double(height))

        return pixel
    }
    
    /**
     * Get the tile bounds from the XYZ tile coordinates and zoom level
     *
     * @param x
     *            x coordinate
     * @param y
     *            y coordinate
     * @param zoom
     *            zoom level
     * @return bounds
     */
    static func bounds(x: Int, y: Int, zoom: Int) -> Bounds {
        
        let tilesPerSide = tilesPerSide(zoom: zoom)
        let tileSize = tileSize(tilesPerSide: tilesPerSide)

        let minLon = (-1 * SF_WEB_MERCATOR_HALF_WORLD_WIDTH) + (Double(x) * tileSize)
        let minLat = SF_WEB_MERCATOR_HALF_WORLD_WIDTH - (Double(y + 1) * tileSize)
        let maxLon = (-1 * SF_WEB_MERCATOR_HALF_WORLD_WIDTH) + (Double(x + 1) * tileSize)
        let maxLat = SF_WEB_MERCATOR_HALF_WORLD_WIDTH - (Double(y) * tileSize)

        return Bounds.meters(minLongitude: minLon, minLatitude: minLat, maxLongitude: maxLon, maxLatitude: maxLat)
    }
    
    /**
     * Get the tiles per side, width and height, at the zoom level
     *
     * @param zoom
     *            zoom level
     * @return tiles per side
     */
    static func tilesPerSide(zoom: Int) -> Int {
        return Int(pow(2, Double(zoom)))
    }
    
    /**
     * Get the tile size in meters
     *
     * @param tilesPerSide
     *            tiles per side
     * @return tile size
     */
    static func tileSize(tilesPerSide: Int) -> Double {
        return (2 * SF_WEB_MERCATOR_HALF_WORLD_WIDTH) / Double(tilesPerSide)
    }
    
    /**
     * Get the zoom level of the bounds using the shortest bounds side length
     *
     * @param bounds
     *            bounds
     * @return zoom level
     */
    static func zoomLevel(bounds: Bounds) -> Double {
        let boundsMeters = bounds.toMeters()
        let tileSize = min(boundsMeters.width, boundsMeters.height)
        let tilesPerSide = 2 * SF_WEB_MERCATOR_HALF_WORLD_WIDTH / tileSize
        return log(tilesPerSide) / log(2)
    }
    
    /**
     * Convert a coordinate from a unit to another unit
     *
     * @param fromUnit
     *            unit of provided coordinate
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @param toUnit
     *            desired unit
     * @return point in unit
     */
    static func toUnit(fromUnit: Unit, longitude: Double, latitude: Double, toUnit: Unit) -> Point {
        var point: Point
        if (fromUnit == toUnit) {
            point = Point(longitude: longitude, latitude: latitude, unit: toUnit)
        } else {
            point = self.toUnit(longitude: longitude, latitude: latitude, unit: toUnit)
        }
        return point
    }
    
    /**
     * Convert a coordinate to the unit, assumes the coordinate is in the
     * opposite unit
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @param unit
     *            desired unit
     * @return point in unit
     */
    static func toUnit(longitude: Double, latitude: Double,
            unit: Unit) -> Point {
        var point: SFPoint
        switch unit {
        case .DEGREE:
            point = SFGeometryUtils.metersToDegreesWith(x: longitude, andY: latitude)
        case .METER:
            point = SFGeometryUtils.degreesToMetersWith(x: longitude, andY: latitude)
        }
        return Point(point: point, unit: unit)
    }
    
    /**
     * Is the band letter an omitted letter
     * GridConstants.BAND_LETTER_OMIT_I or
     * GridConstants.BAND_LETTER_OMIT_O
     *
     * @param letter
     *            band letter
     * @return true if omitted
     */
    static func isOmittedBandLetter(letter: Character) -> Bool {
        return letter == GridConstants.BAND_LETTER_OMIT_I || letter == GridConstants.BAND_LETTER_OMIT_O
    }
    
    /**
     * Get the precision value before the value
     *
     * @param value
     *            value
     * @param precision
     *            precision
     * @return precision value
     */
    static func precisionBefore(value: Double, precision: Double) -> Double {
        var before = 0.0
        if (abs(value) >= precision) {
            before = value - ((value.truncatingRemainder(dividingBy: precision) + precision).truncatingRemainder(dividingBy: precision))
        } else if (value < 0.0) {
            before = -precision
        }
        return before
    }

    /**
     * Get the precision value after the value
     *
     * @param value
     *            value
     * @param precision
     *            precision
     * @return precision value
     */
    static func precisionAfter(value: Double, precision: Double) -> Double {
        return precisionBefore(value: value + precision, precision: precision)
    }
    
    /**
     * Get the point intersection between two lines
     *
     * @param line1
     *            first line
     * @param line2
     *            second line
     * @return intersection point or null if no intersection
     */
    static func intersection(line1: Line, line2: Line) -> Point? {
        return intersection(line1Point1: line1.point1, line1Point2: line1.point2, line2Point1: line2.point1, line2Point2: line2.point2)
    }

    /**
     * Get the point intersection between end points of two lines
     *
     * @param line1Point1
     *            first point of the first line
     * @param line1Point2
     *            second point of the first line
     * @param line2Point1
     *            first point of the second line
     * @param line2Point2
     *            second point of the second line
     * @return intersection point or null if no intersection
     */
    static func intersection(line1Point1: Point, line1Point2: Point,
            line2Point1: Point, line2Point2: Point) -> Point? {
        
        var intersection: Point? = nil
        
        let point: SFPoint? = SFGeometryUtils.intersectionBetweenLine1Point1(line1Point1.toMeters(), andLine1Point2: line1Point2.toMeters(), andLine2Point1: line2Point1.toMeters(), andLine2Point2: line2Point2.toMeters())
        
        if (point != nil) {
            intersection = Point(point: point!, unit: Unit.METER).toUnit(unit: line1Point1.unit)
        }
        
        return intersection
    }
    
}
