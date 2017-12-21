//
//  CXMVPBlogViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/21.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVPBlogViewController: NSObject, UITableViewDataSource, UITableViewDelegate, MVPBlogViewPresenterCallBack {
    
    var tableView: UITableView?
    
    var presenter = CXMVPBlogViewPresenter()
    
    override init() {
        super.init()
        
        self.tableView = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        self.tableView?.register(UINib.init(nibName: "CXMVXBlogTableViewCell", bundle: nil), forCellReuseIdentifier: "CXMVXBlogTableViewCellID")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CXMVXBlogTableViewCellID") as! CXMVXBlogTableViewCell
        
        let cellPresenter = self.presenter.blogs[indexPath.row]
        
        cell.blog_titleLabel.text = cellPresenter.blogTitleText()
        cell.blog_summaryLabel.text = cellPresenter.blogSummaryText()
        cell.lickBtn.setTitle("赞\(cellPresenter.blogLikeCount())", for: .normal)
        cell.likeBlock = {(success: Bool) -> (Int) in
            if success {
                print("点赞了")
            }
            
            return (cellPresenter.blogLikeCount() + 1)
        }
        return cell
    }
    
    //MARK: presenter callback
    func blogViewPresenter(success: Bool) {
        if success {
            self.tableView?.reloadData()
        }
    }

}
