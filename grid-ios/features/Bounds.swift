//
//  Bounds.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/3/22.
//

import Foundation
import sf_ios

class Bounds: SFGeometryEnvelope {
    
    var unit: Unit
    
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
        super.init(minXValue: minLongitude, andMinYValue: minLatitude, andMaxXValue: maxLongitude, andMaxYValue: maxLatitude)
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
        
        // TODO unit check
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
        super.init(geometryEnvelope: envelope)
    }
    
    // TODO
    
    required init?(coder: NSCoder) {
        // TODO
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO
    
}
