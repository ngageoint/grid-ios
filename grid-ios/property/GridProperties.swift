//
//  GridProperties.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/5/22.
//

import Foundation

/**
 * Grid property loader
 */
class GridProperties {

    var properties: [String: Any]
    
    /**
     * Initialize
     */
    init(bundle: String, name: String) {
        let dict: [String: Any]?
        let propertiesPath = GridProperties.propertyListURL(bundle: bundle, name: name)
        do {
            let propertiesData = try Data(contentsOf: propertiesPath)
            dict = try PropertyListSerialization.propertyList(from: propertiesData, options: [], format: nil) as? [String: Any]
        } catch {
            fatalError("Failed to load properties in bundle '\(bundle)' with name '\(name)'")
        }
        properties = dict!
    }
    
    /**
     *  Combine the base property with the property to create a single combined property
     *
     *  @param base     base property
     *  @param property property
     *
     *  @return string value
     */
    func combine(base: String, property: String) -> String {
        return "\(base)\(PropertyConstants.PROPERTY_DIVIDER)\(property)"
    }
    
    /**
     *  Get the string value of the property
     *
     *  @param property property
     *
     *  @return string value
     */
    func value(property: String) -> String? {
        return value(property: property, required: true)
    }
    
    /**
     *  Get the string value of the property with required option
     *
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return string value
     */
    func value(property: String, required: Bool) -> String? {
        let value: String? = properties[property] as? String
        
        if (value == nil && required) {
            preconditionFailure("Required property not found: \(property)")
        }
        
        return value
    }

    /**
     *  Get the string value of the property combined with the base
     *
     *  @param base     base property
     *  @param property property
     *
     *  @return string value
     */
    func value(base: String, property: String) -> String? {
        return value(base: base, property: property, required: true)
    }
    
    /**
     *  Get the string value of the property combined with the base with required option
     *
     *  @param base     base property
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return string value
     */
    func value(base: String, property: String, required: Bool) -> String? {
        return value(property: combine(base: base, property: property), required: required)
    }
    
    /**
     *  Get the int value of the property
     *
     *  @param property property
     *
     *  @return int value
     */
    func intValue(property: String) -> Int? {
        return intValue(property: property, required: true)
    }
    
    /**
     *  Get the int value of the property with required option
     *
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return int value
     */
    func intValue(property: String, required: Bool) -> Int? {
        var val: Int?
        let stringValue: String? = value(property: property, required: required)
        if (stringValue != nil) {
            val = Int(stringValue!)
        }
        return val
    }
    
    /**
     *  Get the int value of the property
     *
     *  @param base     base property
     *  @param property property
     *
     *  @return int value
     */
    func intValue(base: String, property: String) -> Int? {
        return intValue(base: base, property: property, required: true)
    }
    
    /**
     *  Get the int value of the property with required option
     *
     *  @param base     base property
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return int value
     */
    func intValue(base: String, property: String, required: Bool) -> Int? {
        return intValue(property: combine(base: base, property: property), required: required)
    }
    
    /**
     *  Get the float value of the property
     *
     *  @param property property
     *
     *  @return float value
     */
    func floatValue(property: String) -> Float? {
        return floatValue(property: property, required: true)
    }
    
    /**
     *  Get the float value of the property with required option
     *
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return float value
     */
    func floatValue(property: String, required: Bool) -> Float? {
        var val: Float?
        let stringValue: String? = value(property: property, required: required)
        if (stringValue != nil) {
            val = Float(stringValue!)
        }
        return val
    }
    
    /**
     *  Get the float value of the property
     *
     *  @param base     base property
     *  @param property property
     *
     *  @return float value
     */
    func floatValue(base: String, property: String) -> Float? {
        return floatValue(base: base, property: property, required: true)
    }
    
    /**
     *  Get the float value of the property with required option
     *
     *  @param base     base property
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return float value
     */
    func floatValue(base: String, property: String, required: Bool) -> Float? {
        return floatValue(property: combine(base: base, property: property), required: required)
    }
    
    /**
     *  Get the double value of the property
     *
     *  @param property property
     *
     *  @return double value
     */
    func doubleValue(property: String) -> Double? {
        return doubleValue(property: property, required: true)
    }
    
    /**
     *  Get the double value of the property with required option
     *
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return double value
     */
    func doubleValue(property: String, required: Bool) -> Double? {
        var val: Double?
        let stringValue: String? = value(property: property, required: required)
        if (stringValue != nil) {
            val = Double(stringValue!)
        }
        return val
    }
    
    /**
     *  Get the double value of the property
     *
     *  @param base     base property
     *  @param property property
     *
     *  @return double value
     */
    func doubleValue(base: String, property: String) -> Double? {
        return doubleValue(base: base, property: property, required: true)
    }
    
    /**
     *  Get the double value of the property with required option
     *
     *  @param base     base property
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return double value
     */
    func doubleValue(base: String, property: String, required: Bool) -> Double? {
        return doubleValue(property: combine(base: base, property: property), required: required)
    }
    
    /**
     *  Get the bool value of the property
     *
     *  @param property property
     *
     *  @return bool value
     */
    func boolValue(property: String) -> Bool? {
        return boolValue(property: property, required: true)
    }
    
    /**
     *  Get the bool value of the property with required option
     *
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return bool value
     */
    func boolValue(property: String, required: Bool) -> Bool? {
        var val: Bool?
        let stringValue: String? = value(property: property, required: required)
        if (stringValue != nil) {
            val = Bool(stringValue!)
        }
        return val
    }
    
    /**
     *  Get the bool value of the property
     *
     *  @param base     base property
     *  @param property property
     *
     *  @return bool value
     */
    func boolValue(base: String, property: String) -> Bool? {
        return boolValue(base: base, property: property, required: true)
    }
    
    /**
     *  Get the bool value of the property with required option
     *
     *  @param base     base property
     *  @param property property
     *  @param required true if required to exist
     *
     *  @return bool value
     */
    func boolValue(base: String, property: String, required: Bool) -> Bool? {
        return boolValue(property: combine(base: base, property: property), required: required)
    }
    
    static func propertyListURL(bundle: String, name: String) -> URL {
        return resourceURL(bundle: bundle, name: name, ext: PropertyConstants.PROPERTY_LIST_TYPE)
    }

    static func resourceURL(bundle: String, name: String, ext: String) -> URL {
        
        let resource = "\(bundle)/\(name)"
        var resourceURL = Bundle.main.url(forResource: resource, withExtension: ext)
        if (resourceURL == nil) {
            resourceURL = Bundle(for: self).url(forResource: resource, withExtension: ext)
            if (resourceURL == nil) {
                resourceURL = Bundle(for: self).url(forResource: name, withExtension: ext)
                if (resourceURL == nil) {
                    resourceURL = Bundle.main.url(forResource: name, withExtension: ext)
                }
            }
        }
        if (resourceURL == nil) {
            fatalError("Failed to find resource '\(name)' with extension '\(ext)'")
        }
        
        return resourceURL!
    }
    
}
