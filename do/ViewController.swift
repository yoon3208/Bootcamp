//
//  ViewController.swift
//  do
//
//  Created by SAMSUNG on 2024/02/22.
//

import UIKit

class ViewController: UIViewController {

    let friendNames: [String] = ["Henry","Leeo","Jay"]
    let koreanNames: [String: String] = ["Henry": "헨리","Leeo": "리이오","Jay": "제이"]
    var count: Int = 0
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var BestfriendLabel: UILabel!
    @IBOutlet weak var nextfriendLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func didTapButton(_ sender: Any) {
        let friendName = friendNames[count]
        nameLabel.text = friendNames[0]
        BestfriendLabel.text = friendNames[1]
        nextfriendLabel.text = friendNames[2]
    }
    
    
    
}

