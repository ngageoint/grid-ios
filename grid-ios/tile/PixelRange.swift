//
//  PixelRange.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/3/22.
//

import Foundation

/**
 * Pixel Range
 */
class PixelRange {
    
    /**
     * Top left pixel
     */
    var topLeft: Pixel

    /**
     * Bottom right pixel
     */
    var bottomRight: Pixel
    
    /**
     * Initialize
     *
     * @param topLeft
     *            top left pixel
     * @param bottomRight
     *            bottom right pixel
     */
    init(topLeft: Pixel, bottomRight: Pixel) {
        self.topLeft = topLeft
        self.bottomRight = bottomRight
    }
    
    /**
     * Get the minimum x pixel
     *
     * @return minimum x pixel
     */
    var minX: Float {
        get {
            return topLeft.x
        }
    }

    /**
     * Get the minimum y pixel
     *
     * @return minimum y pixel
     */
    var minY: Float {
        get {
            return topLeft.y
        }
    }

    /**
     * Get the maximum x pixel
     *
     * @return maximum x pixel
     */
    var maxX: Float {
        get {
            return bottomRight.x
        }
    }

    /**
     * Get the maximum y pixel
     *
     * @return maximum y pixel
     */
    var maxY: Float {
        get {
            return bottomRight.y
        }
    }

    /**
     * Get the left pixel
     *
     * @return left pixel
     */
    var left: Float {
        get {
            return minX
        }
    }

    /**
     * Get the top pixel
     *
     * @return top pixel
     */
    var top: Float {
        get {
            return minY
        }
    }

    /**
     * Get the right pixel
     *
     * @return right pixel
     */
    var right: Float {
        get {
            return maxX
        }
    }

    /**
     * Get the bottom pixel
     *
     * @return bottom pixel
     */
    var bottom: Float {
        get {
            return maxY
        }
    }

    /**
     * Get the pixel width
     *
     * @return pixel width
     */
    var width: Float {
        get {
            return maxX - minX
        }
    }

    /**
     * Get the pixel height
     *
     * @return pixel height
     */
    var height: Float {
        get {
            return maxY - minY
        }
    }
    
}
