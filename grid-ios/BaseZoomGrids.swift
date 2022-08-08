//
//  BaseZoomGrids.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/8/22.
//

import Foundation

/**
 * Zoom Level Matching Grids
 */
class BaseZoomGrids {
    
    /**
     * Zoom level
     */
    let zoom: Int
    
    /**
     * Grids
     */
    private var _grids: Set<BaseGrid> = Set()
    
    /**
     * Initialize
     *
     * @param zoom
     *            zoom level
     */
    init(zoom: Int) {
        self.zoom = zoom
    }
    
    /**
     * Get the grids within the zoom level
     *
     * @return grids
     */
    var grids: [BaseGrid] {
        get {
            return _grids.sorted()
        }
    }
    
    /**
     * Get the number of grids
     *
     * @return number of grids
     */
    func numGrids() -> Int {
        return _grids.count
    }

    /**
     * Determine if the zoom level has grids
     *
     * @return true if has grids
     */
    func hasGrids() -> Bool {
        return !_grids.isEmpty
    }

    /**
     * Add a grid
     *
     * @param grid
     *            grid
     * @return true if added
     */
    func addGrid(grid: BaseGrid) -> Bool {
        return _grids.insert(grid).inserted
    }

    /**
     * Remove the grid
     *
     * @param grid
     *            grid
     * @return true if removed
     */
    func removeGrid(grid: BaseGrid) -> Bool {
        return _grids.remove(grid) != nil
    }
    
}
