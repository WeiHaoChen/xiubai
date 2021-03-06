//
//  UIImageViewWebExt.swift
//  xiubai
//
//  Created by 陈伟浩 on 16/1/20.
//  Copyright © 2016年 陈伟浩. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView
{
    func setImage(urlString:String,placeHolder:UIImage!)
    {
        
        let url = NSURL(string: urlString)
        let cacheFilename = url!.lastPathComponent
        let cachePath = FileUtility.cachePath(cacheFilename!)
        let image : AnyObject = FileUtility.imageDataFromPath(cachePath)
        //  println(cachePath)
        if image as! NSObject != NSNull()
        {
            self.image = image as? UIImage
        }
        else
        {
            let req = NSURLRequest(URL: url!)
            let queue = NSOperationQueue();
            NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
                if (error != nil)
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            print(error)
                            self.image = placeHolder
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            
                            let image = UIImage(data: data!)
                            if (image == nil)
                            {
                                let jsonData = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                                
                                if let _:String? = jsonData["error"] as? String {
                                    //println("\(err)")
                                    print("url fail=\(urlString)");
                                }
                                //println("img is nil,path=\(cachePath)")
                                self.image = placeHolder
                            }
                            else
                            {
                                self.image = image
                                let bIsSuccess = FileUtility.imageCacheToPath(cachePath,image:data!)
                                if !bIsSuccess
                                {
                                    print("*******cache fail,path=\(cachePath)")
                                }
                            }
                    })
                }
            })
            
        }
        
    }
}



