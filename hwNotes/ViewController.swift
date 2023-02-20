//
//  ViewController.swift
//  hwNotes
//
//  Created by Anthony on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
//    let tableView: UITableView.init()
    var content = Source.makeContent()
    let identifire = "CustomCell"
//    let identifire = "cell"
//
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(actionLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(actionRightBarButton))
    }
    
    @objc func actionLeftBarButton() {
        print("action right addBarButtonsFirstVC")
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func actionRightBarButton() {
        print("action left addBarButtonsFirstVC")
        tableView.isEditing = !tableView.isEditing
    }
}

//MARK: - tableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
//        tableView.register(CustomCell.self, forCellReuseIdentifier: identifire)
//        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
//MARK: UITableView DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = "\(indexPath.row) textLabel - дата, время, страна, город"
        cell.textLabel?.textColor = .red

        cell.detailTextLabel?.text = "detail text - троки из заметки"
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row) test text "
//        cell.textLabel?.text = array[indexPath.row]
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? CustomCell
//            else { fatalError() }
//        cell.configere(content: content[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    

//MARK: UITableView Delegate methods
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let number = indexPath.row
        array.append(String(number))
        print(number, array.count)
    }
    
//    //cell delete editing
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }

    //cell deleteing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    //cell move
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    //cell moveing
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = array[sourceIndexPath.row]
        array.remove(at: sourceIndexPath.row)
        array.insert(item, at: destinationIndexPath.row)
    }
}
