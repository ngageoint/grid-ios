//
//  Point.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/3/22.
//

import Foundation
import sf_ios

/**
 * Point
 */
class Point: SFPoint {
    
    /**
     * Unit
     */
    var unit: Unit
    
    /**
     * Create a point in degrees
     *
     * @param longitude
     *            longitude in degrees
     * @param latitude
     *            latitude in degrees
     * @return point in degrees
     */
    static func degrees(longitude: Double, latitude: Double) -> Point {
        return Point(longitude: longitude, latitude: latitude, unit: Unit.DEGREE)
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
    static func meters(longitude: Double, latitude: Double) -> Point {
        return Point(longitude: longitude, latitude: latitude, unit: Unit.METER)
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
    static func toUnit(fromUnit: Unit, longitude: Double, latitude: Double, toUnit: Unit) -> Point {
        return GridUtils.toUnit(fromUnit: fromUnit, longitude: longitude, latitude: latitude, toUnit: toUnit)
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
    static func toUnit(longitude: Double, latitude: Double, unit: Unit) -> Point {
        return GridUtils.toUnit(longitude: longitude, latitude: latitude, unit: unit)
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
    static func degreesToMeters(longitude: Double, latitude: Double) -> Point {
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
    static func metersToDegrees(longitude: Double, latitude: Double) -> Point {
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
    convenience init(longitude: Double, latitude: Double) {
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
    init(longitude: Double, latitude: Double, unit: Unit) {
        self.unit = unit
        super.init(hasZ: false, andHasM: false, andX: NSDecimalNumber.init(value: longitude), andY: NSDecimalNumber.init(value: latitude))
    }
    
    /**
     * Initialize
     *
     * @param point
     *            point to copy
     */
    convenience init(point: Point) {
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
    init(point: SFPoint, unit: Unit) {
        self.unit = unit
        super.init(hasZ: point.hasZ, andHasM: point.hasM, andX: point.x, andY: point.y)
        z = point.z
        m = point.m
    }
    
    /**
     * The longitude
     */
    var longitude: Double {
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
    var latitide: Double {
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
    func isUnit(unit: Unit) -> Bool {
        return self.unit == unit
    }
    
    /**
     * Is this point in degrees
     *
     * @return true if degrees
     */
    func isDegrees() -> Bool {
        return isUnit(unit: Unit.DEGREE)
    }
    
    /**
     * Is this point in meters
     *
     * @return true if meters
     */
    func isMeters() -> Bool {
        return isUnit(unit: Unit.METER)
    }
    
    /**
     * Convert to the unit
     *
     * @param unit
     *            unit
     * @return point in units, same point if equal units
     */
    func toUnit(unit: Unit) -> Point {
        var point: Point
        if (isUnit(unit: unit)) {
            point = self
        } else {
            point = GridUtils.toUnit(fromUnit: self.unit, longitude: longitude, latitude: latitide, toUnit: unit)
        }
        return point
    }
    
    /**
     * Convert to degrees
     *
     * @return point in degrees, same point if already in degrees
     */
    func toDegrees() -> Point {
        return toUnit(unit: Unit.DEGREE)
    }
    
    /**
     * Convert to meters
     *
     * @return point in meters, same point if already in meters
     */
    func toMeters() -> Point {
        return toUnit(unit: Unit.METER)
    }
    
    /**
     * Get the pixel where the point fits into tile
     *
     * @param tile
     *            tile
     * @return pixel
     */
    func pixel(tile: GridTile) -> Pixel {
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
    func pixel(width: Int, height: Int, bounds: Bounds) -> Pixel {
        return GridUtils.pixel(width: width, height: height, bounds: bounds, point: self)
    }
    
    override func mutableCopy(with zone: NSZone? = nil) -> Any {
        return Point(point: self)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(unit.rawValue, forKey: "unit")
        super.encode(with: coder)
    }
    
    required init?(coder: NSCoder) {
        unit = Unit.init(rawValue: coder.decodeInteger(forKey: "unit"))!
        super.init(coder: coder)
    }
    
    func isEqual(point: Point?) -> Bool {
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
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if(!(object is Point)) {
            return false
        }
        
        return isEqual(point: object as? Point)
    }

    override var hash: Int {
        let prime = 31
        var result = super.hash
        result = prime * result + unit.rawValue
        return result
    }
    
}
