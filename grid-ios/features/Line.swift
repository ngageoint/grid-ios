//
//  Line.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/4/22.
//

import Foundation
import sf_ios

/**
 * Line between two points
 */
class Line: SFLine {
    
    /**
     * Initialize
     *
     * @param point1
     *            first point
     * @param point2
     *            second point
     */
    init(point1: Point, point2: Point) {
        super.init()
        setPoints(point1: point1, point2: point2)
    }
    
    /**
     * Initialize
     *
     * @param line
     *            line to copy
     */
    init(line: Line) {
        super.init(line: line)
    }
    
    /**
     * The first point
     */
    var point1: Point {
        get {
            return startPoint() as! Point
        }
        set(point1) {
            setPoints(point1: point1, point2: point2)
        }
    }
    
    /**
     * The second point
     */
    var point2: Point {
        get {
            return endPoint() as! Point
        }
        set(point2) {
            setPoints(point1: point1, point2: point2)
        }
    }
    
    /**
     * Set the points
     *
     * @param point1
     *            first point
     * @param point2
     *            second point
     */
    func setPoints(point1: Point, point2: Point) {
        var linePoints: [Point] = []
        linePoints.append(point1)
        linePoints.append(point2)
        points = linePoints as? NSMutableArray
        validateUnits()
    }
    
    /**
     * The unit
     */
    var unit: Unit {
        get {
            return point1.unit
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
        return point1.isUnit(unit: unit)
    }
    
    /**
     * Is this line in degrees
     *
     * @return true if degrees
     */
    func isDegrees() -> Bool {
        return point1.isDegrees()
    }
    
    /**
     * Is this line in meters
     *
     * @return true if meters
     */
    func isMeters() -> Bool {
        return point1.isMeters()
    }
    
    /**
     * Convert to the unit
     *
     * @param unit
     *            unit
     * @return line in units, same line if equal units
     */
    func toUnit(unit: Unit) -> Line {
        var line: Line
        if (isUnit(unit: unit)) {
            line = self
        } else {
            line = mutableCopy() as! Line
            line.setPoints(point1: point1.toUnit(unit: unit), point2: point2.toUnit(unit: unit))
        }
        return line
    }
    
    /**
     * Convert to degrees
     *
     * @return line in degrees, same line if already in degrees
     */
    func toDegrees() -> Line {
        return toUnit(unit: Unit.DEGREE)
    }
    
    /**
     * Convert to meters
     *
     * @return line in meters, same line if already in meters
     */
    func toMeters() -> Line {
        return toUnit(unit: Unit.METER)
    }
    
    /**
     * Get the intersection between this line and the provided line
     *
     * @param line
     *            line
     * @return intersection
     */
    func intersection(line: Line) -> Point? {
        return GridUtils.intersection(line1: self, line2: line)
    }
    
    override func mutableCopy(with zone: NSZone? = nil) -> Any {
        return Line(line: self)
    }
    
    override func encode(with coder: NSCoder) {
        super.encode(with: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func isEqual(line: Line?) -> Bool {
        if(self == line) {
            return true
        }
        if(line == nil) {
            return false
        }
        if(!super.isEqual(line)) {
            return false
        }
        return true
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if(!(object is Line)) {
            return false
        }
        
        return isEqual(line: object as? Line)
    }

    override var hash: Int {
        return super.hash
    }
    
    /**
     * Validate units are the same
     */
    private func validateUnits() {
        if (!point1.isUnit(unit: point2.unit)) {
            preconditionFailure("Points are in different units. point1: " + String(describing: point1.unit) + ", point2: " + String(describing: point2.unit))
        }
    }
    
}
