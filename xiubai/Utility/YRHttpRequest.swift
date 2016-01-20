//
//  YRHttpRequest.swift
//  xiubai
//
//  Created by 陈伟浩 on 16/1/20.
//  Copyright © 2016年 陈伟浩. All rights reserved.
//

import UIKit
import Foundation

//class func connectionWithRequest(request: NSURLRequest!, delegate: AnyObject!) -> NSURLConnection!


class YRHttpRequest: NSObject {
    
    override init()
    {
        super.init();
    }
    
    class func requestWithURL(urlString:String,completionHandler:(data:AnyObject)->Void)
    {
        
        
        let URL = NSURL(string: urlString);
        
        let req = NSURLRequest(URL: URL!)
        let queue = NSOperationQueue();
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
            if (error != nil)
            {
                dispatch_async(dispatch_get_main_queue(),
                    {
                        print(error)
                        completionHandler(data:NSNull())
                })
            }
            else
            {
                let jsonData = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                
                dispatch_async(dispatch_get_main_queue(),
                    {
                        completionHandler(data:jsonData)
                        
                })
            }
        })
    }
    
    
    
}
