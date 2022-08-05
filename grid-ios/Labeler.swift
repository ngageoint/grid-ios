//
//  Labeler.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/5/22.
//

import Foundation
import color_ios

/**
 * Grid Labeler
 */
class Labeler {
    
    /**
     * Enabled labeler
     */
    var enabled: Bool
    
    /**
     * Minimum zoom level
     */
    var minZoom: Int
    
    /**
     * Maximum zoom level
     */
    var maxZoom: Int?
    
    /**
     * Label color
     */
    var color: CLRColor?
    
    /**
     * Label text size
     */
    var textSize: Double
    
    /**
     * Grid edge buffer (greater than or equal to 0.0 and less than 0.5)
     */
    var buffer: Double {
        willSet {
            if (newValue < 0.0 || newValue >= 0.5) {
                preconditionFailure("Grid edge buffer must be >= 0 and < 0.5. buffer: \(newValue)")
            }
        }
    }
    
    /**
     * Initialize
     *
     * @param minZoom
     *            minimum zoom
     * @param color
     *            label color
     * @param textSize
     *            label text size
     * @param buffer
     *            grid edge buffer (greater than or equal to 0.0 and less than
     *            0.5)
     */
    convenience init(minZoom: Int, color: CLRColor?, textSize: Double, buffer: Double) {
        self.init(minZoom: minZoom, maxZoom: nil, color: color, textSize: textSize, buffer: buffer)
    }
    
    /**
     * Initialize
     *
     * @param minZoom
     *            minimum zoom
     * @param maxZoom
     *            maximum zoom
     * @param color
     *            label color
     * @param textSize
     *            label text size
     * @param buffer
     *            grid edge buffer (greater than or equal to 0.0 and less than
     *            0.5)
     */
    convenience init(minZoom: Int, maxZoom: Int?, color: CLRColor?, textSize: Double, buffer: Double) {
        self.init(enabled: true, minZoom: minZoom, maxZoom: maxZoom, color: color, textSize: textSize, buffer: buffer)
    }
    
    /**
     * Initialize
     *
     * @param enabled
     *            enabled labeler
     * @param minZoom
     *            minimum zoom
     * @param maxZoom
     *            maximum zoom
     * @param color
     *            label color
     * @param textSize
     *            label text size
     * @param buffer
     *            grid edge buffer (greater than or equal to 0.0 and less than
     *            0.5)
     */
    init(enabled: Bool, minZoom: Int, maxZoom: Int?, color: CLRColor?, textSize: Double, buffer: Double) {
        self.enabled = enabled
        self.minZoom = minZoom
        self.maxZoom = maxZoom
        self.color = color
        self.textSize = textSize
        self.buffer = buffer
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
    
}
