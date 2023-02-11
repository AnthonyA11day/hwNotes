//
//  ViewController.swift
//  hwNotes
//
//  Created by Anthony on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubview()
    }
    
    func addSubview() {
        title = "Notes"
        view.backgroundColor = .systemGray4
        
        addBarButtonsFirstVC()
    }
}

extension ViewController {
    func addBarButtonsFirstVC() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(actionRightBarButton))
    }
    
    @objc func actionRightBarButton() {
        print("action right addBarButtonsFirstVC")
    }
}

