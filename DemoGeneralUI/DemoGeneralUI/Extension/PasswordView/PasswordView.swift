//
//  PasswordView.swift
//  demoLoginAccount
//
//  Created by Thinh  Ngo on 11/2/21.
//

import Foundation
import UIKit

@IBDesignable
class PasswordView: UIView {
    @IBInspectable var emptyPasswordColor: UIColor = UIColor(red: 0.866, green: 0.866, blue: 0.866, alpha: 1)
    @IBInspectable var passwordColor: UIColor = UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
    @IBInspectable var passwordColorWrong: UIColor = UIColor(red: 0.898, green: 0.384, blue: 0.361, alpha: 1)
    @IBInspectable var pinIconSize: Double = 10.0
    var keyboardType: UIKeyboardType = .numberPad
    var isSecureTextEntry: Bool = true
    var isNotMatchPW = false
    var didFinishedEnterCode:(()-> Void)?
    var textInputed: String = "" {
        didSet {
            updateStack(by: textInputed)
            if textInputed.count == maxLength {
                self.resignFirstResponder()
            }
            didFinishedEnterCode?()
        }
    }
    
    private var maxLength:Int = 6
    private let stack = UIStackView()
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        showKeyboardIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        showKeyboardIfNeeded()
    }
    
    private func setupLayout() {
        addSubview(stack)
        self.backgroundColor = .white
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        updateStack(by: textInputed)
    }
    
    private func emptyPin() -> UIView {
        let pin = Pin(size: pinIconSize)
        pin.pin.backgroundColor = emptyPasswordColor
        pin.setSizePin(pinSize: pinIconSize)
        return pin
    }
    
    private func pin() -> UIView {
        let pin = Pin(size: pinIconSize)
        if isNotMatchPW {
            pin.pin.backgroundColor = passwordColorWrong
        } else {
            pin.pin.backgroundColor = passwordColor
        }
        pin.setSizePin(pinSize: pinIconSize)
        return pin
    }
    
    private func pinShow(text: String) -> UIView {
        let pin = PinShow(size: pinIconSize)
        pin.setTextForLabel(text: text)
        if isNotMatchPW {
            pin.setColorForLabel(color: passwordColorWrong)
        } else {
            pin.setColorForLabel(color: passwordColor)
        }
        pin.setSizePin(pinSize: pinIconSize)
        return pin
    }
    
    func updateStack(by code: String) {
        var emptyPins:[UIView] = Array(0..<maxLength).map{ _ in emptyPin()}
        let userPinLength = code.count
        let pins:[UIView] = Array(0..<userPinLength).map{ element in
            if self.isSecureTextEntry {
                return pin()
            } else {
                return pinShow(text: code[element])
            }
            
        }
        
        for (index, element) in pins.enumerated() {
            emptyPins[index] = element
        }
        stack.removeAllArrangedSubviews()
        for view in emptyPins {
            stack.addArrangedSubview(view)
        }
    }
    
    func updateStackToShowPass(isShow: Bool) {
        var emptyPins:[UIView] = Array(0..<maxLength).map{ _ in emptyPin()}
        let userPinLength = self.textInputed.count
        let pins:[UIView] = Array(0..<userPinLength).map{ [weak self] element in
            pinShow(text: self?.textInputed[element] ?? "")
        }
        
        for (index, element) in pins.enumerated() {
            emptyPins[index] = element
        }
        stack.removeAllArrangedSubviews()
        for view in emptyPins {
            stack.addArrangedSubview(view)
        }
    }
    
    private func showKeyboardIfNeeded() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func showKeyboard() {
        self.becomeFirstResponder()
    }
}

extension PasswordView:UIKeyInput {
    var hasText: Bool {
        return textInputed.count > 0
    }
    
    func insertText(_ text: String) {
        if textInputed.count == maxLength {
            return
        }
        textInputed.append(contentsOf: text)
    }
    
    func deleteBackward() {
        if hasText {
            textInputed.removeLast()
            isNotMatchPW = false
        }
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
