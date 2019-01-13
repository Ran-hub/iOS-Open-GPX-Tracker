//
//  GPXElement.swift
//  GPXKit
//
//  Created by Vincent on 5/11/18.
//

import UIKit

open class GPXElement: NSObject {
    
    public var parent: GPXElement?
    
    //from GPXConst
    let kGPXInvalidGPXFormatNotification = "kGPXInvalidGPXFormatNotification"

    let kGPXDescriptionKey = "kGPXDescriptionKey"

    
    // MARK:- Tag
    
    func tagName() -> String! {
        return nil
    }
    func implementClasses() -> Array<Any>! {
        return nil
    }
    
    // MARK:- Instance
  
    public required override init() {
        super.init()
    }

    // MARK:- GPX
   
    open func gpx() -> String {
        let gpx: NSMutableString = ""
        self.gpx(gpx, indentationLevel: 0)
        return gpx as String
    }
    
    func gpx(_ gpx: NSMutableString, indentationLevel: Int) {
        self.addOpenTag(toGPX: gpx, indentationLevel: indentationLevel)
        self.addChildTag(toGPX: gpx, indentationLevel: indentationLevel + 1)
        self.addCloseTag(toGPX: gpx, indentationLevel: indentationLevel)
    }
    
    func addOpenTag(toGPX gpx: NSMutableString, indentationLevel: Int) {
        gpx.append(String(format: "%@<%@>\r\n", indent(forIndentationLevel: indentationLevel), self.tagName()))
    }
    
    func addChildTag(toGPX gpx: NSMutableString, indentationLevel: Int) {
        // Override to subclasses
    }
    
    func addCloseTag(toGPX gpx: NSMutableString, indentationLevel: Int) {
        gpx.append(String(format: "%@</%@>\r\n", indent(forIndentationLevel: indentationLevel), self.tagName()))
    }
    
    func addProperty(forValue value: NSString?, gpx: NSMutableString, tagName: NSString, indentationLevel: Int) {
        addProperty(forValue: value, gpx: gpx, tagName: tagName, indentationLevel: indentationLevel, defaultValue: nil, attribute: nil)
    }
    
    func addProperty(forNumberValue value: CGFloat?, gpx: NSMutableString, tagName: NSString, indentationLevel: Int) {
        if value != nil && value != 0 {
        addProperty(forValue: NSString(format: "%f", value!), gpx: gpx, tagName: tagName, indentationLevel: indentationLevel, defaultValue: nil, attribute: nil)
        }
    }
    
    func addProperty(forValue value: NSString?, gpx: NSMutableString, tagName: NSString, indentationLevel: Int, attribute: String?) {
        addProperty(forValue: value, gpx: gpx, tagName: tagName, indentationLevel: indentationLevel, defaultValue: nil, attribute: attribute)
    }
    
    func addProperty(forValue value: NSString?, gpx: NSMutableString, tagName: NSString, indentationLevel: Int, defaultValue: NSString?) {
        addProperty(forValue: value, gpx: gpx, tagName: tagName, indentationLevel: indentationLevel, defaultValue: defaultValue, attribute: nil)
    }
    
    func addProperty(forValue value: NSString?, gpx: NSMutableString, tagName: NSString, indentationLevel: Int, defaultValue: NSString?, attribute: String?) {
        if value == nil || value == "" {
            return
        }
        
        if defaultValue != nil && value == defaultValue {
            return
        }
        
        var outputCDMA: Bool = false
        
        let match: NSRange = (value?.range(of: "[^a-zA-Z0-9.,+-/*!='\"()\\[\\]{}!$%@?_;: #\t\r\n]", options: .regularExpression))!
        
        if match.location != NSNotFound {
            outputCDMA = true
        }
        
        if outputCDMA {
            gpx.appendFormat("%@<%@%@><![CDATA[%@]]></%@>\r\n", indent(forIndentationLevel: indentationLevel), tagName, (attribute != nil) ? " ".appending(attribute!): "", value?.replacingOccurrences(of: "]]>", with: "]]&gt;") ?? "", tagName)
        }
        else {
            gpx.appendFormat("%@<%@%@>%@</%@>\r\n", indent(forIndentationLevel: indentationLevel), tagName, (attribute != nil) ? " ".appending(attribute!): "", value ?? "", tagName)
        }
    }
    
    func indent(forIndentationLevel indentationLevel: Int) -> NSMutableString {
        let result: NSMutableString = ""
        
        for _ in 0..<indentationLevel {
            result.append("\t")
        }
        
        return result
    }
}
