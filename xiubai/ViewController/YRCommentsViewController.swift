//
//  YRCommentsViewController.swift
//  xiubai
//
//  Created by 陈伟浩 on 16/1/20.
//  Copyright © 2016年 陈伟浩. All rights reserved.
//

import UIKit

class YRCommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,YRRefreshViewDelegate {
    
    let identifier = "cell"
    var jokeType:YRJokeTableViewControllerType = .HotJoke
    var tableView:UITableView?
    var dataArray = NSMutableArray()
    var page :Int = 1
    var refreshView:YRRefreshView?
    var jokeId:String!
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "评论"
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func setupViews()
    {
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        self.tableView = UITableView(frame:CGRectMake(0,0,width,height))
        self.tableView!.delegate = self;
        self.tableView!.dataSource = self;
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        let nib = UINib(nibName:"YRCommnentsCell", bundle: nil)
        
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
        
        var arr =  NSBundle.mainBundle().loadNibNamed("YRRefreshView" ,owner: self, options: nil) as Array
        self.refreshView = arr[0] as? YRRefreshView
        self.refreshView!.delegate = self
        
        self.tableView!.tableFooterView = self.refreshView
        self.view.addSubview(self.tableView!)
    }
    
    func loadData()
    {
        let url = "http://m2.qiushibaike.com/article/\(self.jokeId)/comments?count=20&page=\(self.page)"
        self.refreshView!.startLoading()
        YRHttpRequest.requestWithURL(url,completionHandler:{ data in
            
            if data as! NSObject == NSNull()
            {
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            
            let arr = data["items"] as! NSArray
            if arr.count  == 0
            {
                UIView.showAlertView("提示",message:"暂无新评论哦")
                self.tableView!.tableFooterView = nil
            }
            for data : AnyObject  in arr
            {
                self.dataArray.addObject(data)
            }
            self.tableView!.reloadData()
            self.refreshView!.stopLoading()
            self.page++
        })
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count;
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? YRCommentsCell
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        cell!.data  = data
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        return  YRCommentsCell.cellHeightByData(data)
    }
    
    
    func refreshView(refreshView:YRRefreshView,didClickButton btn:UIButton)
    {
        //refreshView.startLoading()
        loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
