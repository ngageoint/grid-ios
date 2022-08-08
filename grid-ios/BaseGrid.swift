//
//  BaseGrid.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/8/22.
//

import Foundation
import color_ios

/**
 * Base Grid
 */
class BaseGrid: Hashable, Comparable {
    
    /**
     * Enabled grid
     */
    var enabled: Bool = true
    
    /**
     * Minimum zoom level
     */
    var minZoom: Int = 0
    
    /**
     * Maximum zoom level
     */
    var maxZoom: Int?
    
    /**
     * Minimum zoom level override for drawing grid lines
     */
    private var _linesMinZoom: Int?
    
    /**
     * Minimum zoom level override for drawing grid lines
     */
    var linesMinZoom: Int? {
        get {
            return _linesMinZoom != nil ? _linesMinZoom : minZoom
        }
        set {
            _linesMinZoom = newValue
        }
    }
    
    /**
     * Maximum zoom level override for drawing grid lines
     */
    private var _linesMaxZoom: Int?
    
    /**
     * Maximum zoom level override for drawing grid lines
     */
    var linesMaxZoom: Int? {
        get {
            return _linesMaxZoom != nil ? _linesMaxZoom : maxZoom
        }
        set {
            _linesMaxZoom = newValue
        }
    }
    
    /**
     * Grid line style
     */
    var style: GridStyle = GridStyle()
    
    /**
     * Grid labeler
     */
    var labeler: Labeler?
    
    /**
     * Initialize
     */
    init() {
        
    }
    
    /**
     * Has a maximum zoom level
     *
     * @return true if has a maximum, false if unbounded
     */
    func hasMaxZoom() -> Bool {
        return maxZoom != nil
    }
    
    /**
     * Is the zoom level within the grid zoom range
     *
     * @param zoom
     *            zoom level
     * @return true if within range
     */
    func isWithin(zoom: Int) -> Bool {
        return zoom >= minZoom && (maxZoom == nil || zoom <= maxZoom!)
    }
    
    /**
     * Has a minimum zoom level override for drawing grid lines
     *
     * @return true if has a minimum, false if not overridden
     */
    func hasLinesMinZoom() -> Bool {
        return _linesMinZoom != nil
    }
    
    /**
     * Has a maximum zoom level override for drawing grid lines
     *
     * @return true if has a maximum, false if not overridden
     */
    func hasLinesMaxZoom() -> Bool {
        return _linesMaxZoom != nil
    }
    
    /**
     * Is the zoom level within the grid lines zoom range
     *
     * @param zoom
     *            zoom level
     * @return true if within range
     */
    func isLinesWithin(zoom: Int) -> Bool {
        return (_linesMinZoom == nil || zoom >= _linesMinZoom!)
                        && (_linesMaxZoom == nil || zoom <= _linesMaxZoom!)
    }
    
    /**
     * The grid line color
     */
    var color: CLRColor? {
        get {
            return style.color
        }
        set {
            style.color = newValue
        }
    }

    /**
     * The grid line width
     */
    var width: Double {
        get {
            return style.width
        }
        set {
            style.width = newValue
        }
    }
    
    /**
     * Has a grid labeler
     *
     * @return true if has a grid labeler
     */
    func hasLabeler() -> Bool {
        return labeler != nil
    }
    
    /**
     * Is labeler zoom level within the grid zoom range
     *
     * @param zoom
     *            zoom level
     * @return true if within range
     */
    func isLabelerWithin(zoom: Int) -> Bool {
        return hasLabeler() && labeler!.enabled && labeler!.isWithin(zoom: zoom)
    }
    
    /**
     * Get the label grid edge buffer
     *
     * @return label buffer (greater than or equal to 0.0 and less than 0.5)
     */
    func labelBuffer() -> Double {
        return hasLabeler() ? labeler!.buffer : 0.0
    }
    
    static func == (lhs: BaseGrid, rhs: BaseGrid) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {

    }
    
    static func < (lhs: BaseGrid, rhs: BaseGrid) -> Bool {
        return true
    }
    
}
