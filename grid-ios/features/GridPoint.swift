//
//  GridPoint.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/3/22.
//

import Foundation
import sf_ios

/**
 * Point
 */
public class GridPoint: SFPoint {
    
    /**
     * Unit
     */
    public var unit: Unit
    
    /**
     * Create a point in degrees
     *
     * @param longitude
     *            longitude in degrees
     * @param latitude
     *            latitude in degrees
     * @return point in degrees
     */
    public static func degrees(longitude: Double, latitude: Double) -> GridPoint {
        return GridPoint(longitude: longitude, latitude: latitude, unit: Unit.DEGREE)
    }

    /**
     * Create a point in meters
     *
     * @param longitude
     *            longitude in meters
     * @param latitude
     *            latitude in meters
     * @return point in meters
     */
    public static func meters(longitude: Double, latitude: Double) -> GridPoint {
        return GridPoint(longitude: longitude, latitude: latitude, unit: Unit.METER)
    }

    /**
     * Create a point from a coordinate in a unit to another unit
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
    public static func toUnit(fromUnit: Unit, longitude: Double, latitude: Double, toUnit: Unit) -> GridPoint {
        return GridUtils.toUnit(fromUnit, longitude, latitude, toUnit)
    }

    /**
     * Create a point from a coordinate in an opposite unit to another unit
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @param unit
     *            desired unit
     * @return point in unit
     */
    public static func toUnit(longitude: Double, latitude: Double, unit: Unit) -> GridPoint {
        return GridUtils.toUnit(longitude, latitude, unit)
    }

    /**
     * Create a point converting the degrees coordinate to meters
     *
     * @param longitude
     *            longitude in degrees
     * @param latitude
     *            latitude in degrees
     * @return point in meters
     */
    public static func degreesToMeters(longitude: Double, latitude: Double) -> GridPoint {
        return toUnit(fromUnit: Unit.DEGREE, longitude: longitude, latitude: latitude, toUnit: Unit.METER)
    }

    /**
     * Create a point converting the meters coordinate to degrees
     *
     * @param longitude
     *            longitude in meters
     * @param latitude
     *            latitude in meters
     * @return point in degrees
     */
    public static func metersToDegrees(longitude: Double, latitude: Double) -> GridPoint {
        return toUnit(fromUnit: Unit.METER, longitude: longitude, latitude: latitude, toUnit: Unit.DEGREE)
    }
    
    /**
     * Initialize, in DEGREE units
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     */
    public convenience init(longitude: Double, latitude: Double) {
        self.init(longitude: longitude, latitude: latitude, unit: Unit.DEGREE)
    }
    
    /**
     * Initialize
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @param unit
     *            unit
     */
    public init(longitude: Double, latitude: Double, unit: Unit) {
        self.unit = unit
        super.init(hasZ: false, andHasM: false, andX: NSDecimalNumber.init(value: longitude), andY: NSDecimalNumber.init(value: latitude))
    }
    
    /**
     * Initialize
     *
     * @param point
     *            point to copy
     */
    public convenience init(point: GridPoint) {
        self.init(point: point, unit: point.unit)
    }
    
    /**
     * Initialize
     *
     * @param point
     *            point to copy
     * @param unit
     *            unit
     */
    public init(point: SFPoint, unit: Unit) {
        self.unit = unit
        super.init(hasZ: point.hasZ, andHasM: point.hasM, andX: point.x, andY: point.y)
        z = point.z
        m = point.m
    }
    
    /**
     * The longitude
     */
    public var longitude: Double {
        get {
            return x.doubleValue
        }
        set(longitude) {
            setXValue(longitude)
        }
    }
    
    /**
     * The latitude
     */
    public var latitide: Double {
        get {
            return y.doubleValue
        }
        set(latitide) {
            setYValue(latitide)
        }
    }
    
    /**
     * Is in the provided unit type
     *
     * @param unit
     *            unit
     * @return true if in the unit
     */
    public func isUnit(unit: Unit) -> Bool {
        return self.unit == unit
    }
    
    /**
     * Is this point in degrees
     *
     * @return true if degrees
     */
    public func isDegrees() -> Bool {
        return isUnit(unit: Unit.DEGREE)
    }
    
    /**
     * Is this point in meters
     *
     * @return true if meters
     */
    public func isMeters() -> Bool {
        return isUnit(unit: Unit.METER)
    }
    
    /**
     * Convert to the unit
     *
     * @param unit
     *            unit
     * @return point in units, same point if equal units
     */
    public func toUnit(unit: Unit) -> GridPoint {
        var point: GridPoint
        if (isUnit(unit: unit)) {
            point = self
        } else {
            point = GridUtils.toUnit(self.unit, longitude, latitide, unit)
        }
        return point
    }
    
    /**
     * Convert to degrees
     *
     * @return point in degrees, same point if already in degrees
     */
    public func toDegrees() -> GridPoint {
        return toUnit(unit: Unit.DEGREE)
    }
    
    /**
     * Convert to meters
     *
     * @return point in meters, same point if already in meters
     */
    public func toMeters() -> GridPoint {
        return toUnit(unit: Unit.METER)
    }
    
    /**
     * Get the pixel where the point fits into tile
     *
     * @param tile
     *            tile
     * @return pixel
     */
    public func pixel(tile: GridTile) -> Pixel {
        return pixel(width: tile.width, height: tile.height, bounds: tile.bounds)
    }

    /**
     * Get the pixel where the point fits into the bounds
     *
     * @param width
     *            width
     * @param height
     *            height
     * @param bounds
     *            bounds
     * @return pixel
     */
    public func pixel(width: Int, height: Int, bounds: Bounds) -> Pixel {
        return GridUtils.pixel(width, height, bounds, self)
    }
    
    public override func mutableCopy(with zone: NSZone? = nil) -> Any {
        return GridPoint(point: self)
    }
    
    public override func encode(with coder: NSCoder) {
        coder.encode(unit.rawValue, forKey: "unit")
        super.encode(with: coder)
    }
    
    public required init?(coder: NSCoder) {
        unit = Unit.init(rawValue: coder.decodeInteger(forKey: "unit"))!
        super.init(coder: coder)
    }
    
    public func isEqual(_ point: GridPoint?) -> Bool {
        if(self == point) {
            return true
        }
        if(point == nil) {
            return false
        }
        if(!super.isEqual(point)) {
            return false
        }
        if(unit != point?.unit){
            return false
        }
        return true
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        
        if(!(object is GridPoint)) {
            return false
        }
        
        return isEqual(object as? GridPoint)
    }

    public override var hash: Int {
        let prime = 31
        var result = super.hash
        result = prime * result + unit.rawValue
        return result
    }
    
}
