//
//  ViewController.swift
//  BookApp
//
//  Created by SAMSUNG on 5/6/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var searchResult = [Document]()
    private let searchVC = UISearchController(searchResultsController: nil)
    
    let flowLayout = UICollectionViewFlowLayout()
    let mySearchBar = UISearchBar()
    let tableView = UITableView()
    
    private func setConstrains() {
        
        view.addSubview(mySearchBar)
        view.addSubview(tableView)
        
        mySearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-750)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-70)
        }
    }
    
    private func configureUI() {
        
        mySearchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(TableViewCell2.self, forCellReuseIdentifier: TableViewCell2.identifier)
    }
    
    private func setDetail() {
        
        tableView.backgroundColor = .clear
        mySearchBar.searchBarStyle = .minimal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setConstrains()
        configureUI()
        setDetail()
    }
    
    func fetchSearchBooks(for searchTerm: String) {
        APIDataManager.shared.readAPI(keyword: searchTerm) { (result: [Document]?, error: Error?) in
            self.searchResult = result ?? []
            print("비동기 시작")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("비동기 완료")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell2.identifier, for: indexPath) as! TableViewCell2
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
            cell.searchResult = searchResult
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let interval: CGFloat = 3
        let width: CGFloat = ( UIScreen.main.bounds.width - interval * 3 ) / 2
        
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return(width) * 5
        default:
            return 0
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    private func dismissKeyboard() {
        mySearchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
               fetchSearchBooks(for: searchText)
    }
}

//MARK: BookCollectionViewCell
class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstrains()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstrains() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        
        nameLabel.snp.makeConstraints { make in
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

//MARK: MyCollectionViewCell
class MyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    let myBookLabel = UILabel()
    let myPriceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstrains()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstrains() {
        
        contentView.addSubview(myBookLabel)
        contentView.addSubview(myPriceLabel)
        
        myBookLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-100)
            make.bottom.equalToSuperview().offset(0)
        }
        myPriceLabel.snp.makeConstraints { make in
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
//        contentView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//        contentView.layer.cornerRadius = 10
//        contentView.clipsToBounds = true
    }
}

//MARK: TableViewCell
class TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    static let identifier = "TableViewCell"
    
    var searchResult: [Document] = [] {
        didSet {
            bookCollectionView.reloadData()
        }
    }
    
    let searchLabel = UILabel()
    
    lazy var bookCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        layout.itemSize = CGSize(width: 350, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstrains()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstrains() {
        
        contentView.addSubview(bookCollectionView)
        contentView.addSubview(searchLabel)
        
        bookCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        searchLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-900)
        }
    }
    
    func configureUI() {
        
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        
        bookCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        bookCollectionView.backgroundColor = .clear
        
        searchLabel.text = "검색결과"
        searchLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        DispatchQueue.main.async {
            cell.nameLabel.text = self.searchResult[indexPath.row].title
            cell.priceLabel.text = "\(self.searchResult[indexPath.row].price)원"
        }
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.results = searchResult[indexPath.item]
        UIApplication.shared.keyWindow?.rootViewController?.present(detailVC, animated: true)
    }
}

//MARK: TableViewCell2
class TableViewCell2: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let identifier = "TableViewCell2"
    
    var Core = CoreDataManager()
    var searchResult: [Document] = [] {
        didSet {
            myCollectionView.reloadData()
        }
    }
    
    let resultLabel = UILabel()
    
    lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        layout.itemSize = CGSize(width: 350, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstrains()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstrains() {
        
        contentView.addSubview(myCollectionView)
        contentView.addSubview(resultLabel)
        
        myCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
    func configureUI() {
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        myCollectionView.backgroundColor = .clear
        
        resultLabel.text = "나의 책 리스트"
        resultLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Core.readWish().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        let book = Core.readWish()[indexPath.item]
        cell.myBookLabel.text = book.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath ) {
        let selectionBook = Core.readWish()[indexPath.item]
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.results = Document(title: selectionBook.title, contents: selectionBook.contents, thumbnail: selectionBook.thumbnail, price: selectionBook.price)
        UIApplication.shared.keyWindow?.rootViewController?.present(detailVC, animated: true)
    }
}

//    #Preview {
//        ViewController()
//    
