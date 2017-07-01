//
//  MenuManager.swift
//  imgscroll
//
//  Created by 謝忠穎 on 2017/6/30.
//  Copyright © 2017年 謝忠穎. All rights reserved.
//

import UIKit

class MenuManager: NSObject {
    let blackView = UIView()
    
    public func openMenu(thisview: UIView){
        
            blackView.frame = thisview.frame
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.isUserInteractionEnabled = true
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
            
            
            thisview.addSubview(blackView)
            
            UIView.animate(withDuration: 3, animations: {
                self.blackView.alpha = 1
                thisview.willRemoveSubview(self.blackView)
            })

    }
    
    public func dismissMenu() {
        print("dismiss")
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
        })

    }
}
