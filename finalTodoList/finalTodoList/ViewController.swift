//
//  ViewController.swift
//  finalTodoList
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    //UIAlertController를 활용하여 텍스트 필드 추가
    @IBAction func addButton(_ sender: Any) {
        
        
        let title = "할 일 추가"
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField(){ textField in
            textField.placeholder = "텍스트를 입력하시오"
            
        }
        
        let addAction = UIAlertAction(title: "추가", style: .default){ [weak self] _ in
            guard let self = self, let textField = alert.textFields?.first, let text = textField.text, !text.isEmpty else{return}
            
            self.todo.append(text)
            self.tableView.reloadData()
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel){ _ in
            print("취소 버튼이 눌렸습니다")
        }
        alert.addAction(cancel)
        alert.addAction(addAction)
        
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    //예시 TodoList
    struct TodoItem{
        var id: Int
        var todo: String
        var isCompleted: Bool
    }
    
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
    
    //스위치 off시에 글씨에 선 긋기 
    @IBAction func tappedSwitchButton(_ sender: UISwitch) {
        let isCompleted = sender.isOn
        
        if isCompleted{
            if let label = self.todoLabel{
                
                var attributeString = NSMutableAttributedString(string: "\(todoLabel.text!)")
                let attributes: [NSAttributedString.Key : Any] = [
                    .strikethroughStyle: 2
                ]
                attributeString.addAttributes(attributes, range: NSRange(location: 0, length: attributeString.length))
                label.attributedText = attributeString
            }
        }else{
            if let label = self.todoLabel{
                label.attributedText = NSAttributedString(string: label.text ?? "")
            }
        }

        
    }
    

    override func awakeFromNib(){
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

