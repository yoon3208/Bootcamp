//
//  ViewController.swift
//  wishListApp
//
//  Created by SAMSUNG on 2024/04/12.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var currentProduct: RemoteProduct? = nil {
        didSet {
            guard let currentProduct = self.currentProduct else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = nil
                self.nameLabel.text = currentProduct.title
                self.descriptionLabel.text = currentProduct.description
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                if let formattedPrice = numberFormatter.string(for: currentProduct.priceKor) {
                    
                    self.priceLabel.text = "\(formattedPrice)₩"
                }
            }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: currentProduct.thumbnail), let image = UIImage(data: data) {
                    DispatchQueue.main.async { self?.imageView.image = image }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchRemoteProduct()
        self.saveProduct()
    }
    @IBAction func teppedSaveButton(_ sender: UIButton) {
        self.saveProduct()
    }
    
    @IBAction func teppedSwitchButton(_ sender: UIButton) {
        self.fetchRemoteProduct()
    }
    
    @IBAction func teppedWishList(_ sender: UIButton) {
        guard let nextVC = self.storyboard?
                    .instantiateViewController(
                        identifier: "WishListViewController"
                    ) as? WishListViewController else { return }
                
                self.present(nextVC, animated: true)
    }
    private func fetchRemoteProduct() {
        let productID = Int.random(in: 1...100)
        
        if let url = URL(string: "https://dummyjson.com/products/\(productID)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let product = try JSONDecoder().decode(RemoteProduct.self, from: data)
                        self.currentProduct = product
                    } catch {
                        print("Decode Error: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    private func saveProduct() {
        guard let context = self.persistentContainer?.viewContext else { return }
        guard let currentProduct = self.currentProduct else { return }

        let myWishProduct = Product(context: context)
        myWishProduct.id = Int64(currentProduct.id)
        myWishProduct.title = currentProduct.title
        myWishProduct.price = Double(currentProduct.priceKor)
        myWishProduct.saved = true

        try? context.save()
    }
    
}
