//
//  WelcomeViewController.swift
//  ChatApp
//
//  Created by Mehmet  Demir on 10.04.2025.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text , let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    //navigate to the ChatViewController
                    self.performSegue(withIdentifier: C.registerSegue, sender: self)
                }
            }
        }
    }
}
