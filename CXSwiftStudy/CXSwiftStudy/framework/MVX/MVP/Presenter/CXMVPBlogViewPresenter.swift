//
//  CXMVPBlogViewPresenter.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/21.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

protocol MVPBlogViewPresenterCallBack {
    
    func blogViewPresenter(success: Bool) -> Void
}


class CXMVPBlogViewPresenter: NSObject {
    var userId = 0
    
    var view: MVPBlogViewPresenterCallBack?
    
    var blogs: [CXMVPBlogCellPresenter] = []
    
    func fetchData() {
        var i = 1
        while i <= 20 {
            let blog = CXMVXBlog()
            
            blog.blog_title = "blogTitle\(i)"
            blog.blog_summary = "blogSummary\(i)"
            blog.blog_likeCount = Int(arc4random() % 100)
            
            self.blogs.append(CXMVPBlogCellPresenter(blog: blog))
            
            i += 1
        }
        
        self.view?.blogViewPresenter(success: true)
        
    }
}
