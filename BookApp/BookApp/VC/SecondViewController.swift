//
//  SecondViewController.swift
//  BookApp
//
//  Created by SAMSUNG on 5/6/24.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    let apiDataManager = APIDataManager()
    private var results = [Document]()
    
    lazy var tableView = UITableView()
    let cartLabel = UILabel()
    let addButton = UIButton()
    let cancelButton = UIButton()
    
    private func setConstrains() {
        
        view.addSubview(tableView)
        view.addSubview(cartLabel)
        view.addSubview(addButton)
        view.addSubview(cancelButton)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-70)
        }
        cartLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-750)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(310)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-745)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-300)
            make.bottom.equalToSuperview().offset(-745)
        }
    }
    
    private func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifier)
    }
    
    private func setDetail() {
        
        tableView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cartLabel.backgroundColor = .clear
        addButton.backgroundColor = .clear
        cancelButton.backgroundColor = .clear
        
        cartLabel.text = "담은 책"
        cartLabel.font = .boldSystemFont(ofSize: 30)
        cartLabel.textAlignment = .center
        
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.systemGreen, for: .normal)
        
        cancelButton.setTitle("전체 삭제", for: .normal)
        cancelButton.setTitleColor(.darkGray, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setConstrains()
        configureUI()
        setDetail()
    }
    
    @objc private func tappedCancellButton() {
        results.removeAll()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
}
class MyTableViewCell: UITableViewCell {
    static let identifier = "MyTableViewCell"
    
}
//#Preview {
//    SecondViewController()
//}
