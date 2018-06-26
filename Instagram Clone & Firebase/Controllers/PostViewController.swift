//
//  SecondViewController.swift
//  Instagram Clone & Firebase
//
//  Created by Coder ACJHP on 23.06.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageDownloadUrl: URL?
    var randomId = NSUUID().uuidString
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var commentField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add border to image container
        commentField.layer.borderWidth = 1
        commentField.layer.borderColor = UIColor.lightGray.cgColor
        
        imageContainer.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageContainer.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func pickImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageContainer.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "user")
            UserDefaults.standard.synchronize()
            print("OK")
        } catch {
            print(error.localizedDescription)
        }
        
        let loginPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: loginPage)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        var post = [String:String]()
        let randomId = NSUUID().uuidString
        let imagesFolder = Storage.storage().reference().child("images")
        //Convert image to data
        if let imageAsData = UIImageJPEGRepresentation(imageContainer.image!, 0.5) {
            imagesFolder.child("\(randomId).jpg").putData(imageAsData, metadata: nil) { (metaData, error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "Warning!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let dismissButton = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(dismissButton)
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    
                    // Create a reference to the file you want to download
                    let imagesRef = imagesFolder.child("\(randomId).jpg")
                    
                    // Fetch the download URL
                    imagesRef.downloadURL { url, error in
                        if let error = error {
                            print(error)
                        } else {
                            
                            guard let downloadUrl = url?.absoluteString else {return}
                            post = ["image": downloadUrl, "postedBy":(Auth.auth().currentUser?.email)!, "uuid": randomId, "postText":self.commentField.text]
                            Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
                            self.imageContainer.image = UIImage(named: "Select-image-bg.png")
                            self.commentField.text = ""
                            //Than return to stream tab
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                }
            }
        }
    }
    
}

