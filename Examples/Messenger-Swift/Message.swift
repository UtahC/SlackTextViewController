//
//  Message.swift
//  Messenger
//
//  Created by Intumit on 2016/12/23.
//  Copyright © 2016年 Slack Technologies, Inc. All rights reserved.
//

import Foundation

class Message {
    var user: User = .You
    var text: String!
}

enum User {
    case You, Robot
}
