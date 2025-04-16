//
//  WelcomeViewController.swift
//  ChatApp
//
//  Created by Mehmet  Demir on 10.04.2025.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text , let password = passwordTextfield.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: C.loginSegue, sender: self)
                }
                
            }
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        
    }
    
}




