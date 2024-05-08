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
    
//    let detailStackView = UIStackView()
    private let scrollView = UIScrollView()
    private let detailView = UIView()
    private let backButton = UIButton()
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
        view.addSubview(backButton)
        view.addSubview(wishButton)
        view.addSubview(cancelButton)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-105)
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
            make.top.equalToSuperview().offset(450)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-350)
        }
        detailContentsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(500)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-105)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-330)
            make.bottom.equalToSuperview().offset(-760)
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
        
        scrollView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        detailImageVeiw.backgroundColor = .gray
        detailTitleLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        detailPriceLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        detailContentsLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backButton.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
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
        
        backButton.setTitle("X", for: .normal)
        backButton.layer.cornerRadius = 20
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        wishButton.setTitle("담기", for: .normal)
        wishButton.layer.cornerRadius = 20
        
        cancelButton.setTitle("X", for: .normal)
        cancelButton.layer.cornerRadius = 20
    }
    @objc private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
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
