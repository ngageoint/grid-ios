//
//  TileUtils.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/17/22.
//

import MapKit

/**
 * Tile Utils
 */
public class TileUtils {
    
    /**
     * Displayed device-independent pixels
     */
    public static let TILE_DP = 256
    
    /**
     * Tile pixels for default dpi tiles
     */
    public static let TILE_PIXELS_DEFAULT = TILE_DP
    
    /**
     * Tile pixels for high dpi tiles
     */
    public static let TILE_PIXELS_HIGH = TILE_PIXELS_DEFAULT * 2
    
    /**
     * High density scale
     */
    public static let SCALE_FACTOR_DEFAULT: Float = 2.0
    
    /**
     *  Get the tile side (width and height) dimension based upon the screen resolution
     *
     *  @return default tile length
     */
    public static func tileLength() -> Int {
        return tileLength(Float(UIScreen.main.nativeScale))
    }

    /**
     *  Get the tile side (width and height) dimension based upon the scale
     *
     *  @param scale resolution scale
     *  @return default tile length
     */
    public static func tileLength(_ scale: Float) -> Int {
        let length: Int
        if(scale <= SCALE_FACTOR_DEFAULT){
            length = TILE_PIXELS_DEFAULT
        }else{
            length = TILE_PIXELS_HIGH
        }
        return length
    }
    
    /**
     *  Compress the image to byte data
     *
     *  @param image  image
     *
     *  @return byte data
     */
    public static func toData(_ image: UIImage?) -> Data? {
        return image?.pngData()
    }
    
    /**
     *  Convert a MapKit map point to a location coordinate
     *
     *  @param point MK map point
     *
     *  @return location coordinate
     */
    public static func toCoordinate(_ point: MKMapPoint) -> CLLocationCoordinate2D {
        return point.coordinate
    }
    
    /**
     *  Convert a grid point to a location coordinate
     *
     *  @param point grid point
     *
     *  @return location coordinate
     */
    public static func toCoordinate(_ point: GridPoint) -> CLLocationCoordinate2D {
        let pointDegrees = point.toDegrees()
        return CLLocationCoordinate2DMake(pointDegrees.latitude, pointDegrees.longitude)
    }
    
    /**
     *  Convert a location coordinate to a MapKit map point
     *
     *  @param coordinate location coordinate
     *
     *  @return map point
     */
    public static func toMapPoint(_ coordinate: CLLocationCoordinate2D) -> MKMapPoint {
        return MKMapPoint(coordinate)
    }
    
    /**
     *  Convert a grid point to a MapKit map point
     *
     *  @param point grid point
     *
     *  @return map point
     */
    public static func toMapPoint(_ point: GridPoint) -> MKMapPoint {
        return toMapPoint(toCoordinate(point))
    }
    
    /**
     *  Convert a location coordinate to a grid point
     *
     *  @param coordinate location coordinate
     *
     *  @return grid point
     */
    public static func toGridPoint(_ coordinate: CLLocationCoordinate2D) -> GridPoint {
        return GridPoint.degrees(coordinate.longitude, coordinate.latitude)
    }
    
    /**
     *  Convert a MapKit map point to a grid point
     *
     *  @param point MK map point
     *
     *  @return grid point
     */
    public static func toGridPoint(_ point: MKMapPoint) -> GridPoint {
        return toGridPoint(toCoordinate(point))
    }
    
}
