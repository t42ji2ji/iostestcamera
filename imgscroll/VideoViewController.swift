//
//  VideoViewController.swift
//  imgscroll
//
//  Created by 謝忠穎 on 2017/6/29.
//  Copyright © 2017年 謝忠穎. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
 
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    var secc :UIScrollView!
    private var videoURL: URL
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    var fullscreen : CGRect?
    var blackview :UIView?
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullscreen = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)

        self.view.backgroundColor = UIColor.gray
        player = AVPlayer(url: videoURL)
        playerController = AVPlayerViewController()
        
        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false
        
        playerController!.player = player!
        self.addChildViewController(playerController!)
        self.view.addSubview(playerController!.view)
        playerController!.view.frame = view.frame
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
        
        scrollviewInit()
        
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        let stickerButton = UIButton(frame: CGRect(x: (fullscreen?.width)! - 40, y: 10.0, width: 30.0, height: 30.0))
        stickerButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        stickerButton.addTarget(self, action: #selector(addstickerView), for: .touchUpInside)
        
        view.addSubview(stickerButton)
        view.addSubview(cancelButton)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: kCMTimeZero)
            self.player!.play()
        }
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func addstickerView(){
        
        blackview  = UIView(frame: fullscreen!)
        blackview?.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackview?.isUserInteractionEnabled = true
        blackview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
        
        self.view.addSubview(blackview!)
        
        UIView.animate(withDuration: 3, animations: {
            self.blackview?.alpha = 1
        })

    }
    
    func dismissMenu(){
        print("dismiss")
        UIView.animate(withDuration: 0.5, animations: {
            self.blackview?.alpha = 0
        })

    }
    
    func scrollviewInit(){
        
        
        secc = UIScrollView()
        secc.frame = CGRect(x: 0, y: 0, width: (fullscreen?.width)!, height: (fullscreen?.height)!)
        secc.delegate = self as? UIScrollViewDelegate
        secc.isPagingEnabled = true
        secc.contentSize = CGSize(width: (fullscreen?.width)!*2, height: (fullscreen?.height)!)
        secc.showsHorizontalScrollIndicator = false
        secc.showsVerticalScrollIndicator = false
        
        let secondscreen = CGRect(x: self.view.bounds.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        let color = UIView(frame: fullscreen!)
        color.backgroundColor = UIColor.blue
        color.alpha = 0.4
        
        let color2 = UIView(frame: secondscreen)
        color2.layer.addSublayer(createGradient(colorTop: UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 0.2).cgColor
            , colorBotton: UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 0.8).cgColor))


        
        secc.addSubview(color)
        secc.addSubview(color2)

        
        self.view.addSubview(secc)
    }
    
    func createGradient(colorTop: CGColor, colorBotton: CGColor) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.colors = [colorTop, colorBotton]
        gradient.locations = [0.0 ,1.0]
        gradient.frame = fullscreen!
        
        return gradient

    }
    
}
