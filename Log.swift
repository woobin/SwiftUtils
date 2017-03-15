//
//  Log.swift
//
//  Created by 李 定祐 on 2017/02/03.
//

import UIKit

class Log: NSObject {

    static func debug(_ obj: Any?,
                         function: String = #function,
                         line: Int = #line) {
        #if DEBUG
            if let obj = obj {
                print("[function:\(function)-\(line):]")
                debugPrint(obj)
            } else {
                print("[function:\(function)-\(line)]")
            }
        #endif
    }

}
