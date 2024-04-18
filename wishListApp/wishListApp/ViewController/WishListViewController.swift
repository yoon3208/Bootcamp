//
//  WishListViewController.swift
//  wishListApp
//
//  Created by SAMSUNG on 2024/04/12.
//

import UIKit
import CoreData


class WishListViewController: UITableViewController {
    
    @IBOutlet weak var wishTableView: UITableView!
    
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    private var productList: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setProductList()
    }
    private func setProductList() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Product.fetchRequest()
        request.predicate = NSPredicate(format: "saved == true")
        
        if let productList = try? context.fetch(request) {
            self.productList = productList
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let product = self.productList[indexPath.row]
        
        let id = product.id
        let title = product.title ?? ""
        let price = product.price
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let formattedPrice = numberFormatter.string(for: product.price) {
            
            cell.textLabel?.text = "[\(id)] \(title) - \(formattedPrice)₩"
        }
        return cell
    }
    internal override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let context = self.persistentContainer?.viewContext else { return }
                let request = productList[indexPath.row]
                context.delete(request)
                do {
                    try context.save()
                    productList.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } catch {
                    print("Error: \(error)")
                
            }
        }
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
}
