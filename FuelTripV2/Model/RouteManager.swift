//
//  RouteManager.swift
//  FuelTripV2
//
//  Created by Tim Riedesel on 2/6/20.
//  Copyright © 2020 Tim Riedesel. All rights reserved.
//

import Foundation

struct RouteManager {
    
    let k = K()
    
    let routeURL = "https://maps.googleapis.com/maps/api/directions/json?parameters"
     
    var origin : String = "New York"
    var destination : String = "Detroit"
    
    func fetchRoute() {
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=\(k.apiKey)"
        print(urlString)
    }

}
