//
//  Post.swift
//  MySocialApp
//
//  Created by Khaled Bohout on 2/25/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _caption:String!
    private var _imageurl:String!
    private var _likes:Int!
    private var _postkey:String!
    private var _post_Ref:DatabaseReference?
    
    var caption:String {
        return _caption
    }
    var imageurl:String{
        return _imageurl
    }
    var likes:Int{
        return _likes
    }
    var postkey:String{
        return _postkey
    }

    
    init(caption:String,imageurl:String,likes:Int) {
        self._caption = caption
        self._imageurl = imageurl
        self._likes = likes
    }
    
    init(postkey:String,postdata:Dictionary<String,AnyObject>) {
        self._postkey = postkey
        
        if let caption = postdata["caption"]as?String{
            self._caption = caption
        }
        if let imageurl = postdata["imageurl"]as?String{
            self._imageurl = imageurl
        }
        if let likes = postdata["likes"]as?Int{
            self._likes = likes
        }
        _post_Ref = DataService.ds.Ref_Posts.child(postkey)
    }
    
    func adjustlike(addlike:Bool){
        if addlike {
            _likes = _likes + 1
        }
        else{
            _likes = _likes - 1
        }
        _post_Ref!.child("likes").setValue(_likes)
    }
}
