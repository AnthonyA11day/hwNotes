//
//  SecondViewController.swift
//  hwNotes
//
//  Created by Anthony on 14.02.2023.
//

import UIKit
import MapKit
import CoreLocation

final class SecondViewController: UIViewController {
    
    // for location
    var lat: Double = 40.43065
    var lon: Double = -79.92317
    
    //for dta pass
    var passText: String = ""
    
    private var mapButton = UIButton()
    
    let sender: UIDatePicker = {
        let sender = UIDatePicker()
        sender.date = .now
        return sender
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.locale = .current
//        formatter.timeZone = .autoupdatingCurrent
        formatter.dateFormat = "d MMM yyyy, h:mm:ss a"
        return formatter
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
        label.text = "Date and Time"
        label.backgroundColor = .systemPink
        label.textAlignment = .center
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 250, width: 300, height: 50))
        label.text = "Country, City"
        label.backgroundColor = .orange
        label.textAlignment = .center
        return label
    }()
    
    var noteTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 0, y: 300, width: 300, height: 16 * 10))
//        textField.placeholder = " enter text hear"
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 3
        textView.textAlignment = .left

//        textField.becomeFirstResponder()
//        textField.isFirstResponder

        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        
        //передача времени и даты
        dateLabel.text = formatter.string(from: sender.date)
        
        //передача локации
//        locationLabel.text = "Страна, Город"
        
        // передача данных
        noteTextView.text = passText
        locationLabel.text = passText
    }
    
    func setupSubview() {
        title = "Add New Note"
        view.backgroundColor = .systemGray4
        addBarButtonsSecondVC()
        lacation()

        [dateLabel, locationLabel, noteTextView].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.center.x = view.center.x
            view.addSubview( $0 )
            

        }
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
        
        if noteTextView.text == ""{
            print("not saved, nat pass")
        } else {
            print("saved and pass")
            
            // data pass
//            let reciverVC = ViewController()
//            secondtVC.tuple = ( String(dateLabel.text ?? ""), String(noteTextView.text) )
//            secondtVC.passText = noteTextView.text
//            reciverVC.passText = "passsss texxxxxtttt "
            
        }
        
    }
    
    @objc func actionRightBarButton() {
        print("action left addBarButtonsFirstVC")
        navigationController?.pushViewController(MapViewController(), animated: true)
    }
    
}

extension SecondViewController {
    

}


extension SecondViewController {

//    func lacation() -> (country: String, city: String) {
    func lacation() {

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error -> Void in
            guard let placemark = placemarks?.first else { return }
//            if let subThoughtfare = placemark.subThoroughfare { print(subThoughtfare) }
//            if let thoroughfare = placemark.thoroughfare { print(thoroughfare) }
            if let city = placemark.locality { print(city) }
            if let country = placemark.isoCountryCode { print(country) }
//            if let zip = placemark.postalCode { print(zip) }
        } )
        return
    }
}



extension UIStackView {
    func addViews(_ views: [UIView?]) {
        views.forEach {
            guard let view = $0 else { return }
            self.addArrangedSubview(view)
        }
    }
}
