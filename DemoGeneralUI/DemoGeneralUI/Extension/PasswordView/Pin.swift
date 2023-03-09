//
//  Pin.swift
//  demoLoginAccount
//
//  Created by Thinh  Ngo on 11/2/21.
//

import Foundation
import UIKit

class Pin: UIView {
    let pin = UIView()
    
    func setSizePin(pinSize: Double) {
//        pin.widthAnchor.constraint(equalToConstant: CGFloat(pinSize)).isActive = true
//        pin.heightAnchor.constraint(equalToConstant: CGFloat(pinSize)).isActive = true
//        pin.setNeedsLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(size: CGFloat) {
        self.init()
        setupUI(size: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(size: CGFloat) {
        pin.backgroundColor = .black
        pin.layer.cornerRadius = size / 2
        pin.layer.masksToBounds = true
        pin.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pin)
        NSLayoutConstraint.activate([
            pin.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pin.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pin.widthAnchor.constraint(equalToConstant: size),
            pin.heightAnchor.constraint(equalToConstant: size),
        ])
        pin.setNeedsLayout()
    }
}
