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
     
    var lat: Double = 40.43065
    var lon: Double = -79.92317
    
    private var mapButton = UIButton()
    
    var dateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 150, width: 300, height: 50))
        label.text = "Date, Time"
        label.backgroundColor = .systemPink
        label.textAlignment = .center
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
        label.text = "Country, City"
        label.backgroundColor = .orange
        label.textAlignment = .center
        return label
    }()
    
    var noteTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 0, y: 250, width: 300, height: 16 * 10))
//        textField.placeholder = " enter text hear"
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 3
        textView.textAlignment = .left
//        textField.becomeFirstResponder()
//        textField.isFirstResponder

        return textView
    }()
    
    var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .firstBaseline
        stack.isBaselineRelativeArrangement = true
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
    }
    
    func setupSubview() {
        title = "Add New Note"
        view.backgroundColor = .systemGray4
        
//        createButtons()
        addBarButtonsSecondVC()
        lacation()
        
        view.addSubview(dateLabel)
        view.addSubview(locationLabel)
        view.addSubview(noteTextView)

        [dateLabel, locationLabel, noteTextView].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.center.x = view.center.x
            view.addSubview( $0 )
        }
        
//        verticalStack.translatesAutoresizingMaskIntoConstraints = false
//        verticalStack.addArrangedSubview(dateLabel)
        
//        verticalStack.addViews([dateLabel, locationLabel, noteTextfield])
//        view.addSubview(verticalStack)
        
//        NSLayoutConstraint.activate([
//            verticalStack.widthAnchor.constraint(equalToConstant: 300),
//            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
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
    }
    
    @objc func actionRightBarButton() {
        print("action left addBarButtonsFirstVC")
        navigationController?.pushViewController(MapViewController(), animated: true)
    }
    
//MARK: add buttons
    func createButtons() {
        mapButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 16 * 2))
        mapButton.backgroundColor = .orange
        mapButton.setTitle("Map", for: .normal)
        mapButton.setTitleColor(.white, for: .normal)
        mapButton.setTitleColor(.gray, for: .highlighted)
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapButton)
        
//        NSLayoutConstraint.activate([
//            mapButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
//            mapButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
//            mapButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
//            mapButton.heightAnchor.constraint(equalToConstant: 100)
//        ])
    }
    
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
