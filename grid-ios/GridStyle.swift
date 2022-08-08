//
//  GridStyle.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/5/22.
//

import Foundation
import color_ios

/**
 * Grid Line Style
 */
class GridStyle {
    
    /**
     * Grid line color
     */
    var color: CLRColor?
    
    /**
     * Grid line width
     */
    var width: Double = 0
    
    /**
     * Initialize
     */
    init() {
        
    }
    
    /**
     * Initialize
     *
     * @param color
     *            color
     * @param width
     *            width
     */
    init(color: CLRColor?, width: Double) {
        self.color = color
        self.width = width
    }

}
