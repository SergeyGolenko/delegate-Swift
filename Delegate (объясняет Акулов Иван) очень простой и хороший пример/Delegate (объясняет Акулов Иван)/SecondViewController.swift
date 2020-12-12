//
//  SecondViewController.swift
//  Delegate (объясняет Акулов Иван)
//
//  Created by Сергей Голенко on 04.08.2020.
//  Copyright © 2020 Сергей Голенко. All rights reserved.
//

import UIKit



protocol SecondViewControllerDelegate{
    func fillTheLabelWith(info: String)
}

class SecondViewController: UIViewController {
    
    
 
    var delegate: SecondViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    var text = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func sendDataPressed(_ sender: UIButton) {
        text = textField.text!
        delegate?.fillTheLabelWith(info:text)
        navigationController?.popViewController(animated: true)
    }
    
}
