//
//  Bounds.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/3/22.
//

import Foundation
import sf_ios

/**
 * Grid Bounds
 */
class Bounds: SFGeometryEnvelope {
    
    /**
     * Unit
     */
    var unit: Unit
    
    /**
     * Create bounds in degrees
     *
     * @param minLongitude
     *            min longitude
     * @param minLatitude
     *            min latitude
     * @param maxLongitude
     *            max longitude
     * @param maxLatitude
     *            max latitude
     * @return bounds
     */
    static func degrees(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double) -> Bounds {
        return Bounds(minLongitude: minLongitude, minLatitude: minLatitude, maxLongitude: maxLongitude, maxLatitude: maxLatitude, unit: Unit.DEGREE)
    }
    
    /**
     * Create bounds in meters
     *
     * @param minLongitude
     *            min longitude
     * @param minLatitude
     *            min latitude
     * @param maxLongitude
     *            max longitude
     * @param maxLatitude
     *            max latitude
     * @return bounds
     */
    static func meters(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double) -> Bounds {
        return Bounds(minLongitude: minLongitude, minLatitude: minLatitude, maxLongitude: maxLongitude, maxLatitude: maxLatitude, unit: Unit.METER)
    }
    
    /**
     * Initialize
     *
     * @param minLongitude
     *            min longitude
     * @param minLatitude
     *            min latitude
     * @param maxLongitude
     *            max longitude
     * @param maxLatitude
     *            max latitude
     */
    convenience init(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double) {
        self.init(minLongitude: minLongitude, minLatitude: minLatitude, maxLongitude: maxLongitude, maxLatitude: maxLatitude, unit: Unit.DEGREE)
    }
    
    /**
     * Initialize
     *
     * @param minLongitude
     *            min longitude
     * @param minLatitude
     *            min latitude
     * @param maxLongitude
     *            max longitude
     * @param maxLatitude
     *            max latitude
     * @param unit
     *            unit
     */
    init(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double, unit: Unit) {
        self.unit = unit
        super.init(minX: NSDecimalNumber.init(value: minLongitude), andMinY: NSDecimalNumber.init(value: minLatitude), andMinZ: nil, andMinM: nil, andMaxX: NSDecimalNumber.init(value: maxLongitude), andMaxY: NSDecimalNumber.init(value: maxLatitude), andMaxZ: nil, andMaxM: nil)
    }
    
    /**
     * Initialize
     *
     * @param southwest
     *            southwest corner
     * @param northeast
     *            northeast corner
     */
    convenience init(southwest: Point, northeast: Point) {
        self.init(minLongitude: southwest.longitude, minLatitude: southwest.latitide, maxLongitude: northeast.longitude, maxLatitude: northeast.latitide, unit: southwest.unit)
        
        if (!isUnit(unit: northeast.unit)) {
            preconditionFailure("Points are in different units. southwest: " + String(describing: unit) + ", northeast: " + String(describing: northeast.unit))
        }
    }
    
    /**
     * Initialize
     *
     * @param point
     *            point to copy
     */
    convenience init(bounds: Bounds) {
        self.init(envelope: bounds, unit: bounds.unit)
    }
    
    /**
     * Initialize
     *
     * @param envelope
     *            geometry envelope
     * @param unit
     *            unit
     */
    init(envelope: SFGeometryEnvelope, unit: Unit) {
        self.unit = unit
        super.init(minX: envelope.minX, andMinY: envelope.minY, andMinZ: envelope.minZ, andMinM: envelope.minM, andMaxX: envelope.maxX, andMaxY: envelope.maxY, andMaxZ: envelope.maxZ, andMaxM: envelope.maxM)
    }
    
    /**
     * The min longitude
     */
    var minLongitude: Double {
        get {
            return minX.doubleValue
        }
        set(minLongitude) {
            setMinXValue(minLongitude)
        }
    }
    
    /**
     * The min latitude
     */
    var minLatitude: Double {
        get {
            return minY.doubleValue
        }
        set(minLatitude) {
            setMinYValue(minLatitude)
        }
    }
    
    /**
     * The max longitude
     */
    var maxLongitude: Double {
        get {
            return maxX.doubleValue
        }
        set(maxLongitude) {
            setMaxXValue(maxLongitude)
        }
    }
    
    /**
     * The max latitude
     */
    var maxLatitude: Double {
        get {
            return maxY.doubleValue
        }
        set(maxLatitude) {
            setMaxYValue(maxLatitude)
        }
    }
    
    /**
     * The western longitude
     *
     * @return western longitude
     */
    var west: Double {
        get {
            return minLongitude
        }
        set(west) {
            minLongitude = west
        }
    }
    
    /**
     * The southern longitude
     *
     * @return southern longitude
     */
    var south: Double {
        get {
            return minLatitude
        }
        set(south) {
            minLatitude = south
        }
    }
    
    /**
     * The eastern longitude
     *
     * @return eastern longitude
     */
    var east: Double {
        get {
            return maxLongitude
        }
        set(east) {
            maxLongitude = east
        }
    }
    
    /**
     * The northern longitude
     *
     * @return northern longitude
     */
    var north: Double {
        get {
            return maxLatitude
        }
        set(north) {
            maxLatitude = north
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
     * Are bounds in degrees
     *
     * @return true if degrees
     */
    func isDegrees() -> Bool {
        return isUnit(unit: Unit.DEGREE)
    }
    
    /**
     * Are bounds in meters
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
     * @return bounds in units, same bounds if equal units
     */
    func toUnit(unit: Unit) -> Bounds {
        var bounds: Bounds
        if (isUnit(unit: unit)) {
            bounds = self
        } else {
            let sw: Point = southwest.toUnit(unit: unit)
            let ne: Point = northeast.toUnit(unit: unit)
            bounds = Bounds(southwest: sw, northeast: ne)
        }
        return bounds
    }
    
    /**
     * Convert to degrees
     *
     * @return bounds in degrees, same bounds if already in degrees
     */
    func toDegrees() -> Bounds {
        return toUnit(unit: Unit.DEGREE)
    }
    
    /**
     * Convert to meters
     *
     * @return bounds in meters, same bounds if already in meters
     */
    func toMeters() -> Bounds {
        return toUnit(unit: Unit.METER)
    }
    
    /**
     * Get the centroid longitude
     *
     * @return centroid longitude
     */
    func centroidLongitude() -> Double {
        return midX()
    }
    
    /**
     * Get the centroid latitude
     *
     * @return centroid latitude
     */
    func centroidLatitude() -> Double {
        var centerLatitude: Double
        if (unit == Unit.DEGREE) {
            centerLatitude = centroid().latitide
        } else {
            centerLatitude = midY()
        }
        return centerLatitude
    }
    
    override func centroid() -> Point {
        var point: Point
        if (unit == Unit.DEGREE) {
            point = toMeters().centroid().toDegrees()
        } else {
            point = Point(point: super.centroid(), unit: unit)
        }
        return point
    }
    
    /**
     * The width
     */
    var width: Double {
        get {
            return xRange()
        }
    }
    
    /**
     * The height
     */
    var height: Double {
        get {
            return yRange()
        }
    }
    
    /**
     * The southwest coordinate
     *
     * @return southwest coordinate
     */
    var southwest: Point {
        get {
            return Point(longitude: minLongitude, latitude: minLatitude, unit: unit)
        }
    }
    
    /**
     * The northwest coordinate
     *
     * @return northwest coordinate
     */
    var northwest: Point {
        get {
            return Point(longitude: minLongitude, latitude: maxLatitude, unit: unit)
        }
    }
    
    /**
     * The southeast coordinate
     *
     * @return southeast coordinate
     */
    var southeast: Point {
        get {
            return Point(longitude: maxLongitude, latitude: minLatitude, unit: unit)
        }
    }
    
    /**
     * The northeast coordinate
     *
     * @return northeast coordinate
     */
    var northeast: Point {
        get {
            return Point(longitude: maxLongitude, latitude: maxLatitude, unit: unit)
        }
    }
    
    /**
     * Create a new bounds as the overlapping between this bounds and the
     * provided
     *
     * @param bounds
     *            bounds
     * @return overlap bounds
     */
    func overlap(bounds: Bounds) -> Bounds? {
        
        var overlap: Bounds?

        let overlapEnvelope: SFGeometryEnvelope? = super.overlap(with: bounds.toUnit(unit: unit), withAllowEmpty: true)
        if (overlapEnvelope != nil) {
            overlap = Bounds(envelope: overlapEnvelope!, unit: unit)
        }

        return overlap
    }
    
    /**
     * Create a new bounds as the union between this bounds and the provided
     *
     * @param bounds
     *            bounds
     * @return union bounds
     */
    func union(bounds: Bounds) -> Bounds? {
        
        var union: Bounds?

        let unionEnvelope: SFGeometryEnvelope? = super.union(with: bounds.toUnit(unit: unit))
        if (unionEnvelope != nil) {
            union = Bounds(envelope: unionEnvelope!, unit: unit)
        }

        return union
    }
    
    /**
     * Get the western line
     *
     * @return west line
     */
    func westLine() -> Line {
        return grid_ios.Line(point1: northwest, point2: southwest)
    }

    /**
     * Get the southern line
     *
     * @return south line
     */
    func southLine() -> Line {
        return grid_ios.Line(point1: southwest, point2: southeast)
    }

    /**
     * Get the eastern line
     *
     * @return east line
     */
    func eastLine() -> Line {
        return grid_ios.Line(point1: southeast, point2: northeast)
    }

    /**
     * Get the northern line
     *
     * @return north line
     */
    func northLine() -> Line {
        return grid_ios.Line(point1: northeast, point2: northwest)
    }
    
    /**
     * Convert the bounds to be precision accurate minimally containing the
     * bounds. Each bound is equal to or larger by the precision degree amount.
     *
     * @param precision
     *            precision in degrees
     * @return precision bounds
     */
    func toPrecision(precision: Double) -> Bounds {
        
        let boundsDegrees = toDegrees()

        let minLon = GridUtils.precisionBefore(value: boundsDegrees.minLongitude, precision: precision)
        let minLat = GridUtils.precisionBefore(value: boundsDegrees.minLatitude, precision: precision)
        let maxLon = GridUtils.precisionAfter(value: boundsDegrees.maxLongitude, precision: precision)
        let maxLat = GridUtils.precisionAfter(value: boundsDegrees.maxLatitude, precision: precision)

        return Bounds.degrees(minLongitude: minLon, minLatitude: minLat, maxLongitude: maxLon, maxLatitude: maxLat)
    }
    
    /**
     * Get the pixel range where the bounds fit into the tile
     *
     * @param tile
     *            tile
     * @return pixel range
     */
    func pixelRange(tile: GridTile) -> PixelRange {
        return pixelRange(width: tile.width, height: tile.height, bounds: tile.bounds)
    }
    
    /**
     * Get the pixel range where the bounds fit into the provided bounds
     *
     * @param width
     *            width
     * @param height
     *            height
     * @param bounds
     *            bounds
     * @return pixel range
     */
    func pixelRange(width: Int, height: Int, bounds: Bounds) -> PixelRange {
        let boundsMeters = bounds.toMeters()
        let topLeft = GridUtils.pixel(width: width, height: height, bounds: boundsMeters, point: northwest)
        let bottomRight = GridUtils.pixel(width: width, height: height, bounds: boundsMeters, point: southeast)
        return PixelRange(topLeft: topLeft, bottomRight: bottomRight)
    }
    
    /**
     * Get the four line bounds in meters
     *
     * @return lines
     */
    func lines() -> [Line] {
        
        let southwest = southwest
        let northwest = northwest
        let northeast = northeast
        let southeast = southeast
        
        var lines: [Line] = []
        lines.append(Line(point1: southwest, point2: northwest))
        lines.append(Line(point1: northwest, point2: northeast))
        lines.append(Line(point1: northeast, point2: southeast))
        lines.append(Line(point1: southeast, point2: southwest))
        
        return lines
    }
    
    override func mutableCopy(with zone: NSZone? = nil) -> Any {
        return Bounds(bounds: self)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(unit.rawValue, forKey: "unit")
        super.encode(with: coder)
    }
    
    required init?(coder: NSCoder) {
        unit = Unit.init(rawValue: coder.decodeInteger(forKey: "unit"))!
        super.init(coder: coder)
    }
    
    func isEqual(bounds: Bounds?) -> Bool {
        if(self == bounds) {
            return true
        }
        if(bounds == nil) {
            return false
        }
        if(!super.isEqual(bounds)) {
            return false
        }
        if(unit != bounds?.unit){
            return false
        }
        return true
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if(!(object is Bounds)) {
            return false
        }
        
        return isEqual(bounds: object as? Bounds)
    }

    override var hash: Int {
        let prime = 31
        var result = super.hash
        result = prime * result + unit.rawValue
        return result
    }
    
}
