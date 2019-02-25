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

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
       DataService.ds.Ref_Posts.observe(.value,with: { (SnapShot) in
        
        print(SnapShot.value!)
        })

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
