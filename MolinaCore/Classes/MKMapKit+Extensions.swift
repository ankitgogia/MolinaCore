//
//  MKMapKit+Extensions.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 2/15/17.
//  Copyright © 2017 Molina. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import MapKit

extension UIApplication {
    
    // MARK: - Get Directions
    
    /// Attempt to prompt user for directions
    ///
    /// - Parameters:
    ///   - coordinate: CLLocationCoordinate2D
    ///   - title: String?
    ///   - message: String?
    ///   - name: String?
    ///   - sender: UIViewController?
    public static func getDirections(coordinate: CLLocationCoordinate2D, title: String? = "Get Directions?", message: String? = nil, name: String? = nil, sender: UIViewController? = nil) {
        func map(coordinate: CLLocationCoordinate2D, name: String?) {
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
            if let name = name {
                mapItem.name = name
            }
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
        
        if let viewController = sender {
            let alert = UIAlertController(title: "Get Directions?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(title: "Yes") { _ in
                map(coordinate: coordinate, name: name)
            }
            alert.addAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            viewController.present(alert, animated: true, completion: nil)
        } else {
            map(coordinate: coordinate, name: name)
        }
    }
    
    public static func geocodeAndGetDirections(address: String, title: String? = "Get Directions?", message: String? = nil, name: String? = nil, sender: UIViewController? = nil) {
        
        // Attempt to geocode the address
        let address = address.removeExcessSpace()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            guard let placemark = placemarks?.first,
                let coordinate = placemark.location?.coordinate else {
                    
                    let alert = UIAlertController(title: nil, message: "An error occurred", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(title: "OK")
                    sender?.present(alert, animated: true, completion: nil)
                    return
            }
            
            UIApplication.getDirections(coordinate: coordinate, name: name, sender: sender)
        }
    }



    // MARK: - Geocoding
    
    public static func getPlacemarks(at location: CLLocation, completion: @escaping (Response<[CLPlacemark]>) -> Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
        
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            guard error == nil else {
                let reason = error?.localizedDescription ?? "An error occurred"
                completion(Response.error(reason))
                return
            }
            let placemarks = placemarks ?? []
            completion(Response.success(placemarks))
        }
    }
    
    public static func getPlacemarks(zip: String, state: String, completion: @escaping (Response<[CLPlacemark]>) -> Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        CLGeocoder().geocodeAddressDictionary(["ZIP" : zip, "State": state]) { (placemarks, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            guard error == nil else {
                let reason = error?.localizedDescription ?? "An error occurred"
                completion(Response.error(reason))
                return
            }
            let placemarks = placemarks ?? []
            completion(Response.success(placemarks))
        }
    }
    
    public static func getFirstPlacemark(at location: CLLocation, completion: @escaping (Response<CLPlacemark>) -> Void) {
        
        getPlacemarks(at: location) { response in
            if case Response.error(let reason) = response {
                completion(Response.error(reason))
            }
            if case Response.success(let placemarks) = response {
                if let placemark = placemarks.first {
                    completion(Response.success(placemark))
                    
                } else {
                    completion(Response.error("No results found"))
                }
            }
        }
    }
    
    public static func getFirstPlacemark(at coordinates: CLLocationCoordinate2D, completion: @escaping (Response<CLPlacemark>) -> Void) {
        
        let location: CLLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        getPlacemarks(at: location) { response in
            if case Response.error(let reason) = response {
                completion(Response.error(reason))
            }
            if case Response.success(let placemarks) = response {
                if let placemark = placemarks.first {
                    completion(Response.success(placemark))
                    
                } else {
                    completion(Response.error("No results found"))
                }
            }
        }
    }
    
    public static func getFirstPlacemark(zip: String, state: String, completion: @escaping (Response<CLPlacemark>) -> Void) {
    
        getPlacemarks(zip: zip, state: state) { response in
            if case Response.error(let reason) = response {
                completion(Response.error(reason))
            }
            if case Response.success(let placemarks) = response {
                if let placemark = placemarks.first {
                    completion(Response.success(placemark))
                    
                } else {
                    completion(Response.error("No results found"))
                }
            }
        }
    }
}
