//
//  SignUpViewController.swift
//  Instagram Clone & Firebase
//
//  Created by Coder ACJHP on 23.06.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        if emailtextField.text != "" && passwordtextField.text != "" {
            Auth.auth().createUser(withEmail: emailtextField.text!, password: passwordtextField.text!) { (authDataResult, error) in
                
                //Check the error
                if error != nil {
                    
                    let alert = UIAlertController(title: "Error!", message:  error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let dismissButton = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(dismissButton)
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "Success!", message: "Great work! Your account created successfully", preferredStyle: UIAlertControllerStyle.alert)
                    let goToLogin = UIAlertAction(title: "Go to login page", style: UIAlertActionStyle.default, handler: { (alertAction) in
                        self.performSegue(withIdentifier: "toLoginPage", sender: nil)
                    })
                    alert.addAction(goToLogin)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Warning!", message: "Email and password cannot be empty!", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
