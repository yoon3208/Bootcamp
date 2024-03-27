//
//  ViewController.swift
//  finalTodoList
//
//  Created by SAMSUNG on 2024/03/21.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    //UIAlertController를 활용하여 텍스트 필드 추가
    @IBAction func addButton(_ sender: Any) {
        
        let title = "할 일 추가"
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "추가", style: .default){(_) in
            if let txt = alert.textFields?[0]{
                if txt.text?.isEmpty != true{
                    print("입력값 \(txt.text!)")
                }else{
                    print("입력된 값이 없습니다")
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        alert.addTextField(){ (tf) in
            tf.placeholder = "텍스트를 입력하시오"

            
        }
        
        self.present(alert, animated: true, completion: nil)

    }
//기본 데이터 소스
    
    var todo = ["Title1", "Title2", "Title3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
                tableView.register(nibName, forCellReuseIdentifier: "TodoCell")
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TableViewCell else{
            return UITableViewCell()
        }
        
        let index = indexPath.row
        if let todoLabel = cell.todoLabel{
            todoLabel.text = todo[index]
        }
        return cell
    }
}
class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkButton: UISwitch!
    
    @IBOutlet weak var todoLabel: UILabel!
    
    @IBAction func tappedSwitchButton(_ sender: UISwitch) {
    }
    

    override func awakeFromNib(){
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
