//
//  BaseGrids.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/8/22.
//

import Foundation
import color_ios

/**
 * Grids
 */
class BaseGrids {
  
    /**
     * Grid properties
     */
    let properties: GridProperties
    
    /**
     * Map between zoom levels and grids
     */
    private var zoomGrids: [Int: BaseZoomGrids] = [:]
    
    /**
     * Initialize
     *
     * @param properties
     *            grid properties
     */
    init(properties: GridProperties) {
        self.properties = properties
    }
    
    /**
     * Get the default grid line width
     *
     * @return width
     */
    func defaultWidth() -> Double {
        preconditionFailure("This method must be overridden")
    }

    /**
     * Get the grids
     *
     * @return grids
     */
    func grids() -> [BaseGrid] {
        preconditionFailure("This method must be overridden")
    }

    /**
     * Create a new zoom grids
     *
     * @param zoom
     *            zoom level
     * @return zoom grids
     */
    func newZoomGrids(zoom: Int) -> BaseZoomGrids {
        preconditionFailure("This method must be overridden")
    }
    
    /**
     * Load the grid
     *
     * @param grid
     *            name
     * @param gridKey
     *            grid name key
     * @param enabled
     *            enable created grids
     * @param labeler
     *            grid labeler
     */
    func loadGrid(grid: BaseGrid, gridKey: String, enabled: Bool?, labeler: Labeler?) {
        
        let gridKeyProperty = properties.combine(base: PropertyConstants.GRIDS, property: gridKey)
        
        var enabledValue = enabled
        if (enabledValue == nil) {
            enabledValue = properties.boolValue(base: gridKeyProperty, property: PropertyConstants.ENABLED, required: false)
            if (enabledValue == nil) {
                enabledValue = true
            }
        }
        grid.enabled = enabledValue!
        
        var minZoom = properties.intValue(base: gridKeyProperty, property: PropertyConstants.MIN_ZOOM, required: false)
        if (minZoom == nil) {
            minZoom = 0
        }
        grid.minZoom = minZoom!
        
        let maxZoom = properties.intValue(base: gridKeyProperty, property: PropertyConstants.MAX_ZOOM, required: false)
        grid.maxZoom = maxZoom
        
        let linesProperty = properties.combine(base: gridKeyProperty, property: PropertyConstants.LINES)
        
        let linesMinZoom = properties.intValue(base: linesProperty, property: PropertyConstants.MIN_ZOOM, required: false)
        grid.linesMinZoom = linesMinZoom
        
        let linesMaxZoom = properties.intValue(base: linesProperty, property: PropertyConstants.MAX_ZOOM, required: false)
        grid.linesMaxZoom = linesMaxZoom
        
        let colorProperty = properties.value(base: gridKeyProperty, property: PropertyConstants.COLOR, required: false)
        let color = colorProperty != nil ? CLRColor(hex: colorProperty) : CLRColor.black()
        grid.color = color
        
        var width = properties.doubleValue(base: gridKeyProperty, property: PropertyConstants.WIDTH, required: false)
        if (width == nil) {
            width = defaultWidth()
        }
        grid.width = width!
        
        if (labeler != nil) {
            loadLabeler(labeler: labeler!, gridKey: gridKey)
        }
        grid.labeler = labeler
        
    }
    
    /**
     * Load the labeler
     *
     * @param labeler
     *            labeler
     * @param gridKey
     *            grid name key
     */
    func loadLabeler(labeler: Labeler, gridKey: String) {
        
        let gridKeyProperty = properties.combine(base: PropertyConstants.GRIDS, property: gridKey)
        let labelerProperty = properties.combine(base: gridKeyProperty, property: PropertyConstants.LABELER)
        
        let enabled = properties.boolValue(base: labelerProperty, property: PropertyConstants.ENABLED, required: false)
        labeler.enabled = (enabled != nil) && enabled!
        
        let minZoom = properties.intValue(base: labelerProperty, property: PropertyConstants.MIN_ZOOM, required: false)
        if (minZoom != nil) {
            labeler.minZoom = minZoom!
        }
        
        let maxZoom = properties.intValue(base: labelerProperty, property: PropertyConstants.MAX_ZOOM, required: false)
        if (maxZoom != nil) {
            labeler.maxZoom = maxZoom!
        }
        
        let color = properties.value(base: labelerProperty, property: PropertyConstants.COLOR, required: false)
        if (color != nil) {
            labeler.color = CLRColor(hex: color)
        }
        
        let textSize = properties.doubleValue(base: labelerProperty, property: PropertyConstants.TEXT_SIZE, required: false)
        if (textSize != nil) {
            labeler.textSize = textSize!
        }
        
        let buffer = properties.doubleValue(base: labelerProperty, property: PropertyConstants.BUFFER, required: false)
        if (buffer != nil) {
            labeler.buffer = buffer!
        }
        
    }
    
    /**
     * Load the grid style color
     *
     * @param gridKey
     *            grid name key
     * @param gridKey2
     *            second grid name key
     * @return color
     */
    func loadGridStyleColor(gridKey: String, gridKey2: String) -> CLRColor? {
        
        let gridKeyProperty = properties.combine(base: PropertyConstants.GRIDS, property: gridKey)
        let gridKey2Property = properties.combine(base: gridKeyProperty, property: gridKey2)
        
        let colorProperty = properties.value(base: gridKey2Property, property: PropertyConstants.COLOR, required: false)
        var color: CLRColor?
        if (colorProperty != nil) {
            color = CLRColor(hex: colorProperty)
        }
        return color
    }
    
    /**
     * Load the grid style width
     *
     * @param gridKey
     *            grid name key
     * @param gridKey2
     *            second grid name key
     * @return width
     */
    func loadGridStyleWidth(gridKey: String, gridKey2: String) -> Double? {
        
        let gridKeyProperty = properties.combine(base: PropertyConstants.GRIDS, property: gridKey)
        let gridKey2Property = properties.combine(base: gridKeyProperty, property: gridKey2)
        
        return properties.doubleValue(base: gridKey2Property, property: PropertyConstants.WIDTH, required: false)
    }
    
    /**
     * Get a combined grid style from the provided color, width, and grid
     *
     * @param color
     *            color
     * @param width
     *            width
     * @param grid
     *            grid
     * @return grid style
     */
    func gridStyle(color: CLRColor?, width: Double?, grid: BaseGrid) -> GridStyle {
        
        var colorValue = color
        if (colorValue == nil) {
            colorValue = grid.color
        }
        
        var widthValue  = width
        if (widthValue == nil || width == 0) {
            widthValue = grid.width
        }
        
        return GridStyle(color: colorValue, width: widthValue!)
    }
    
    /**
     * Create the zoom level grids
     */
    func createZoomGrids() {
        for zoom in 0 ... GridConstants.MAX_MAP_ZOOM_LEVEL {
            _ = createZoomGrids(zoom: zoom)
        }
    }
    
    /**
     * Get the grids for the zoom level
     *
     * @param zoom
     *            zoom level
     * @return grids
     */
    func grids(zoom: Int) -> BaseZoomGrids {
        var grids = zoomGrids[zoom]
        if (grids == nil) {
            grids = createZoomGrids(zoom: zoom)
        }
        return grids!
    }
    
    /**
     * Create grids for the zoom level
     *
     * @param zoom
     *            zoom level
     * @return grids
     */
    private func createZoomGrids(zoom: Int) -> BaseZoomGrids {
        let zoomLevelGrids = newZoomGrids(zoom: zoom)
        for grid in grids() {
            if (grid.enabled && grid.isWithin(zoom: zoom)) {
                _ = zoomLevelGrids.addGrid(grid: grid)
            }
        }
        zoomGrids[zoom] = zoomLevelGrids
        return zoomLevelGrids
    }
    
    /**
     * Enable grids
     *
     * @param grids
     *            grids
     */
    func enableGrids(grids: [BaseGrid]) {
        for grid in grids {
            enable(grid: grid)
        }
    }
    
    /**
     * Disable grids
     *
     * @param grids
     *            grids
     */
    func disableGrids(grids: [BaseGrid]) {
        for grid in grids {
            disable(grid: grid)
        }
    }
    
    /**
     * Enable the grid
     *
     * @param grid
     *            grid
     */
    func enable(grid: BaseGrid) {
        
        if (!grid.enabled) {
            
            grid.enabled = true
            
            let minZoom = grid.minZoom
            var maxZoom = grid.maxZoom
            if (maxZoom == nil) {
                //maxZoom = zoomGrids[] TODO
            }
            
            for zoom in minZoom ... maxZoom! {
                addGrid(grid: grid, zoom: zoom)
            }
            
        }
        
    }
    
    /**
     * Disable the grid
     *
     * @param grid
     *            grid
     */
    func disable(grid: BaseGrid) {
        
        if (grid.enabled) {
            
            grid.enabled = false
            
            let minZoom = grid.minZoom
            var maxZoom = grid.maxZoom
            if (maxZoom == nil) {
                //maxZoom = zoomGrids[] TODO
            }
            
            for zoom in minZoom ... maxZoom! {
                removeGrid(grid: grid, zoom: zoom)
            }
            
        }
        
    }
    
    /**
     * Set the grid minimum zoom
     *
     * @param grid
     *            grid
     * @param minZoom
     *            minimum zoom
     */
    func setMinZoom(grid: BaseGrid, minZoom: Int) {
        var maxZoom = grid.maxZoom
        if (maxZoom != nil && maxZoom! < minZoom) {
            maxZoom = minZoom
        }
        setZoomRange(grid: grid, minZoom: minZoom, maxZoom: maxZoom)
    }
    
    /**
     * Set the grid maximum zoom
     *
     * @param grid
     *            grid
     * @param maxZoom
     *            maximum zoom
     */
    func setMaxZoom(grid: BaseGrid, maxZoom: Int?) {
        var minZoom = grid.minZoom
        if (maxZoom != nil && minZoom > maxZoom!) {
            minZoom = maxZoom!
        }
        setZoomRange(grid: grid, minZoom: minZoom, maxZoom: maxZoom)
    }
    
    /**
     * Set the grid zoom range
     *
     * @param grid
     *            grid
     * @param minZoom
     *            minimum zoom
     * @param maxZoom
     *            maximum zoom
     */
    func setZoomRange(grid: BaseGrid, minZoom: Int, maxZoom: Int?) {
        
        if (maxZoom != nil && maxZoom! < minZoom) {
            preconditionFailure("Min zoom '\(minZoom)' can not be larger than max zoom '\(String(describing: maxZoom))\'")
        }
        
        // All grids zoom range
        let allGridsMin: Int = 1 // TODO
        let allGridsMax: Int = 2 // TODO
        
        // Existing grid zoom range
        let gridMinZoom = grid.minZoom
        let gridMaxZoom = grid.maxZoom == nil ? allGridsMax : min(grid.maxZoom!, allGridsMax)
        
        grid.minZoom = minZoom
        grid.maxZoom = maxZoom
        
        let minZoomValue = max(minZoom, allGridsMin)
        let maxZoomValue = maxZoom == nil ? allGridsMax : min(maxZoom!, allGridsMax)
        
        let minOverlap = max(minZoomValue, gridMinZoom)
        let maxOverlap = min(maxZoomValue, gridMaxZoom)
        
        let overlaps = minOverlap <= maxOverlap
        
        if (overlaps) {
            
            let min = min(minZoomValue, gridMinZoom)
            let max = max(maxZoomValue, gridMaxZoom)
            
            for zoom in min ... max {
                
                if (zoom < minOverlap || zoom > maxOverlap) {
                    
                    if (zoom >= minZoomValue && zoom <= maxZoomValue) {
                        addGrid(grid: grid, zoom: zoom)
                    } else {
                        removeGrid(grid: grid, zoom: zoom)
                    }
                    
                }
                
            }
        } else {
            
            for zoom in gridMinZoom ... gridMaxZoom {
                removeGrid(grid: grid, zoom: zoom)
            }
            
            for zoom in minZoomValue ... maxZoomValue {
                addGrid(grid: grid, zoom: zoom)
            }
            
        }
        
    }
    
    /**
     * Add a grid to the zoom level
     *
     * @param grid
     *            grid
     * @param zoom
     *            zoom level
     */
    private func addGrid(grid: BaseGrid, zoom: Int) {
        _ = zoomGrids[zoom]?.addGrid(grid: grid)
    }
    
    /**
     * Remove a grid from the zoom level
     *
     * @param grid
     *            grid
     * @param zoom
     *            zoom level
     */
    private func removeGrid(grid: BaseGrid, zoom: Int) {
        _ = zoomGrids[zoom]?.removeGrid(grid: grid)
    }
    
    /**
     * Enable all grid labelers
     */
    func enableAllLabelers() {
        for grid in grids() {
            grid.labeler?.enabled = true
        }
    }
    
    /**
     * Set all label grid edge buffers
     *
     * @param buffer
     *            label buffer (greater than or equal to 0.0 and less than 0.5)
     */
    func setAllLabelBuffers(buffer: Double) {
        for grid in grids() {
            grid.labeler?.buffer = buffer
        }
    }
    
}
