//
//  Location+CoreDataClass.swift
//  MyLocations
//
//  Created by Kyle Musto on 3/2/23.
//
//

import CoreData
import Foundation
import MapKit

@objc(Location)
public class Location: NSManagedObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    // Title.
    public var title: String? {
        if locationDescription.isEmpty {
            return "(No Description)"
        } else {
            return locationDescription
        }
    }
    
    // Subtitle.
    public var subtitle: String? {
        return category
    }
    
    var hasPhoto: Bool {
        return photoID != nil
    }
    
    //
    var photoURL: URL {
        assert(photoID != nil, "No photo ID set")
        let filename = "Photo-\(photoID!.intValue).jpg"
        return applicationDocumentsDirectory.appendingPathComponent(filename)
    }
    
    var photoImage: UIImage? {
        return UIImage(contentsOfFile: photoURL.path)
    }
    
    // Gives photos unique IDs.
    class func nextPhotoID() -> Int {
        let userDefaults = UserDefaults.standard
        let currentID = userDefaults.integer(forKey: "PhotoID") + 1
        userDefaults.set(currentID, forKey: "PhotoID")
        return currentID
    }
    
    // Removes photo from system.
    func removePhotoFile() {
        if hasPhoto {
            do {
                try FileManager.default.removeItem(at: photoURL)
            } catch {
                print("Error removing file: \(error)")
            }
        }
    }
}
