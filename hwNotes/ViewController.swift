//
//  ViewController.swift
//  hwNotes
//
//  Created by Anthony on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    let identifire = "cell"
    var array = ["1-","2-","3-","4-","5-","6-","7-","8-","9-"]

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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(actionLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(actionRightBarButton))

    }
    
    
    @objc func actionLeftBarButton() {
        print("action left addBarButtonsFirstVC")
        tableView.isEditing = !tableView.isEditing
        
    }
    @objc func actionRightBarButton() {
        print("action right addBarButtonsFirstVC")
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}

//MARK: - tableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        //        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    //MARK: UITableView DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row) test text "
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    //MARK: UITableView Delegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let number = indexPath.row
        array.append(String(number))
        print(number, array.count)
        
    }
    
    //cell delete editing
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //cell delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

