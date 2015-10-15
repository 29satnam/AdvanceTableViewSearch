//
//  Greeting.swift
//  searchShit
//
//  Created by Satnam Sync on 24/08/15.
//  Copyright (c) 2015 Satnam Sync. All rights reserved.
//

class Greeting {
    var language: String!
    var link : String!
    var description: String!
    var  greetingText: String!
    
    init(language: String?, link: String?, description: String?, greetingText: String?) {
        self.language = language
        self.link = link
        self.description = description
        self.greetingText = greetingText
    }
}