//
//  Point.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/3/22.
//

import Foundation
import sf_ios

class Point: SFPoint {
    
    /**
     * Unit
     */
    var unit: Unit
    
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
        super.init(xValue: longitude, andYValue: latitude)
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
        super.init(point: point)
    }
    
    var longitude: Double {
        get {
            return x.doubleValue
        }
        set(longitude) {
            setXValue(longitude)
        }
    }
    
    var latitide: Double {
        get {
            return y.doubleValue
        }
        set(latitide) {
            setYValue(latitide)
        }
    }
    
    func isUnit(unit: Unit) -> Bool{
        return self.unit == unit
    }
    
    func isDegrees() -> Bool{
        return isUnit(unit: Unit.DEGREE)
    }
    
    func isMeters() -> Bool{
        return isUnit(unit: Unit.METER)
    }
    
    func toUnit(unit: Unit) -> Point{
        var point: Point
        if (isUnit(unit: unit)) {
            point = self
        } else {
            // TODO
            point = self
        }
        return point
    }
    
    func toDegrees() -> Point{
        return toUnit(unit: Unit.DEGREE)
    }
    
    func toMeters() -> Point{
        return toUnit(unit: Unit.METER)
    }
    
    // TODO
    
    override func mutableCopy(with zone: NSZone? = nil) -> Any {
        return Point(point: self)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(unit.descriptor, forKey: "unit")
        super.encode(with: coder)
    }
    
    required init?(coder: NSCoder) {
        unit = Unit.init(descriptor: coder.decodeObject(forKey: "unit") as! String)
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
        let prime = 31;
        var result = super.hash
        result = prime * result + unit.rawValue;
        return result;
    }
    
}
