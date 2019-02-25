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

let DB_FireBase = Database.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _Ref_Base  = DB_FireBase
    private var _Ref_Posts = DB_FireBase.child("posts")
    private var _Ref_Users = DB_FireBase.child("users")
    
    var Ref_Base: DatabaseReference {
        return _Ref_Base
    }
    
    var Ref_Posts: DatabaseReference{
        return _Ref_Posts
    }
    var Ref_Users: DatabaseReference{
        return _Ref_Users
    }
    
    func creatfirebaseDBuser(uid:String,userdata:Dictionary<String,String>){
        
        Ref_Users.child(uid).updateChildValues(userdata)
    }
    
    
}
