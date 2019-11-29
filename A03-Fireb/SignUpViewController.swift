//
//  SignUpViewController.swift
//  A03-Fireb
//
//  Created by Olivia Sartorius Freschet on 29/11/19.
//  Copyright © 2019 Olivia. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passConfirm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        //self.performSegue(withIdentifier: "transCancel", sender: self)
    }
    
    @IBAction func CreateAccountButton(_ sender: Any) {
        if (password.text != passConfirm.text) {
            let alertController = UIAlertController(title: "Password does not match", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            //Create new user - store data in Firebase
            //FIRAuth : clase estática de la API FirebaseAuth
            //auth() : objeto dentro de dicha clase estática
            //createUser() : método del objeto auth()
            //(dos parámetros de entrada) + { (dos outputs-objeto user con toda la info y error) }
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    //self.performSegue(withIdentifier: "transGoSignUp", sender: self)
                    //self.dismissViewControllerAnimated(true, completion: nil) FROM INTERNET
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
                    self.present(vc!, animated: true, completion: nil)
                    print("USER created")
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
