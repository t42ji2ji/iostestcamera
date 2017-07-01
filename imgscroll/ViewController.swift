//
//  ViewController.swift
//  imgscroll
//
//  Created by 謝忠穎 on 2017/6/28.
//  Copyright © 2017年 謝忠穎. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    

    var camera = UIButton()

    var imageArray = [UIImage]()
    var fullscreen :CGRect!
    var secc :UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        camera = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2 - 50, y:self.view.frame.size.height / 2 - 50), size: CGSize(width: 100, height: 100)))
        camera.layer.cornerRadius = 5
        camera.layer.borderWidth = 1
        camera.layer.borderColor = UIColor.black.cgColor
        camera.backgroundColor = UIColor.black
        camera.setTitle("Camera", for: .normal)

        camera.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        scrollviewInit()
        self.view.addSubview(camera)
        
        imageArray = [#imageLiteral(resourceName: "bossfight-free-stock-photos-sea-ocean-water-beach-rocks"), #imageLiteral(resourceName: "Group"), #imageLiteral(resourceName: "bossfight-free-stock-photos-dog-coyote-pup-black-trees-grass")]
       

//        for i in 0..<imageArray.count{
//            let imageView = UIImageView()
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = imageArray[i]
//            let xPosition = self.view.frame.width * CGFloat(i)
//            imageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            
//            stickerScrollview.contentSize.width = self.view.frame.width * CGFloat(i + 1)
//            stickerScrollview.addSubview(imageView)
//         }
    }
    

    func scrollviewInit(){
        
        fullscreen = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)

        secc = UIScrollView()
        secc.frame = CGRect(x: 0, y: 0, width: fullscreen.width, height: fullscreen.height)
        secc.delegate = self as? UIScrollViewDelegate
        secc.isPagingEnabled = true
        secc.contentSize = CGSize(width: fullscreen.width*2, height: fullscreen.height)
        secc.showsHorizontalScrollIndicator = false
        secc.showsVerticalScrollIndicator = false
        
        let secondscreen = CGRect(x: self.view.bounds.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        let color = UIView(frame: secondscreen)
        color.backgroundColor = UIColor.blue
        color.alpha = 0.4
        
        let color2 = UIView(frame: secondscreen)
        color2.backgroundColor = UIColor.orange
        color2.alpha = 0.4

        secc.addSubview(color)
        
        self.view.addSubview(secc)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonAction(sender: UIButton!) {
        print("tew5t")
//        
        let newVC = CameraViewViewController()
        self.present(newVC, animated: true, completion: nil)
    }

}

