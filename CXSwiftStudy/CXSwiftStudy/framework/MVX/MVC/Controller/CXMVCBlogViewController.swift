//
//  CXMVCBlogViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/18.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCBlogViewController: NSObject, UITableViewDelegate, UITableViewDataSource {
    var userId = 0
    var tableView: UITableView?
    var blogs: [CXMVCBlogCellHelper] = []
    
    override init() {
        super.init()
        self.tableView = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        self.tableView?.register(UINib.init(nibName: "CXMVCBlogTableViewCell", bundle: nil), forCellReuseIdentifier: "CXMVCBlogTableViewCellID")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CXMVCBlogTableViewCellID") as! CXMVCBlogTableViewCell
        let blogHelper = self.blogs[indexPath.row]
        cell.blog_titleLabel.text = blogHelper.blogTitleText()
        cell.blog_summaryLabel.text = blogHelper.blogSummaryText()
        cell.lickBtn.setTitle("赞\(blogHelper.blogLikeCount())", for: .normal)
        return cell
    }
    
    func fetchDataWithCompletionHandler(userId: NSInteger, completion: @escaping (_ userId: NSInteger, _ success: Bool) -> Void) {
        self.userId = userId
    
        var i = 1
        while i <= 20 {
            let blog = CXMVCBlog.init(blogId: i)
            
            self.blogs.append(CXMVCBlogCellHelper(blog: blog))
            
            i += 1
        }
        
        self.tableView?.reloadData()
        completion(userId, true)
    }

}
