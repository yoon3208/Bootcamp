//
//  ViewController.swift
//  MyFile
//
//  Created by SAMSUNG on 2024/02/19.
//

import UIKit

class ViewController: UIViewController {

    let friendNames: [String] = ["Henry","Leeo","Lucy"]
    var count: Int = 0
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func didTapButton(_ sender: Any) {
        nameLabel.text = "Hello!"
        
    }
}

