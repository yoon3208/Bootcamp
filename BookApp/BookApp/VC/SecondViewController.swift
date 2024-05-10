//
//  SecondViewController.swift
//  BookApp
//
//  Created by SAMSUNG on 5/6/24.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var results = [Document]()
    var Core = CoreDataManager()
    
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
        
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setConstrains()
        configureUI()
        setDetail()
    }
    
    @objc private func tappedCancelButton() {
        Core.deleteAllWish()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Core.readWish().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        let book = Core.readWish()[indexPath.item]
        DispatchQueue.main.async {
            cell.titleLabel.text = book.title
            cell.priceLabel.text = "\(book.price)원"
        }
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             Core.deleteWish(num: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .fade)
         }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}

//MARK: MyTableViewCell
class MyTableViewCell: UITableViewCell {
    static let identifier = "MyTableViewCell"
    
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstrains()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstrains() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-100)
            make.bottom.equalToSuperview().offset(0)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(270)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    func configureUI() {
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
}

//#Preview {
//    SecondViewController()
//}
