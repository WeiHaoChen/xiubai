//
//  YRCommentsCell.swift
//  xiubai
//
//  Created by 陈伟浩 on 16/1/20.
//  Copyright © 2016年 陈伟浩. All rights reserved.
//

import UIKit

class YRCommentsCell: UITableViewCell {
    @IBOutlet var avatarView: UIImageView?
    @IBOutlet var nickLabel: UILabel?
    @IBOutlet var floorLabel: UILabel?
    @IBOutlet var contentLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    
    var data: NSDictionary!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let user: AnyObject! = self.data["user"]
        if user as! NSObject != NSNull()
        {
            let userDict = user as! NSDictionary
            self.nickLabel!.text = userDict["login"] as! NSString as String
            let icon : AnyObject! = userDict["icon"]
            if icon as! NSObject != NSNull()
            {
                let userIcon = icon as! String
                let userId =  userDict.stringAttributeForKey("id") as NSString;
                let prefixUserId = userId.substringToIndex(3)
                let userImageURL = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userId)/thumb/\(userIcon)"
                self.avatarView!.setImage(userImageURL,placeHolder: UIImage(named: "avatar.jpg"))
            }
            else
            {
                self.avatarView!.image =  UIImage(named: "avatar.jpg")
            }
            
            let timeStamp = userDict.stringAttributeForKey("created_at")
            let date = timeStamp.dateStringFromTimestamp(timeStamp)
            self.dateLabel!.text = date
        }
            else
            {
                self.nickLabel!.text = "匿名"
                self.avatarView!.image =  UIImage(named: "avatar.jpg")
                self.dateLabel!.text = ""
                
            }
            let content = self.data.stringAttributeForKey("content")
            let height = content.stringHeightWith(17,width:300)
            self.contentLabel!.setHeight(height)
            self.contentLabel!.text = content
            self.dateLabel!.setY(self.contentLabel!.bottom())
            let floor = self.data.stringAttributeForKey("floor")
            self.floorLabel!.text = "\(floor)楼"
        }
        
        class func cellHeightByData(data:NSDictionary)->CGFloat
        {
            let content = data.stringAttributeForKey("content")
            let height = content.stringHeightWith(17,width:300)
            return 53.0 + height + 24.0
        }
}

        
        

