//
//  SendMailUtil.swift
//
//  Created by 李 定祐 on 2017/02/09.
//

import UIKit
import MessageUI

class SendMailUtil: NSObject, MFMailComposeViewControllerDelegate {
    
    class var shared : SendMailUtil {
        struct Static {
            static let instance : SendMailUtil = SendMailUtil()
        }
        return Static.instance
    }
    private override init() {}

    var opener: UIViewController?

    func sendFeedBack(opener: UIViewController) {
        if MFMailComposeViewController.canSendMail()==false {
            ViewUtil.shared.showAlert(message: "メール設定確認のお願い！",  actionTitles: ["はい"], actions: nil)
            return
        }
        self.opener = nil
        self.opener = opener
        
        let mailCompose = MFMailComposeViewController()
        let destination = ["***@***.com"]
        
        mailCompose.mailComposeDelegate = self
        mailCompose.setSubject("タイトル")
        mailCompose.setToRecipients(destination)
        
        mailCompose.setMessageBody(self.getMessageFeedback(), isHTML: false)
        self.opener?.present(mailCompose, animated: true, completion: nil)
    }

    
    //MARK: MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            ViewUtil.shared.showAlert(message: "送信した！", actionTitles: ["確認"], actions: nil)
            break
        case .failed:
            var message = "失敗した！"
            if let err: String = error?.localizedDescription, err.count() > 0 {
                message.append("\n")
                message.append(err)
            }
            ViewUtil.shared.showAlert(message: message, actionTitles: ["確認"], actions: nil)
            break
        }
        self.opener?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Create Message
    private func getMessageFeedback() -> String {

        let dc = UIDevice.current
        let bd = Bundle.main
        let lc = Locale.current.identifier
        let name = bd.object(forInfoDictionaryKey: "CFBundleName")
        let appInfo  = "\n \(name!) \(bd.appVersion)\n \(dc.systemName) \(dc.systemVersion)\n \(dc.model), \(lc)"

        let message = "何か書きます。\n\n\n\n\n+---------------+\(appInfo)\n+---------------+"
    
        return message
    }

    
}
