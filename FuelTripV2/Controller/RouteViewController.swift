//
//  RouteViewController.swift
//  FuelTripV2
//
//  Created by Tim Riedesel on 2/6/20.
//  Copyright © 2020 Tim Riedesel. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController {

    let routeManager = RouteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        routeManager.fetchRoute()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
