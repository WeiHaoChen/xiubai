//
//  YRRefreshView.swift
//  xiubai
//
//  Created by 陈伟浩 on 16/1/20.
//  Copyright © 2016年 陈伟浩. All rights reserved.
//

import UIKit

protocol YRRefreshViewDelegate
{
    func refreshView(refreshView:YRRefreshView,didClickButton btn:UIButton)
}

class YRRefreshView: UIView {
    @IBOutlet var button: UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    @IBAction func buttonClicked(sender: UIButton) {
        self.delegate.refreshView(self,didClickButton:sender)
    }
    
    var delegate :YRRefreshViewDelegate!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.indicator!.hidden = true
        
    }
    
    func startLoading()
    {
        self.button!.setTitle("", forState: .Normal)
        self.indicator!.hidden = false
        self.indicator!.startAnimating()
    }
    
    func stopLoading()
    {
        self.button!.setTitle("点击加载更多", forState: .Normal)
        self.indicator!.hidden = true
        self.indicator!.stopAnimating()
    }

}