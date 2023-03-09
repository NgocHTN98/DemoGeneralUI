//
//  Extension+UITextField.swift
//  Hi FPT
//
//  Created by Jenny on 23/07/2021.
//

import UIKit

private var __maxLengths = [UITextField: Int]()
extension UITextField{
    //Validate Phone number with 84
    func validatePhoneNumber(strPhone: String, completion: @escaping (_ isCorrect: Bool, _ strMessage: String)->() ) {
        
        if strPhone.count == 0 {
            completion(false, "")
            return
        }
        
        var offSetNo: Int = 1
        
        var index = strPhone.index(strPhone.startIndex, offsetBy: offSetNo)
        var firstPhoneNo = String(strPhone[..<index])
        var formatPhone = ""
        
        if strPhone.count > 0 && strPhone.count < 10 {
            completion( false, "")
        }
        if strPhone.count > 12{
            completion( false, "")
        }
        if strPhone.count == 10 {
            index = strPhone.index(strPhone.startIndex, offsetBy: offSetNo)
            firstPhoneNo = String(strPhone[..<index])
            
            if firstPhoneNo.elementsEqual("0") {
                if strPhone == "0000000000" {
                     completion( false, "")
                } else {
                     completion(true, strPhone)
                }
            } else {
                completion( false, "")
            }
        }
        
        if strPhone.count == 11 && firstPhoneNo.elementsEqual("8"){
            offSetNo = 3
            index = strPhone.index(strPhone.startIndex, offsetBy: offSetNo)
            firstPhoneNo = String(strPhone[..<index])
            let compair2Chacrater = String(strPhone[..<strPhone.index(strPhone.startIndex, offsetBy: 2)])
            if !firstPhoneNo.elementsEqual("840") && compair2Chacrater.elementsEqual("84") {
                
               completion( true, "0\(strPhone.dropFirst(2))" )
            }
            else{
                completion( false, "")
            }
        }
        
        if strPhone.count == 12 && firstPhoneNo.elementsEqual("8"){
            offSetNo = 3
            index = strPhone.index(strPhone.startIndex, offsetBy: offSetNo)
            firstPhoneNo = String(strPhone[..<index])
            if firstPhoneNo.elementsEqual("840") {
                formatPhone = "0\(strPhone.dropFirst(offSetNo))"
                completion ( true , formatPhone )
            }else{
                completion( false, "")
            }
        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: UITextField) {
        if let t: String = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}
