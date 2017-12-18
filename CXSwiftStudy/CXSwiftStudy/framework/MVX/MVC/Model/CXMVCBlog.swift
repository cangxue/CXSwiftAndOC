//
//  CXMVCBlog.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/18.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCBlog: NSObject {
    var blog_title = "title"
    var blog_summary = "summary"
    
    init(blogId: Int) {
        super.init()
        self.blog_title = "blogTitle\(blogId)"
        self.blog_summary = "blogSummary\(blogId)"
    }
}
