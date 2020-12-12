//
//  ViewController.swift
//  Delegate (объясняет Акулов Иван)
//
//  Created by Сергей Голенко on 04.08.2020.
//  Copyright © 2020 Сергей Голенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SecondViewControllerDelegate {
    
    func fillTheLabelWith(info: String) {
        myLabel.text = info
    }
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getDataSegue"{
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func goTo2VCPressed(_ sender: Any) {
    }
}

