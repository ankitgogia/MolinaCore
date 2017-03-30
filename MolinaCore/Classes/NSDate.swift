//
//  NSDate.swift
//  Swift extensions
//
//  Created by Anatoliy Voropay on 5/7/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import Foundation

public extension Date {
    
    // MARK: Working with NSDate-s 
    
    /** 
        Will return *true* if dates is the same calendar day.
    
        :param: date is NSDate that will be compared with current NSDate
    
        :returns: true if it's the same date or false otherwise
    */
    public func isTheSameDay(_ date: Date) -> Bool {
        let calendar: Calendar = Calendar.current
        let unitFlags: NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day]
        
        let comp1: DateComponents = (calendar as NSCalendar).components(unitFlags, from: self)
        let comp2: DateComponents = (calendar as NSCalendar).components(unitFlags, from: date)
        
        return comp1.day == comp2.day && comp1.month == comp2.month && comp1.year == comp2.year
    }
    
    // MARK: Time intervals
    
    /** 
        Will return readable time intervals for short period of times (less than one hour) in 
        format *hh:mm:ss* where *hh* is hours, *mm* is minutes and *ss* is seconds. If time interval is negative will
        return the same value but with *-* sign in the begining. 
    
        If timeInterval is NaN will return *00:00*
    
        The best for use for time intervals less than one day.
    
        :param: timeInterval is a given time interval
    
        :returns: String in current format
    */
    public static func hourlyTimingString(_ timeInterval: TimeInterval?) -> String {
        let unrecognizedString = "00:00"
        
        if timeInterval?.isNaN == true {
            return unrecognizedString
        }
        
        if let timeInterval = timeInterval {
            var prefix = ""
            var interval: Int = Int(timeInterval)
            
            if interval < 0 {
                prefix = "-"
                interval *= -1
            }
            
            let seconds: Int = interval % 60
            let minutes: Int = (interval / 60) % 60
            let hours: Int = (interval / 60 / 60) % 60
            
            if hours > 0 {
                return String(format: "\(prefix)%ld:%02ld:%02ld", hours, minutes, seconds)
            } else {
                return String(format: "\(prefix)%02ld:%02ld", minutes, seconds)
            }
        } else {
            return unrecognizedString
        }
    }
    
    // MARK: Readable dates and time intervals
    
    /** 
        Will return readable time intervals for past dates. Few possible outputs that can describe how it works:
        
        * less than minute
        * 1 minute ago
        * 6 minutes ago
        * 4 hours ago
        * 2 days ago
        * 1 month ago
        * 245 years ago
    
        For future dates will return *soon*
    
        :param: date is a NSDate that will be used to create readable string
    
        :returns: String in human readable format
    */
    public static func readableTimeInterval(_ date: Date) -> String {
        let timeInterval = Date().timeIntervalSince(date)
        
        if timeInterval < 0 {
            return "soon"
        }
        
        if (timeInterval < 60) {
            return "less than minute ago"
        } else if (timeInterval < 60 * 60) {
            let minutes = Int(timeInterval / 60)
            let s = ( minutes > 1 ? "s" : "" )
            return "\(minutes) minute\(s) ago"
        } else if (timeInterval < 60 * 60 * 24) {
            let hours = Int(timeInterval / 60 / 60)
            let s = ( hours > 1 ? "s" : "" )
            return "\(hours) hour\(s) ago"
        } else if (timeInterval < 60 * 60 * 24 * 31) {
            let days = Int(timeInterval / 60 / 60 / 24)
            let s = ( days > 1 ? "s" : "" )
            return "\(days) day\(s) ago"
        } else if (timeInterval < 60 * 60 * 24 * 31 * 12) {
            let months = Int(timeInterval / 60 / 60 / 24 / 31)
            let s = ( months > 1 ? "s" : "" )
            return "\(months) month\(s) ago"
        } else {
            let years = Int(timeInterval / 60 / 60 / 24 / 365)
            let s = ( years > 1 ? "s" : "" )
            return "\(years) year\(s) ago"
        }
    }
    
    /**
        Will return readable string from given date. For date less than 24 hours will return exact *hour:minute*.
        For date less than 1 week will return *day of week*. And finaly for all other dates will return 
        date in *en_US_POSIX* format
    
        :param: date is a NSDate that will be used for readable string generation
    
        :returns: Human readable date string
    */
    public static func readableDate(_ date: Date) -> String {
        let timeInterval = Date().timeIntervalSince(date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if timeInterval < 0 {
            return "soon"
        }
        
        if Date().isTheSameDay(date) == true {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date).uppercased()
        } else if (timeInterval < 60 * 60 * 24 * 7) {
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        } else {
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.none
            dateFormatter.doesRelativeDateFormatting = true
            
            return dateFormatter.string(from: date).uppercased()
        }
    }

    public func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false

        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }

        //Return Result
        return isGreater
    }

    public func isLessThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false

        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }

        //Return Result
        return isLess
    }

    public func equalToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false

        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }

        //Return Result
        return isEqualTo
    }

    public func addDays(_ daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)

        //Return Result
        return dateWithDaysAdded
    }

    public func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)

        //Return Result
        return dateWithHoursAdded
    }
    
    public func addMinutes(_ minutesToAdd: Int) -> Date {
        let minutesInSeconds: TimeInterval = Double(minutesToAdd) * 60
        let dateWithMinutesAdded: Date = self.addingTimeInterval(minutesInSeconds)
        return dateWithMinutesAdded
    }

    /// Convert the date into String with custom unknown format
    public func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

/// Get beginning of date i.e. 00:00:00 time
    public func beginningOfDay() -> Date {
        let calendar = Calendar.current
        var components = (calendar as NSCalendar).components([.year,  .month, .day], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        return calendar.date(from: components)!
    }


    /// Get end of the date i.e. 23:59:59 time
    public func endOfDay() -> Date {
        var components = DateComponents()
        components.hour = 23
        components.minute = 59
        components.second = 59
        let date = (Calendar.current as NSCalendar).date(byAdding: components, to: self.beginningOfDay(), options: NSCalendar.Options([]))!
        return date
    }


    /// Get week start date for given date
    public func dateAtWeekStart() -> Date {
        var cal = Calendar.current
        cal.firstWeekday = 1 // If you insist on Sunday being the first day of the week.
        let flags : NSCalendar.Unit = [.yearForWeekOfYear, .weekOfYear]
        let components = (cal as NSCalendar).components(flags, from: self)
        return cal.date(from: components)!
    }


    /// Get week end date for given date
    public func dateAtWeekEnd() -> Date {
        let daysToAdd = 7
        let timeToAdd = 60*60*24*daysToAdd
        return dateAtWeekStart().addingTimeInterval(TimeInterval(timeToAdd))
    }


    /// Get date after x days
    public func daysToAdd(_ days: Int) -> Date {
        let daysToAdd = days
        let timeToAdd = 60*60*24*daysToAdd
        return self.addingTimeInterval(TimeInterval(timeToAdd))
    }


    /// Get days left from todays date
    public func daysLeft() -> Int {
        return (Calendar.current as NSCalendar).components(.day, from: Date(), to: self, options: []).day!
    }


    /// Compare date i.e. year, month, date (ignoring time)
    public func sameDayAs(_ date: Date) -> Bool {
        let flags: NSCalendar.Unit = [.era, .year, .month, .day]
        let cal = Calendar.current
        let components1 = (cal as NSCalendar).components(flags, from: self)
        let components2 = (cal as NSCalendar).components(flags, from: date)
        return (components1.era == components2.era && components1.year == components2.year && components1.month == components2.month && components1.day == components2.day)
    }


    /// Check for a past date
    public var passedCurrentDate: Bool {
        var isLess = false
        if self.compare(Date()) == ComparisonResult.orderedAscending {
            isLess = true
        }
        return isLess
    }


    /// Returns whether the date is today or not
    public var isToday: Bool {
        let calendar = Calendar.current
        let flags: NSCalendar.Unit = [.era, .year, .month, .day]
        let components = (calendar as NSCalendar).components(flags, from: self)
        let today = (calendar as NSCalendar).components(flags, from: Date())
        return (components.era == today.era && components.year == today.year && components.month == today.month && components.day == today.day)
    }

    /// Returns a `String` representing the current date in universal time
    public func toUTCString(format: String = "yyyy-MM-dd'T'HH:mm:ss'Z'") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }

    // MARK: - mCare Stuff

    // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
    public enum DateFormat: String {
        case AMorPM = "a"
        case Appointment = "yyyy-MM-dd'T'HH:mm:ss"
        case AppointmentAlt1 = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        case DateWithHours = "MMM dd, h:mm a"
        case MonthDate = "MMM dd"
        case ShortStyle = "MM/dd/yyyy"
        case LogFormat = "yyyy_MM_dd"
        case SyncDate = "h:mm a 'on' EEE, MMM d"
        case Time = "h:mm"
        case FullTime = "h:mm a"
        case FullDate = "EEEE, MMM d, yyyy"
        case FullAppointmentDateTime = "EEEE, MMM d 'at' h:mm a"
        case UTC = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        case WeekDay = "EEEE"
        case DayStyle = "EEEE, MMM d"
        case HTTPFormat = "EEE',' dd MMM yyyy HH':'mm':'ss z"
    }
}
