//
//  SecondViewController.swift
//  hwNotes
//
//  Created by Anthony on 11.02.2023.
//

import UIKit

class SecondViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubview()
    }
    
    override func setupSubview() {
        title = "Add notes"
        view.backgroundColor = .systemGray4
        
        addBarButtonsSecond()
    }
}

extension SecondViewController{
    func addBarButtonsSecond() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(actionRightBarButton))
    }
    
    override func actionRightBarButton() {
        print("override righr button test")
    }
}
