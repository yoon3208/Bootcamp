//
//  ViewController.swift
//  finalTodoList
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    //2. UIAlertController를 활용하여 텍스트 필드 추가
    @IBAction func addButton(_ sender: Any) {
        
        //alert창의 제목 등 설정
        let title = "할 일 추가"
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //alert창에 텍스트 필드 추가
        alert.addTextField(){ textField in
            //placeholder를 사용하여 사용자가 입력할 켁스트 유도
            textField.placeholder = "텍스트를 입력하시오"
            
        }
        // [weak self]를 사용하여 self를 약한 참조롤 캡처 -> 메모리 누수 방지
        let addAction = UIAlertAction(title: "추가", style: .default){ [weak self] _ in
            //첫번째 텍스트 필드를 가져와 입력한 텍스트를 가져옴(텍스츠가 비어있다면 동작 수행X)
            guard let self = self, let textField = alert.textFields?.first, let text = textField.text, !text.isEmpty else{return}
            
            //'text'를 'todo'배열에 추가
            self.todo.append(text)
            //테이블뷰를 다시 로드하여 변경사항 반영
            self.tableView.reloadData()
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel){ _ in
            print("취소 버튼이 눌렸습니다")
        }
        alert.addAction(cancel)
        alert.addAction(addAction)
        
        //UIAlertController를 화면에 표시, 추가적으로 수행할 작업이 없으므로 nil로 설정
        self.present(alert, animated: true, completion: nil)
        
    }
    //1. 기본 베이스
    struct TodoItem{
        var todo: String
        var isCompleted: Bool
    }
    //todo변수 선언 및 초기값으로 문자열 배열 할당
    var todo = ["Title1", "Title2", "Title3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dataSource 및 delegate 설정 (테이블뷰와 관련된 데이터 및 동작을 수행하기 위해 필요)
        tableView.dataSource = self
        tableView.delegate = self
        
        
        //XIB 파일에 정의된 "TableViewCell"을 테이블뷰에 등록하는 과정
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "TodoCell")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    //테이블뷰에 섹션없이 모든 행을 표시
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }
   //특정 IndexPath에 해당하는 테이블뷰의 셀을 반환
    //IndexPath == 섹션과 행의 인덱스를 나타내는 객체
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //사용 가능한 셀을 가져오는 데, "TableViewCell"의 인스턴스인지 확인
        //guard let을 사용함으로 옵셔널 값이 존재하지 않는 경우에 대한 처리를 명확하게 함
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TableViewCell else{
            //셀을 가져오는 과정에서 실패하면 "UITableViewCell"로 셀을 대체 함
            return UITableViewCell()
        }
        //indexPath.row로 현재 행의 인덱스를 가져옴
        let index = indexPath.row
        //현재 셀의 "todoLable" 속성이 옵셔널인지 확인
        //현재 행의 할 일을 'todo'배열에서 가져와 'todoLable.text'에 할당
        if let todoLabel = cell.todoLabel{
            todoLabel.text = todo[index]
        }
        return cell
    }
    //4. 스와이프 하면 삭제 되는 기능
    private func tableView(_ tableView: UITableView, editingStlyeForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //사용자가 셀을 삭제하는 지 여부 확인
        if editingStyle == .delete{
            //테이블뷰의 업데이트를 위한 코드
            tableView.beginUpdates()
            
            // 특정 Index에 있는 row를 삭제 하는 기능
            todo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //변경사항을 저장하고 업데이트를 위한 코드
            tableView.endUpdates()
        }
            
    }
}
        
//스토리보드에서 TableView를 ViewController에 드래그 앤 드롭
//delegate와 dataSource를 선택해주어야 함
class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkButton: UISwitch!
    
    @IBOutlet weak var todoLabel: UILabel!
    
    @IBAction func tappedSwitchButton(_ sender: UISwitch) {
        
        //3. 완료시 취소선 만들기
        //'.isOn'을 사용하여 현재 스위치 상태 확인
        let isCompleted = sender.isOn
        
        //스위치가 켜진 상태일 때 실행
        if isCompleted{
            if let label = self.todoLabel{
                
                /*Todo 항목의 텍스트를 포함하는 NSMutableAttributedString을 생성
                Todo 항목의 텍스트에 선을 추가 가능*/
                let attributeString = NSMutableAttributedString(string: "\(todoLabel.text!)")
                //선의 스타일 속성 정의
                let attributes: [NSAttributedString.Key : Any] = [
                    .strikethroughStyle: 2
                ]
                //스위치가 켜진 경우,
                //addAttributes 메서드를 사용하여 스트라이크스루(취소선) 스타일을 적용
                attributeString.addAttributes(attributes, range: NSRange(location: 0, length: attributeString.length))
                //attributedText를 업데이트하여 꾸며진 문자열을 표시
                label.attributedText = attributeString
            }
        }else{
            //스위치가 꺼진 경우,
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

