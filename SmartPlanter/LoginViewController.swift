//
//  LoginViewController.swift
//  SmartPlanter
//
//  Created by Harri on 5/15/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var planterId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didClickSignIn(_ sender: Any) {
        let alertControler = UIAlertController(title: "Error", message: "Planter id is not correct", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertControler.addAction(alertAction)
        self.present(alertControler, animated: true, completion: nil)
        
       // self.present(, animated: , completion: )
    
        
    }
    
}
