//
//  FirstViewController.swift
//  Instagram Clone & Firebase
//
//  Created by Coder ACJHP on 23.06.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
    var postCommentArray = [String]()
    var postUserArray = [String]()
    var postImageArray = [String]()
    
    @IBOutlet weak var dataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTable.delegate = self
        dataTable.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        postCommentArray.removeAll(keepingCapacity: false)
        postUserArray.removeAll(keepingCapacity: false)
        postImageArray.removeAll(keepingCapacity: false)
        populateDataTable()
    }
    
    func populateDataTable() {
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapShot) in
            let values = snapShot.value as! NSDictionary
            let post = values["post"] as! NSDictionary
            let postIdList = post.allKeys
            
            for id in postIdList {
                let singlePost = post[id] as! NSDictionary
                self.postCommentArray.append(singlePost["postText"] as! String)
                self.postUserArray.append(singlePost["postedBy"] as! String)
                self.postImageArray.append(singlePost["image"] as! String)
            }
            self.dataTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postUserArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SingleTableCell
        cell.imageContainer.sd_setImage(with: URL(string: self.postImageArray[indexPath.row]))
        cell.userNameField.text = postUserArray[indexPath.row]
        cell.commentField.text = postCommentArray[indexPath.row]
        return cell
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
    
}

