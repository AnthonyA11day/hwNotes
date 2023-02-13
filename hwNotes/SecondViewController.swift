//
//  SecondViewController.swift
//  hwNotes
//
//  Created by Anthony on 11.02.2023.
//

import UIKit
import MapKit


class SecondViewController: ViewController {
    
    private let map: MKMapView = {
       let map = MKMapView()
       return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigation()
    }
    
    override func setupSubview() {
        title = "Add notes"
        view.backgroundColor = .systemGray4
        view.addSubview(map)
        
        addBarButtonsSecond()
    }
}

//MARK: bar button
extension SecondViewController {
    func addBarButtonsSecond() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(actionRightBarButton))
    }
    
    override func actionRightBarButton() {
        print("override righr button test")
    }
}

//MARK: navigation map
extension SecondViewController {
    
    func navigation() {
        
        map.frame = view.bounds
    }    
}
