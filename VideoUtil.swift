//
//  VideoUtil.swift
//
//  Created by 李 定祐 on 2016/12/21.
//

import UIKit
import AVKit
import AVFoundation

class VideoUtil: NSObject {
    
    // シングルトンインスタンスの生成
    static let shared = VideoUtil()
    
    // プライベートイニシャライザ
    private override init() {}
    
    // ビデオを再生する関数
    func play(caller: UIViewController, urlString: String) {
        guard let url = URL(string: urlString) else {
            Log.debug("Invalid URL string: \(urlString)")
            return
        }
        
        let videoPlayer = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        playerController.player = videoPlayer
        caller.present(playerController, animated: true) {
            videoPlayer.play()
        }
    }
}
