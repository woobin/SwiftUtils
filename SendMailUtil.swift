//
//  SendMailUtil.swift
//
//  Created by 李 定祐 on 2017/02/09.
//

import UIKit
import MessageUI

class SendMailUtil: NSObject, MFMailComposeViewControllerDelegate {
    
    // シングルトンインスタンスの生成
    static let shared = SendMailUtil()
    
    // プライベートイニシャライザ
    private override init() {}

    private weak var opener: UIViewController?

    // フィードバックメールを送信するメソッド
    func sendFeedback(from viewController: UIViewController) {
        guard MFMailComposeViewController.canSendMail() else {
            ViewUtil.shared.showAlert(message: "メール設定確認のお願い！", actionTitles: ["はい"], actions: nil)
            return
        }
        
        self.opener = viewController
        
        let mailComposeVC = createMailComposeViewController()
        
        viewController.present(mailComposeVC, animated: true, completion: nil)
    }

    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        handleMailComposeResult(result, error: error)
        opener?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - プライベートメソッド
    
    private func createMailComposeViewController() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        let recipients = ["***@***.com"]
        
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setSubject("タイトル")
        mailComposeVC.setToRecipients(recipients)
        mailComposeVC.setMessageBody(createFeedbackMessage(), isHTML: false)
        
        return mailComposeVC
    }
    
    private func handleMailComposeResult(_ result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("メール送信がキャンセルされました")
        case .saved:
            print("メールが保存されました")
        case .sent:
            ViewUtil.shared.showAlert(message: "送信しました！", actionTitles: ["確認"], actions: nil)
        case .failed:
            var message = "送信に失敗しました！"
            if let errorDescription = error?.localizedDescription, !errorDescription.isEmpty {
                message.append("\n\(errorDescription)")
            }
            ViewUtil.shared.showAlert(message: message, actionTitles: ["確認"], actions: nil)
        @unknown default:
            fatalError("予期しないケースです")
        }
    }
    
    private func createFeedbackMessage() -> String {
        let device = UIDevice.current
        let bundle = Bundle.main
        let locale = Locale.current.identifier
        let appName = bundle.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "アプリ名不明"
        let appVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? "バージョン不明"

        let appInfo = "\n\(appName) \(appVersion)\n\(device.systemName) \(device.systemVersion)\n\(device.model), \(locale)"
        let message = "何か書きます。\n\n\n\n\n+---------------+\(appInfo)\n+---------------+"
        
        return message
    }
}
