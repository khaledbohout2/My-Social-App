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

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var posts = [Post]()
    var imagepicker:UIImagePickerController!
    static var imagecash: NSCache<NSString,UIImage> = NSCache()

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var imageadd: circleimage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        imagepicker = UIImagePickerController()
        imagepicker.allowsEditing = true
        imagepicker.delegate = self
        
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
        let post = posts[indexPath.row]
        if let cell = tableview.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell{
            
            if let img =  FeedVC.imagecash.object(forKey: post.imageurl as NSString){
                cell.configurecell(post: post,img : img)
                return cell
        }
            else{
                cell.configurecell(post: post)
                return cell
            }
            
            
        }
        else{
            return PostCell()
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage]as? UIImage {
            imageadd.image = image
        }
        else{
            print("khaled: no valid image has selected")
        }
        imagepicker.dismiss(animated: true, completion: nil)
    }
    


    @IBAction func signoutbuttontapped(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: key_Uid)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "SignOut", sender: nil)
        
        
    }
    @IBAction func addimagetapped(_ sender: Any) {
        
        present(imagepicker, animated: true, completion: nil)
    }
    
}
