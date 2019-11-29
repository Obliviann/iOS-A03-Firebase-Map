//
//  ViewController.swift
//  A03-Fireb
//
//  Created by Olivia Sartorius Freschet on 17/10/19.
//  Copyright © 2019 Olivia. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    //1. create vars
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //TODO: crear un usuario nuevo : createUser()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //1. create action
    @IBAction func LoginButon(_ sender: UIButton) {
        print("Login Button clicked!" )

    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        //self.performSegue(withIdentifier: "transSignUp", sender: self)
    }

}
