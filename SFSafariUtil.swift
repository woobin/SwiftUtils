//
//  SFSafariUtil.swift
//
//  Created by 李 定祐 on 2017/01/20.
//

import UIKit
import SafariServices

class SFSafariUtil: NSObject, SFSafariViewControllerDelegate {

    class var shared: SFSafariUtil {
        struct Static {
            static let instance: SFSafariUtil = SFSafariUtil()
        }
        return Static.instance
    }
    private override init() {}


    func goSFSafari(caller: UIViewController, url: String) {
        let url = URL.init(string: url)!
        let brow = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        caller.present(brow, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        Log.debug("close")
    }
}
