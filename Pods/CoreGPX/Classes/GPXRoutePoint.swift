//
//  GPXRoutePoint.swift
//  GPXKit
//
//  Created by Vincent on 19/11/18.
//

import UIKit

open class GPXRoutePoint: GPXWaypoint {
    
    public required init() {
        super.init()
    }
    
    // MARK:- Instance
    
    func routePoint(with latitude: CGFloat, longitude: CGFloat) -> GPXRoutePoint {
        let routePoint = GPXRoutePoint()
        routePoint.latitude = latitude
        routePoint.longitude = longitude
        
        return routePoint
    }
    
    // MARK:- Tag
    
    override func tagName() -> String! {
        return "rtept"
    }
}
