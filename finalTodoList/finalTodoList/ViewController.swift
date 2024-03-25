//
//  ViewController.swift
//  finalTodoList
//
//  Created by SAMSUNG on 2024/03/21.
//

import UIKit

class ViewController: UIViewController{

    
    let todo = ["Title1", "Title2", "Title3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
                tableView.register(nibName, forCellReuseIdentifier: "TodoCell")
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TableViewCell else{
            return UITableViewCell()
        }
        let index = indexPath.row
       
        return cell
    }
}
class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBAction func tappedCheckButton(_ sender: Any) {
        checkButton.isSelected.toggle()
    }
}
