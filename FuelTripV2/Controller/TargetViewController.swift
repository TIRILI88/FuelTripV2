//
//  TargetViewController.swift
//  FuelTripV2
//
//  Created by Tim Riedesel on 2/6/20.
//  Copyright © 2020 Tim Riedesel. All rights reserved.
//

import UIKit
import CoreLocation

class TargetViewController: UIViewController, MapsManagerDelegate {
    
    
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var numberOfStopsLabel: UILabel!
    @IBOutlet weak var distanceInMilesLabel: UILabel!
    @IBOutlet weak var moneyForGasLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var isCalculationLabel: UILabel!
    @IBOutlet weak var showRouteButton: UIButton!
    
    
    let locationManager = CLLocationManager()
    var mapsManager = MapsManager()
    var finalName = MapsManager.destinationName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapsManager.delegate = self
        destinationLabel.isHidden = true
        originLabel.isHidden = true
        locationManager.requestLocation()
        numberOfStopsLabel.isHidden = true
        distanceInMilesLabel.isHidden = true
        moneyForGasLabel.isHidden = true
        fromLabel.isHidden = true
        toLabel.isHidden = true
        showRouteButton.isHidden = true
    }
    
    func fetchData(_ mapsManager: MapsManager, model: MapsModel) {
        DispatchQueue.main.async {
            var gasStopLabelText: String = ""
            
            if model.numberOfGasStops > 1 {
                gasStopLabelText = ("you will need \(String(model.numberOfGasStops)) gasstops.")
            } else if model.numberOfGasStops == 1 {
                gasStopLabelText = ("you only have to stop once.")
            } else if model.numberOfGasStops < 1 {
                gasStopLabelText = "You don't need to fill up."
            }
            
            if self.numberOfStopsLabel.text != "" {
                self.isCalculationLabel.isHidden = true
                self.destinationLabel.isHidden = false
                self.destinationLabel.text = self.finalName
                self.numberOfStopsLabel.isHidden = false
                self.originLabel.isHidden = false
                self.distanceInMilesLabel.isHidden = false
                self.moneyForGasLabel.isHidden = false
                self.fromLabel.isHidden = false
                self.toLabel.isHidden = false
                self.showRouteButton.isHidden = false
                self.numberOfStopsLabel.text = gasStopLabelText
                self.distanceInMilesLabel.text = ("It's going to be \(String(format: "%.0f", model.distanceMiles)) miles,")
                self.moneyForGasLabel.text = ("You will spend $\(String(format: "%.2f", model.costOfTrip))")
            }
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

    @IBAction func showRoutePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRoute", sender: self)
    
    }
    


}

//MARK: - LocationManager Delegates

extension TargetViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation : CLLocation = locations[0] as CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil) {
                print("error reverseGeoCode \(String(describing: error))")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count > 0 {
                let origin = String((placemark.first?.locality!)!)
                self.mapsManager.fetchDistance(origin)
                self.originLabel.text = origin
            }
        }
    }
}
