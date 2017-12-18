//
//  CXMVCBlogTableViewCell.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/18.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCBlogTableViewCell: UITableViewCell {

    @IBOutlet weak var blog_titleLabel: UILabel!
    @IBOutlet weak var blog_summaryLabel: UILabel!
    @IBOutlet weak var lickBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeBtnClick(_ sender: Any) {
    }
}
