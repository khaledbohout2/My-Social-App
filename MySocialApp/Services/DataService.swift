//
//  DatServices.swift
//  MySocialApp
//
//  Created by Khaled Bohout on 2/25/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

let DB_FireBase = Database.database().reference()
let DB_Storage = Storage.storage().reference()

class DataService {
    
    static let ds = DataService()
    //database references
    private var _Ref_Base  = DB_FireBase
    private var _Ref_Posts = DB_FireBase.child("posts")
    private var _Ref_Users = DB_FireBase.child("users")
    //storagereferences
    private var _ref_post_images = DB_Storage.child("posts-pics")
    
    var Ref_Base: DatabaseReference {
        return _Ref_Base
    }
    
    var Ref_Posts: DatabaseReference{
        return _Ref_Posts
    }
    var Ref_Users: DatabaseReference{
        return _Ref_Users
    }
    var Ref_User_Current : DatabaseReference{
        
        let uid = KeychainWrapper.standard.string(forKey:key_Uid)
        let user = Ref_Users.child(uid!)
        return user
    }
    
    var Ref_post_images: StorageReference{
        return _ref_post_images
    }
    
    func creatfirebaseDBuser(uid:String,userdata:Dictionary<String,String>){
        
        Ref_Users.child(uid).updateChildValues(userdata)
    }
    
    
}
