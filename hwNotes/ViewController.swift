//
//  ViewController.swift
//  hwNotes
//
//  Created by Anthony on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // для передачи через closure
    var closure1: ( (String) -> () )?
    var tuple: (String,String)? = nil
    
    var tableView = UITableView()
    

    
    
    var array = [("data+локация А","заметка 1"), ("data+локация Б","заметка 2"), ("data+локация С","заметка 3")]
    var selectArray: [Int] = []
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        closure1?(passText)
        print("View Did Apper - done")
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
        print("action left addBarButtonsFirstVC")
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
        
        // передача от VC1 к VC2
        secondViewController.passText = "test pass text from vc1"
    }
    
    @objc func actionRightBarButton() {
        print("action right addBarButtonsFirstVC")
        tableView.isEditing = !tableView.isEditing
//        tableView.allowsMultipleSelectionDuringEditing = true
//        print(tableView.indexPathForSelectedRow)
        
        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.actionRightBarButton))
            navigationItem.rightBarButtonItem?.tintColor = .systemPink
        
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(self.actionRightBarButton))
            navigationItem.rightBarButtonItem?.tintColor = .systemBlue
            
            //mass dell cells fron ARRAY and VIEW
//            for item in selectArray {
//                print(item)
//                array.remove(at: item)
//                tableView.deleteRows(at: [indexPath], with: .middle)
//                }
            }
//            print("remove items", selectArray, "from array ", array)
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
//        return content.count
        return array.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = array[indexPath.row].0
        cell.textLabel?.textColor = .red
        cell.detailTextLabel?.text = array[indexPath.row].1
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // array of selected cells
        if tableView.isEditing {
            selectArray.append(indexPath.row)
            print("select ", indexPath.row, "selectArray - ", selectArray)

        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
//            selectArray.remove(at: indexPath.row - 1)
            print("deselect ", indexPath.row)
        }
    }
}
    
    //cell insetr editing
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .insert
//    }

    //cell insert
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .insert {
//            let tuple = ("add tuple", "text")
//            array.append(tuple)
//            tableView.insertRows(at: [indexPath], with: .right)
//        }
//    }
    
    //cell deleteing
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            array.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .left)
//        }
//    }
    
    //cell move
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    //cell moveing
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
//        let item = array[sourceIndexPath.row]
//        array.remove(at: sourceIndexPath.row)
//        array.insert(item, at: destinationIndexPath.row)
//    }
}
