//
//  ViewController.swift
//  hwNotes
//
//  Created by Anthony on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubview()
    }
    
    func setupSubview() {
        title = "Notes"
        view.backgroundColor = .systemGray4
        
        addBarButtonsFirstVC()
        setupTableView()
    }
}

//MARK: - bar buttons
extension ViewController {
    func addBarButtonsFirstVC() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(actionRightBarButton))
    }
    
    @objc func actionRightBarButton() {
        print("action right addBarButtonsFirstVC")
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}

//MARK: - tableView
extension ViewController {
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
    }
    
}
