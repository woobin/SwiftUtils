//
//  Log.swift
//
//  Created by 李 定祐 on 2017/02/03.
//

import UIKit

class Log: NSObject {
    
    static func debug(_ obj: Any?,
                      function: String = #function,
                      line: Int = #line,
                      file: String = #file) {
#if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let logPrefix = "[\(fileName):\(function) - Line:\(line)]"
        
        if let obj = obj {
            print(logPrefix)
            debugPrint(obj)
        } else {
            print("\(logPrefix) nil")
        }
#endif
    }
}
