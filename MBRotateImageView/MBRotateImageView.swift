//
//  MBRotateImageView.swift
//  MBRotateImageView
//
//  Created by MBKwon on 31/01/2019.
//  Copyright © 2019 MB Kyle KWON. All rights reserved.
//

import UIKit

class MBRotateImageView: UIView {
    
    private let imageView: UIImageView = UIImageView(frame: .zero)
    private var rotationTimer: Timer?
    private var currentAngle: CGFloat = 0.0
    
    public var intervalAngle: CGFloat = 3.0
    public var rotateDirection: RotateDirectionType = .clockWise
    public enum RotateDirectionType {
        case clockWise
        case countClockWise
    }
    
    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            imageView.layer.cornerRadius = cornerRadius
        }
    }
    
    public var imageUrl: URL? {
        didSet {
            guard let url = imageUrl else { return }
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    NSLog("\(error.localizedDescription)")
                    return
                }
                
                if let imageData = data, self?.imageUrl?.absoluteString == response?.url?.absoluteString {
                    self?.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    public override var frame: CGRect {
        didSet {
            imageView.frame = CGRect(origin: .zero, size: frame.size)
        }
    }
    
    public override var bounds: CGRect {
        didSet {
            imageView.frame = bounds
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.frame = CGRect(origin: .zero, size: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.addSubview(imageView)
        imageView.clipsToBounds = true
    }
    
    public func activateRotatingImage() {
        guard rotationTimer == nil else { return }
        rotationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ticRotate), userInfo: nil, repeats: true)
        if let timer = rotationTimer {
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    public func deactivateRotatingImage() {
        guard let timer = rotationTimer else { return }
        timer.invalidate()
        rotationTimer = nil
    }
    
    public func resetImagePosition(animated: Bool) {
        currentAngle = 0.0
        if animated {
            UIView.animate(withDuration: 0.1) {
                self.imageView.layer.setAffineTransform(.identity)
            }
        } else {
            imageView.layer.setAffineTransform(.identity)
        }
    }
    
    @objc private func ticRotate() {
        switch rotateDirection {
        case .clockWise:
            currentAngle += intervalAngle
        case .countClockWise:
            currentAngle -= intervalAngle
        }
        rotateImage(angle: currentAngle)
    }
    
    private func rotateImage(angle: CGFloat) {
        let radians: CGFloat = angle * CGFloat(Double.pi) / 180.0
        UIView.animate(withDuration: 0.1) {
            self.imageView.layer.setAffineTransform(CGAffineTransform(rotationAngle: radians))
        }
    }
}
