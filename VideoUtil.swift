//
//  VideoUtil.swift
//
//  Created by 李 定祐 on 2016/12/21.
//

import UIKit
import AVKit
import AVFoundation

class VideoUtil: NSObject {

    class var shared: VideoUtil {
        struct Static {
            static let instance: VideoUtil = VideoUtil()
        }
        return Static.instance
    }
    private override init() {}

    func play(caller: UIViewController, urlString: String) {
        if let url = URL(string: urlString) {
            
            let videoPlayer = AVPlayer(url: url)
            let playerController = AVPlayerViewController()
            playerController.player = videoPlayer
            caller.present(playerController, animated: true, completion: {
                videoPlayer.play()
            })
            
        } else {
            Log.debug("no such file")
        }
    
    }
}
