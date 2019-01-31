//
//  ViewController.swift
//  MBRotateImageView
//
//  Created by MBKwon on 31/01/2019.
//  Copyright © 2019 MB Kyle KWON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageView = MBRotateImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setImageView1()
    }
    
    func setImageView1() {
        
        imageView.image = #imageLiteral(resourceName: "TestImage")
        self.view.addSubview(imageView)
        imageView.activateRotatingImage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.imageView.resetImagePosition(animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            self?.imageView.resetImagePosition(animated: false)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) { [weak self] in
            self?.imageView.deactivateRotatingImage()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) { [weak self] in
            self?.imageView.activateRotatingImage()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) { [weak self] in
            guard let self = self else { return }
            switch self.imageView.rotateDirection {
            case .clockWise:
                self.imageView.rotateDirection = .countClockWise
            case .countClockWise:
                self.imageView.rotateDirection = .clockWise
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.0) { [weak self] in
            self?.setImageView1()
        }
    }
}

