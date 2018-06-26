import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if emailtextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailtextField.text!, password: passwordTextField.text!) { (autResult, error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "Error!", message:  error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let dismissButton = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(dismissButton)
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    UserDefaults.standard.set(autResult?.user.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberLogin()
                }
            }
        } else {
            let alert = UIAlertController(title: "Warning!", message: "Email and password cannot be empty!", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func forgotPassButtonClicked(_ sender: UIButton) {
        print("Forgot password clicked!")
    }
    
}
