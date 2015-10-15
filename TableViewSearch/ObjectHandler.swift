//
//  GreetingObjectHandler.swift
//  searchShit
//
//  Created by Satnam Sync on 24/08/15.
//  Copyright (c) 2015 Satnam Sync. All rights reserved.
//

import Foundation

class GreetingObjectHandler {
    var greetings: [Greeting] = []
    
    init(filename: String) {
        //TODO: Nil entry is causing application to crash
                //subtract self
        
        let filePath = NSURL(string: "http://serv.vigasdeep.com:2403/postedjob")
        let jsonData = NSData(contentsOfURL:filePath!)
        let json = JSON(data: jsonData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        
        for (key, subJson): (String, JSON) in json {
            
            var language:String?, link: String?, description:String?, greetingText: String?
            
            for (key1, value): (String, JSON) in subJson {
                switch key1 {
                case "briefDes": language = value.string
                case "userId": link = value.string
                case "skill": description = value.string
                case "jobDetail": greetingText = value.string
                default: break
                }
            }
            
            let greeting = Greeting(language: language, link: link, description: description, greetingText: greetingText)
            self.greetings.append(greeting)
            //self.greetings = self.greetings.filter { $0.link != "\(id)"}

        }
    }
    
    func getGreetingsAsAnyObjects() -> [String: [AnyObject]]{
        
        return [Constant.GreetingOBJHandlerSectionKey: greetings.map { $0 as AnyObject }]
    }
}

struct Constant {
    static let GreetingNewViewControllerCell = "coCell"
    static let GreetingNewViewControllerSegue = "showGreetingDetail"
    static let GreetingJSONFileName = "greetings"
    static let GreetingOBJHandlerSectionKey = "section0"
}
