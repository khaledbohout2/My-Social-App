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

class SignIn: UIViewController {
    
    @IBOutlet weak var emailfield: FancyField!
    @IBOutlet weak var passwordfield: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        Auth.auth().signInAndRetrieveData(with: credential) { (result, error) in
            
            if error != nil {
                print("khaled: can not authenticate with firebase - \(String(describing: error))")
            }
            else{
                print("khaled: successfuly authenticated with firebase")
            }
        }
    }
    @IBAction func signinbuttontabbed(_ sender: Any) {
        
        if let email = emailfield.text,let pass = passwordfield.text{
            Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
                if error == nil{
                    print("khaled: email user authenticated successfully with firebase")
                }
                else{
                    Auth.auth().createUser(withEmail: email, password: pass, completion: { (rsult, error) in
                        if error == nil{
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
}

