//
//  CXCodableViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/4/10.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

class CXCodableViewController: CXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let jsonString = """
        {
            "title": "10",
            "frontCover": { "image": "back", "text": "It is good, read it"}

        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            return
        }
        
        let decoder = JSONDecoder()
        
        let obj = try! decoder.decode(Book.self, from: jsonData)
        
        print(obj.title)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

struct BookCover: Codable {
    var text: String = ""
    var image: String = ""
    
    enum CodingKeys: String, CodingKey {
        case text
        case image
    }
    
}


struct Book: Codable {
    
    var title: String = ""
    var frontCover: BookCover?
    var backCover: BookCover?
}

extension BookCover: JSONEmptyRepresentable {

    typealias CodingKeyType = BookCover.CodingKeys
}


//extension Book {
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        if container.allKeys.isEmpty {
//            title = "nil"
//        } else {
//            title = try container.decode(String.self, forKey: .title)
//        }
//    }
//}



public protocol JSONEmptyRepresentable {

    associatedtype CodingKeyType: CodingKey
}

//extension KeyedDecodingContainer {
//
//    public func decodeIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T : Decodable {
//        if contains(key) {
//            let container = try nestedContainer(keyedBy: CodingKey.Protocol, forKey: key)
//            print("11111")
//        } else {
//            print("2222")
//            return nil
//        }
//
//        return try decode(T.self, forKey: key)
//    }
//
//}
//
//
//public protocol JSONBlankRepresentable: RawRepresentable {
//
//}
//
//extension KeyedDecodingContainer {
//
//}


