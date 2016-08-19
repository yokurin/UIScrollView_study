//
//  ViewController.swift
//  UIScrollView_study
//
//  Created by Hayashi Tsubasa on 2016/08/16.
//  Copyright © 2016年 Hayashi Tsubasa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var innerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = ["0F10F1","0F0002","0F110F","F01011","0F11A2","1F0000","110F11","1100F2","11F100"]
        
        for (index, val) in views.enumerate() {
            let addView = createDisplaySizeView(val, index: index)
            var x: CGFloat = 0
            var y: CGFloat = 0
            let width = self.screenWidth()
            let height = self.screenHeight()
            if index == 0 {
                x = width / 2
                y = height / 2
            } else if index > 0 && index < 3 { // 1段目
                x = (width / 2) * CGFloat(index + (index + 1))
                y = height / 2
            } else if index >= 3 && index < 6 { // 2段目
                let ind = index - 3
                x = (width / 2) * CGFloat(ind + (ind + 1))
                y = height / 2 * 3
            } else { // 3段目
                let ind = index - 3*2
                x = (width / 2) * CGFloat(ind + (ind + 1))
                y = height / 2 * 5
            }
            addView.center = CGPoint(x: x, y: y)
            innerView.addSubview(addView)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func createDisplaySizeView(color: String, index: Int) -> UIView{
        let view = UIView(frame:
            CGRect(origin: CGPointZero,
                   size: CGSize(
                        width: self.screenWidth(),
                        height: self.screenHeight()
                   )
            )
        )
        view.backgroundColor = UIColor.hexStr(color, alpha: 1)
        let indexLabel = UILabel(frame: CGRect(origin: CGPointZero, size: CGSize(width: 30, height: 30)))
        indexLabel.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        indexLabel.text = String(index)
        indexLabel.textColor = UIColor.whiteColor()
        view.addSubview(indexLabel)
        return view
    }
    
    private func screenWidth() -> CGFloat {
        return CGFloat(UIScreen.mainScreen().bounds.size.width)
    }
    
    private func screenHeight() -> CGFloat {
        return CGFloat(UIScreen.mainScreen().bounds.size.height)
    }
    
}


extension UIColor {
    class func hexStr (hexStr : NSString, alpha : CGFloat) -> UIColor {
        let hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r, green: g, blue: b, alpha: alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}
