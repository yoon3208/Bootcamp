//
//  ViewController.swift
//  BookApp
//
//  Created by SAMSUNG on 5/6/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
//    private let apiDataManager = APIDataManager()
    private var searchResult = [Document]()
    private let searchVC = UISearchController(searchResultsController: nil)
    
    let flowLayout = UICollectionViewFlowLayout()
    let mySearchBar = UISearchBar()
    let mySearchLabel = UILabel()
    let resultLabel = UILabel()
    lazy var bookCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: collectionViewLayout)
    
    let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 350, height: 50)
        
        return layout
    }()
    
    private func setConstrains() {
        
        view.addSubview(mySearchBar)
        view.addSubview(bookCollectionView)
//        view.addSubview(mySearchLabel)
        view.addSubview(resultLabel)
        
        mySearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-750)
        }
        bookCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-70)
        }
//        mySearchLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(110)
//            make.leading.equalToSuperview().offset(15)
//            make.trailing.equalToSuperview().offset(-50)
//            make.bottom.equalToSuperview().offset(-720)
//        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalToSuperview().offset(-600)
        }
    }
    
    private func configureUI() {
        
        mySearchBar.delegate = self
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        
        bookCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
    }
    
    private func setDetail() {
        
        bookCollectionView.backgroundColor = .clear
        mySearchBar.searchBarStyle = .minimal
        
//        mySearchLabel.text = "최근 본 책"
//        mySearchLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        resultLabel.text = "검색 결과"
        resultLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
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
            self.searchResult = result!
            print("비동기 시작")
            DispatchQueue.main.async {
                self.bookCollectionView.reloadData()
                print("비동기 완료")
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
            DispatchQueue.main.async {
                cell.nameLabel.text = self.searchResult[indexPath.row].title
                cell.priceLabel.text = "\(self.searchResult[indexPath.row].price)원"
                print("셀: \(cell)")
            }
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.results = searchResult[indexPath.item]
        present(detailVC, animated: true)
    }
}
    
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

    
    #Preview {
        ViewController()
    }
