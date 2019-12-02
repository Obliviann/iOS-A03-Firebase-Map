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
        print("Login Button clicked!" )//self necessary ???                 //diff of user and AuthDataRsult ???
        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
        if(error==nil){
            self.performSegue(withIdentifier: "tranLoginSuccess", sender: self)
            print("User ",user," signed in")
        }else{
            print("ERROR EN LOGIN: ",error!)
            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        //self.performSegue(withIdentifier: "transSignUp", sender: self)
    }

}
