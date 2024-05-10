//
//  DetailVeiwController.swift
//  BookApp
//
//  Created by SAMSUNG on 5/7/24.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
//    let apiDataManager = APIDataManager()
    var results: Document?
    var Core = CoreDataManager()
    
//    let detailStackView = UIStackView()
    private let scrollView = UIScrollView()
    private let detailView = UIView()
    let detailImageVeiw = UIImageView()
    let detailTitleLabel = UILabel()
    let detailPriceLabel = UILabel()
    let detailContentsLabel = UILabel()
    
    let wishButton = UIButton()
    let cancelButton = UIButton()
    
    
    private func setConstrains() {
        
        view.addSubview(scrollView)
        view.addSubview(detailImageVeiw)
//        view.addSubview(detailStackView)
        view.addSubview(detailTitleLabel)
        view.addSubview(detailPriceLabel)
        view.addSubview(detailContentsLabel)
        view.addSubview(wishButton)
        view.addSubview(cancelButton)
//        scrollView.addSubview(detailContentsLabel)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(490)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
            make.bottom.equalTo(detailContentsLabel.snp.bottom).offset(100)
        }
        detailImageVeiw.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.leading.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-80)
            make.bottom.equalToSuperview().offset(-400)
        }
//        detailStackView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(380)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.bottom.equalToSuperview().offset(0)
//        }
        detailTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-700)
        }
        detailPriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(480)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-330)
        }
        detailContentsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(490)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
        }
        wishButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(760)
            make.leading.equalToSuperview().offset(150)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(760)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-260)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setDetail() {
        
        scrollView.backgroundColor = .clear
        detailImageVeiw.backgroundColor = .clear
        detailTitleLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        detailPriceLabel.backgroundColor = .clear
        detailContentsLabel.backgroundColor = .clear
        wishButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        cancelButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        detailImageVeiw.contentMode = .scaleAspectFill
        
        detailTitleLabel.text = self.results?.title
        detailTitleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        detailTitleLabel.textAlignment = .center
        detailTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        detailPriceLabel.text = "\(self.results!.price)원"
        detailPriceLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        detailPriceLabel.textAlignment = .center
        detailPriceLabel.font = UIFont.systemFont(ofSize: 20)
        
        detailContentsLabel.text = self.results?.contents
        detailContentsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        detailContentsLabel.numberOfLines = 0
        detailContentsLabel.font = UIFont.systemFont(ofSize: 15)
        
        wishButton.setTitle("담기", for: .normal)
        wishButton.layer.cornerRadius = 20
        wishButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        cancelButton.setTitle("X", for: .normal)
        cancelButton.layer.cornerRadius = 20
        cancelButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: detailContentsLabel.frame.maxY + 100)
        
        if let imageUrlString = self.results?.thumbnail,
           let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.detailImageVeiw.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func addButtonTapped() {
        Core.saveWish(myWish: MyWish(title: results!.title, thumbnail: results!.thumbnail, price: results!.price, contents: results!.contents))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstrains()
        setDetail()
    }
}
//#Preview {
//    DetailViewController()
//}
