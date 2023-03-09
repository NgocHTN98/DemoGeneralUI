////
////  Extension+Date.swift
////  Hi FPT
////
////  Created by TaiVC on 6/10/22.
////
//import Foundation
//
//extension Date {
//    
//    func string(format: String) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = format
//        formatter.calendar = Calendar(identifier: .gregorian)
//        return formatter.string(from: self)
//    }
//    
//    func convertToString(dateformat formatType: DateFormatType) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = formatType.rawValue
//        dateFormatter.calendar = Calendar(identifier: .gregorian)
//        let newDate: String = dateFormatter.string(from: self)
//        return newDate
//    }
//    
//    func nextDate(days: Int?) -> Date {
//        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days ?? 1, to: self) ?? Date()
//    }
//    
//    func compareDate(date: Date) -> Bool {
//        let order = Calendar(identifier: .gregorian).compare(self, to: date, toGranularity: .day)
//        switch order {
//        case .orderedSame:
//            return true
//        default:
//            return false
//        }
//    }
//    func compareDescending(date: Date) -> Bool {
//        let order = Calendar(identifier: .gregorian).compare(self, to: date, toGranularity: .day)
//        switch order {
//        case .orderedDescending:
//            return true
//        default:
//            return false
//        }
//    }
//    func compareAscending(date: Date) -> Bool {
//        let order = Calendar(identifier: .gregorian).compare(self, to: date, toGranularity: .day)
//        switch order {
//        case .orderedAscending:
//            return true
//        default:
//            return false
//        }
//    }
//    func compareDescendingOrSame(date: Date) -> Bool {
//        let order = Calendar(identifier: .gregorian).compare(self, to: date, toGranularity: .day)
//        switch order {
//        case .orderedDescending:
//            return true
//        case .orderedSame:
//            return true
//        default:
//            return false
//        }
//    }
//    func compareAscendingOrSame(date: Date) -> Bool {
//        let order = Calendar(identifier: .gregorian).compare(self, to: date, toGranularity: .day)
//        switch order {
//        case .orderedAscending:
//            return true
//        case .orderedSame:
//            return true
//        default:
//            return false
//        }
//    }
//    
//    func formatZeroHour() -> Date?
//    {
//        let calendar = Calendar.current
//        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
//        components.hour = 0
//        components.minute = 0
//        components.second = 0
//        return calendar.date(from: components)
//    }
//    
//    var timeStamp: Int64 {
//        return Int64(self.timeIntervalSince1970 * 1000)
//    }
//    
//    var startOfMonth: Date {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "vi_VN_POSIX")
//        let components = calendar.dateComponents([.year, .month], from: self)
//        return  (calendar.date(from: components) ?? Date()).toLocalTime()
//    }
//    
//    var endOfMonth: Date {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "vi_VN_POSIX")
//        var components = DateComponents()
//        components.month = 1
//        components.second = -1
//        return calendar.date(byAdding: components, to: startOfMonth) ?? Date()
//    }
//    
//    func getWeekday() -> WeekdayType {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "vi_VN_POSIX")
//        let day = calendar.component(.weekday, from: self)
//        return WeekdayType(rawValue: day) ?? .Mon
//    }
//    
//    func nextMonth(months: Int?) -> Date {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "vi_VN_POSIX")
//        
//        return calendar.date(byAdding: .month, value: months ?? 1, to: self) ?? Date()
//    }
//    
//    func getDaysInMonth() -> Int{
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "vi_VN_POSIX")
//
//        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
//        let date = calendar.date(from: dateComponents) ?? Date()
//
//        let range = calendar.range(of: .day, in: .month, for: date)
//        let numDays = range?.count ?? 0
//
//        return numDays
//    }
//    
//    func toLocalTime() -> Date {
//        
//        // 1) Get the current TimeZone's seconds from GMT. Since I am in Chicago this will be: 60*60*5 (18000)
//        let timezoneOffset = TimeZone.current.secondsFromGMT()
//        
//        // 2) Get the current date (GMT) in seconds since 1970. Epoch datetime.
//        let epochDate = self.timeIntervalSince1970
//        
//        // 3) Perform a calculation with timezoneOffset + epochDate to get the total seconds for the
//        //    local date since 1970.
//        //    This may look a bit strange, but since timezoneOffset is given as -18000.0, adding epochDate and timezoneOffset
//        //    calculates correctly.
//        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
//        
//        
//        // 4) Finally, create a date using the seconds offset since 1970 for the local date.
//        return Date(timeIntervalSince1970: timezoneEpochOffset)
//    }
//    
//    func minus (recent: Date) -> (Int) {
//        let day = Calendar.current.dateComponents([.day], from: self, to: recent).day
//        return day ?? -1
//    }
//    
//    func setTimeForDate(hour: Int, minute: Int, second: Int) -> Date
//        {
//            let calendar = Calendar.current
//
//            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
//
//            components.minute = minute
//            components.second = second
//            components.hour = hour
//
//            return calendar.date(from: components) ?? Date()
//        }
//    func getMonth() -> MonthType {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "vi_VN_POSIX")
//        let month = calendar.component(.month, from: self)
//        return MonthType(rawValue: month) ?? .Jan
//    }
//}
//
////Value weekday of Swift Callendar library
//enum WeekdayType:Int{
//    case Sun = 1
//    case Mon = 2
//    case Tue = 3
//    case Web = 4
//    case Thu = 5
//    case Fri = 6
//    case Sat = 7
//    
//    func getWeekDayFromEnum()->String{
//        switch (self){
//        case .Sun:
//            return Localizable.shared.localizedString(key: "CN")
//        case .Mon:
//            return Localizable.shared.localizedString(key: "T2")
//        case .Tue:
//            return Localizable.shared.localizedString(key: "T3")
//        case .Web:
//            return Localizable.shared.localizedString(key: "T4")
//        case .Thu:
//            return Localizable.shared.localizedString(key: "T5")
//        case .Fri:
//            return Localizable.shared.localizedString(key: "T6")
//        case .Sat:
//            return Localizable.shared.localizedString(key: "T7")
//
//        }
//    }
//}
