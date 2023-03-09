//
//  Extension+String.swift
//  Hi FPT
//
//  Created by Jenny on 15/07/2021.
//

import UIKit

extension String{
    var folded: String {
        return self.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil)
                .replacingOccurrences(of: "đ", with: "d")
                .replacingOccurrences(of: "Đ", with: "D")
    }
    
    var htmlToAttributedString: NSAttributedString? {
        return Data(utf8).htmlToAttributedString
    }
    
    func isValidEmail() -> Bool {
        // http://emailregex.com/
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func stringFromDate(_ date: Date, formatDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatDate
        formatter.locale = Locale(identifier: "es_MX_POSIX")
        return formatter.string(from: date)
    }
    
    func convertFormatOfDate(date: String, originalFormat: String, destinationFormat: String) -> String {
        // Orginal format :
        let dateOriginalFormat = DateFormatter()
        dateOriginalFormat.dateFormat = originalFormat
        dateOriginalFormat.calendar = Calendar(identifier: .gregorian)
        // in the example it'll take "yy MM dd" (from our call)
        dateOriginalFormat.locale = Locale(identifier: "en_US_POSIX")
        // Destination format :
        let dateDestinationFormat = DateFormatter()
        dateDestinationFormat.calendar = Calendar(identifier: .gregorian)
        dateDestinationFormat.dateFormat = destinationFormat // in the example it'll take "EEEE dd MMMM yyyy" (from our call)
        dateDestinationFormat.locale = Locale(identifier: "en_US_POSIX")
        
        // Convert current String Date to NSDate
        let dateFromString = dateOriginalFormat.date(from: date) ?? Date()
        
        // Convert new NSDate created above to String with the good format
        let dateFormated = dateDestinationFormat.string(from: dateFromString)
        
        return dateFormated
        
    }
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
        
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeACall() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }

    func isValidPhone(phone: String) -> Bool {
//        let regex = try! NSRegularExpression(pattern: "(09|03|07|08|05)+([0-9]{8})$", options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
//        return true
        let phoneRegex = "^[0-9]{10,12}$"
                let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
                return phoneTest.evaluate(with: phone)
    }
    
    func dateFromString(_ dateString: String, formatDate: String) -> NSDate {
        //Format Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatDate//"HH:mm:ss dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "es_MX_POSIX")
        return dateFormatter.date(from: dateString) as NSDate? ?? NSDate()
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func urlSafeBase64Decoded() -> String? {
        var st = self
            .replacingOccurrences(of: "_", with: "/")
            .replacingOccurrences(of: "-", with: "+")
        let remainder = self.count % 4
        if remainder > 0 {
            st = self.padding(toLength: self.count + 4 - remainder,
                              withPad: "=",
                              startingAt: 0)
        }
        guard let d = Data(base64Encoded: st, options: .ignoreUnknownCharacters) else{
            return nil
        }
        return String(data: d, encoding: .utf8)
    }
    
    var convertDateFormater: String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
            guard let date = dateFormatter.date(from: self) else { return self }
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return  dateFormatter.string(from: date)
        }
    
    func hasSpecialCharacters() -> Bool {

        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }

        } catch {
            debugPrint(error.localizedDescription)
            return false
        }

        return false
    }
    
    func convertBase64StringToImage() -> UIImage? {
        guard let imageData = Data.init(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
        return UIImage(data: imageData)
    }
    
    func convertToDate(format: String = "yyyy-MM-dd hh:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        let date = formatter.date(from: self)
        return date
    }
    
    func convertToString(isSymbol: Bool = true) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "vi_VN_POSIX")
        if isSymbol {
            formatter.dateFormat = "hh:mm a dd/MM/yyyy"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            let dateString = formatter.string(from: self.convertToDate() ?? Date())
            return dateString
        }else{
            formatter.dateFormat = "HH:mm dd/MM/yyyy"
            let dateString = formatter.string(from: self.convertToDate(format: "yyyy-MM-dd HH:mm:ss") ?? Date())
            return dateString
        }
        
        
    }
    
    func convertStringToDictionary() -> [String: AnyObject]? {
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    func getListEmailsFromString() -> [String] {
        if let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
        {
            let string = self as NSString
            
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
        }
        return []
      }
    
    func getListPhoneNumberFromString() -> [String] {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.length))

        var resultsArray = [String]()

        for match in matches {
            if match.resultType == .phoneNumber,
                let component = match.phoneNumber {
                resultsArray.append(component)
            }
        }
        return resultsArray
    }
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateFormatter.locale = Locale(identifier: "vi_VN_POSIX")
        guard let date = dateFormatter.date(from: self) else {return nil}
        return date
    }
    func removeCharsFromEnd(count_:Int) -> String {
        let stringLength = self.count

        let substringIndex = (stringLength < count_) ? 0 : stringLength - count_

        return self.substring(toIndex: substringIndex)

    }
    func toStringFormat(toFormat: String = "yyyy-MM-dd hh:mm:ss", fromFormat: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat
        guard let date = dateFormatter.date(from: self) else { return self }
        dateFormatter.dateFormat = fromFormat
        return  dateFormatter.string(from: date)
    }
    
//    func toDateWithFormat(dateFormat: DateFormatType = .dateForReturnValue) -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = dateFormat.rawValue
//        dateFormatter.locale = Locale(identifier: "vi_VN_POSIX")
//        guard let date = dateFormatter.date(from: self) else {return nil}
//        return date
//    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
