//
//  FeedVC.swift
//  MySocialApp
//
//  Created by Khaled Bohout on 2/23/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import FirebaseDatabase

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var posts = [Post]()

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
       DataService.ds.Ref_Posts.observe(.value,with: { (snapshot) in
        
        if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
            for snap in snapshot{
                if let postdict = snap.value as? Dictionary<String,AnyObject>{
                    let key = snap.key
                    let post = Post(postkey: key, postdata: postdict)
                    self.posts.append(post)
                }
            }
        }
        self.tableview.reloadData()
        })

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (tableview.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell)!
    }
    


    @IBAction func signoutbuttontapped(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: key_Uid)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "SignOut", sender: nil)
        
        
    }
}
