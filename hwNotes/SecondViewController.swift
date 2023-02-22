//
//  SecondViewController.swift
//  hwNotes
//
//  Created by Anthony on 14.02.2023.
//

import UIKit
import MapKit
import CoreLocation

protocol Delegate {
    func addNewCell(dateAndLocation: String, text: String)
}

final class SecondViewController: UIViewController {
    
    // for location
    let locationManager = CLLocationManager()
    var lat: Double = 40.43065
    var lon: Double = -79.92317
    
    //for data pass via Closure
    var closure: ( (String) -> () )?
    var passText = ""
    
    //for data passs via Delegate
    var delegate: Delegate?
    
    
    let sender: UIDatePicker = {
        let sender = UIDatePicker()
        sender.date = .now
        return sender
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.locale = .current
//        formatter.timeZone = .autoupdatingCurrent
        formatter.dateFormat = "yyyy.MM.dd, HH:mm"
        return formatter
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
        label.text = "Date and Time"
//        label.backgroundColor = .systemPink
        label.backgroundColor = .systemGray2
        label.textAlignment = .center
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 250, width: 300, height: 50))
        label.text = "Country, City"
//        label.backgroundColor = .orange
        label.backgroundColor = .systemGray2
        label.textAlignment = .center
        return label
    }()
    
    var noteTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 0, y: 300, width: 300, height: 16 * 10))
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 3
        textView.textAlignment = .left
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        update()
    }
    
    func setupSubview() {
        title = "Add New Note"
        view.backgroundColor = .systemGray4
        addBarButtonsSecondVC()
        
        [dateLabel, locationLabel, noteTextView].forEach {
            $0.center.x = view.center.x
            view.addSubview( $0 )
        }
    }
    
    func update() {
        // date and time
        dateLabel.text = formatter.string(from: sender.date)
        
        // location func
        startLocationManager()
        
        // pass data from VC1 to VC2
        noteTextView.text = passText
    }
    
    func addBarButtonsSecondVC() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(actionLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(actionRightBarButton))
    }
    
    @objc func actionLeftBarButton() {
        print("action right addBarButtonsFirstVC")
        navigationController?.popViewController(animated: true)
        
        if noteTextView.text == "" {
            print("not saved, not pass")
        } else {
            print("saved and pass")
            
            // pass data from VC2 to VC1 via Delegate
            delegate?.addNewCell(dateAndLocation: String(dateLabel.text ?? "nil") + " - " + String(locationLabel.text ?? ""),
                                text: String(noteTextView.text ?? "nil") )
            
            // pass data from VC2 to VC1 via Closure
            closure?(noteTextView.text)
        }
    }
    
    @objc func actionRightBarButton() {
        print("action left addBarButtonsFirstVC")
//        navigationController?.pushViewController(MapViewController(), animated: true)
    }
}


extension SecondViewController {
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
}

extension SecondViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            
            let location = CLLocation(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error -> Void in
                guard let placemark = placemarks?.first else { return }
    //            if let subThoughtfare = placemark.subThoroughfare { print(subThoughtfare) }
//                if let thoroughfare = placemark.thoroughfare { print(thoroughfare) }
                if let city = placemark.locality { print(city) }
                if let country = placemark.country { print(country) }
    //            if let zip = placemark.postalCode { print(zip) }
                self.locationLabel.text = String(placemark.country ?? "") + ", " + String(placemark.locality ?? "")
            } )
            return
        }
    }
}
