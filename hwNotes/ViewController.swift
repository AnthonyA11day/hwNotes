//
//  ViewController.swift
//  hwNotes
//
//  Created by Anthony on 11.02.2023.
//

import UIKit

class ViewController: UIViewController, Delegate {
    
    // для передачи через closure
    var closure1: ( (String) -> () )?
    var tuple: (String,String) = ("","")
    var celectedOneCell: Int?
    
    var tableView = UITableView()
    var notesArray = [("data+локация А","заметка 1"), ("data+локация Б","заметка 2"), ("data+локация С","заметка 3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
    }
    
    // pass data from VC2 to VC1 via Delegate
    func addNewCell(dateAndLocation: String, text: String) {
        notesArray.append( (dateAndLocation, text) )
        tableView.reloadData()
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
//        print("action left addBarButtonsFirstVC")
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
        secondViewController.delegate = self
        
        // pass detailText from cell VC1 to textView VC2
        guard !notesArray.isEmpty else { return }
        if let item = self.celectedOneCell {
            secondViewController.passText = notesArray[item].1
        }

        // pass from VC2 to VC1
        secondViewController.closure = { [weak self] text in
            self?.title = text
            
//            tableView.delegate.cellForRow(at: IndexPath)
//            tableView.reloadData()
        }

    }
    
    @objc func actionRightBarButton() {
//        tableView.allowsMultipleSelectionDuringEditing = true
        guard !notesArray.isEmpty else { return }
        
        if tableView.isEditing {
            if let selected = tableView.indexPathsForSelectedRows {
                print("selecled counts -", selected.count, "selecled -", selected)
                let items = selected.map{$0[1]}.sorted{$0 > $1}
                for item in items {
                    notesArray.remove(at: item)
                    tableView.reloadData()
                }
            }
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                                target: self,
                                                                action: #selector(self.actionRightBarButton))
            tableView.isEditing = false
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                                target: self,
                                                                action: #selector(self.actionRightBarButton))
            navigationItem.rightBarButtonItem?.tintColor = .systemPink
            tableView.isEditing = true
            }
        }
}


//MARK: - tableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.register(CustomCell.self, forCellReuseIdentifier: identifire)
//        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.allowsMultipleSelectionDuringEditing = true
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
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = notesArray[indexPath.row].0
        cell.textLabel?.textColor = .red
        cell.detailTextLabel?.text = notesArray[indexPath.row].1
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? CustomCell
//            else { fatalError() }
//        cell.configere(content: content[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    //MARK: UITableView Delegate methods
    // cell  editing
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // cell deleteing one by one
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notesArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // cell mono selecting
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        celectedOneCell = Int(indexPath.row)
        print(indexPath.row)
    }

}


    //cell insert
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .insert {
//            let tuple = ("add tuple", "text")
//            notesArray.append(tuple)
//            tableView.insertRows(at: [indexPath], with: .right)
//        }
//    }
    
//    //cell move
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
//
//    //cell moveing
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//
//        let item = notesArray[sourceIndexPath.row]
//        notesArray.remove(at: sourceIndexPath.row)
//        notesArray.insert(item, at: destinationIndexPath.row)
//    }
//}
