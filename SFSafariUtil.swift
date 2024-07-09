//
//  SFSafariUtil.swift
//
//  Created by 李 定祐 on 2017/01/20.
//

import UIKit
import SafariServices

class SFSafariUtil: NSObject, SFSafariViewControllerDelegate {

    // シングルトンインスタンスの生成
    static let shared = SFSafariUtil()
    
    // プライベートイニシャライザ
    private override init() {}

    // SFSafariViewControllerを開くメソッド
    func openSafari(from viewController: UIViewController, urlString: String) {
        guard let url = URL(string: urlString) else {
            Log.debug("Invalid URL string: \(urlString)")
            return
        }
        
        let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        safariViewController.delegate = self
        viewController.present(safariViewController, animated: true, completion: nil)
    }
    
    // SFSafariViewControllerDelegateメソッド
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        Log.debug("SafariViewController closed")
    }
}
