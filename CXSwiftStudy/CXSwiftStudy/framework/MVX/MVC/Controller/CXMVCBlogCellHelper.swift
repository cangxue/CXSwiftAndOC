//
//  CXMVCBlogCellHelper.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/18.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCBlogCellHelper: NSObject {
    
    var blog = CXMVCBlog()
    
    init(blog: CXMVCBlog) {
        self.blog = blog
    }
    
    func blogTitleText() -> String {
        return self.blog.blog_title.count > 0 ? self.blog.blog_title : "未命名"
    }
    
    func blogSummaryText() -> String {
        return self.blog.blog_summary.count > 0 ? "摘要: \(self.blog.blog_summary)" : "这个人很懒, 什么也没有写..."
    }
    
    func blogLikeCount() -> Int {
        return Int(arc4random() % 100)
    }

}
