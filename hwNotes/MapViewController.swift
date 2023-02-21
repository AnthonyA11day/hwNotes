////
////  SecondViewController.swift
////  hwNotes
////
////  Created by Anthony on 11.02.2023.
////
//
//import UIKit
//import MapKit
//import CoreLocation
//
//class MapViewController: ViewController {
//    
//    private let map: MKMapView = {
//        let map = MKMapView()
//        return map
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupSubview()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        map.frame = view.bounds
//    }
//    
//    override func setupSubview() {
//        navigationController?.navigationBar.prefersLargeTitles = true
//        title = "Map for Notes"
//        view.backgroundColor = .systemGray4
//        view.addSubview(map)
//        
//        LocationManager.shared.getUserLocation { [weak self] location in
//            DispatchQueue.main.async {
//                guard let strongSelf = self else {
//                    return
//                }
//                strongSelf.addMapPin(with: location)
//            }
//        }
//        
//        //        addBarButtonsSecond()
//    }
//
//    func addMapPin(with location: CLLocation) {
//        let pin = MKPointAnnotation()
//        pin.coordinate = location.coordinate
//        map.setRegion(MKCoordinateRegion(
//            center: location.coordinate,
//            span: MKCoordinateSpan(
//                latitudeDelta: 0.7,
//                longitudeDelta: 0.7
//            )
//        ),
//                      animated: true)
//        map.addAnnotation(pin)
//        
//        // проиписываю сюда функцию из LocationManager
//        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
//            self?.title = locationName
//        }
//        print("==== test ===== \(LocationManager.shared)")
//
//    }
//
//}
//
////MARK: bar button
////extension ThirdViewController {
////    func addBarButtonsSecond() {
////        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
////                                                            target: self,
////                                                            action: #selector(actionRightBarButton))
////    }
////
////    override func actionRightBarButton() {
////        print("override righr button test")
////    }
////}
//
////MARK: navigation map
////extension MapViewController {
////    func navigation() {
////        map.frame = view.bounds
////    }
////}
