
//
//  CXObjectMapperViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/4/11.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import ObjectMapper

class CXObjectMapperViewController: CXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonString = """
        {
            "username": "",
            "age": 10,
            "friend": { "image": "back", "nickname": "It is good, read it"},
        }
        """
        
        let user = ObjectMapper_User(JSONString: jsonString)
        
        print(user?.friend.nickname)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

class ObjectMapper_User: Mappable {
    
    var username: String?
    var age: Int?
    var friend: ObjectMapper_friend
    
    required init?(map: Map) {
        self.friend = ObjectMapper_friend(map: map)!
    }
    
    //Mappable
    func mapping(map: Map) {
        username   <- map["username"]
        age        <- map["age"]
        friend     <- map["friend"]
    }
}

class ObjectMapper_friend: Mappable {
    
    var avatar: String?
    var nickname: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        avatar <- map["image"]
        nickname <- map["nickname"]
    }
    
    
}
