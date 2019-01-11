//
//  ViewController.swift
//  FunDraw
//
//  Created by Seth Danner on 1/11/19.
//  Copyright © 2019 Seth Danner. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    override func draw(_ rect: CGRect) {
        
        // Custom Drawing
        super.draw(rect)
    }
}

class ViewController: UIViewController {
    
    let canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.frame = view.frame
    }


}

