//
//  MyviewViewController.swift
//  do
//
//  Created by SAMSUNG on 2024/02/26.
//

import UIKit

class MyviewViewController: UIViewController, Table {
    
    @IBOutlet weak var MytableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MytableView.backgroundColor = .blue
        
    }
}

