//
//  ViewController.swift
//  MySocialApp
//
//  Created by Khaled Bohout on 2/19/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignIn: UIViewController {
    
    @IBOutlet weak var emailfield: FancyField!
    @IBOutlet weak var passwordfield: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: key_Uid)
        {
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
    }

    @IBAction func facebookbuttontapped(_ sender: Any) {
        
       let facebooklogin = FBSDKLoginManager()
        
        facebooklogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("khaled: unable to authenticate with facebook- \(String(describing: error))")
            }
            else if result?.isCancelled == true {
                print("khaled: user cancelled authentication")
            }
            else {
                print("khaled: fasebook authenticated succesfully")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebasauth(credential)
            }
        }
        
   }
        
    func firebasauth(_ credential:AuthCredential){
        Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
            
            if error != nil {
                print("khaled: can not authenticate with firebase - \(String(describing: error))")
            }
            else{
                print("khaled: successfuly authenticated with firebase")
                
               if let user = user{
                let userdata = ["provider" :credential.provider]
                self.completesignin(id: user.user.uid,userdata: userdata)
                }
            }
        }
    }
    @IBAction func signinbuttontabbed(_ sender: Any) {
        
        if let email = emailfield.text,let pass = passwordfield.text{
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if error == nil{
                    print("khaled: email user authenticated successfully with firebase")
                    if let user = user{
                        let userdata = ["provider":user.user.providerID]
                        self.completesignin(id: user.user.uid,userdata: userdata)
                        
                    }
                }
                else{
                    Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                        if error == nil{
                            if let user = user{
                                let userdata = ["provider":user.user.providerID]
                                self.completesignin(id: user.user.uid,userdata: userdata)
                            }
                            print("khaled: successfuly created user")
                        }
                        else{
                            print("khaled:can not creat user")
                        }
                    })
                }
            }
        }
        
    }
    
    func completesignin(id:String,userdata: Dictionary<String, String>){
        
        DataService.ds.creatfirebaseDBuser(uid: id, userdata: userdata)
        KeychainWrapper.standard.set(id, forKey: key_Uid)
        performSegue(withIdentifier: "FeedVC", sender: nil)
    }
}

