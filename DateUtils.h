//
//  DateUtils.h
//  Created by Rodrigo Neri on 11/26/10.
//  https://github.com/rigoneri/ObjC-DateUtils
//  
//  Copyright (c) 2011, Rodrigo Neri <@rigoneri>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

#import "NSDate+Utils.h"

@interface DateUtils : NSObject

+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd;
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi;
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi second:(int)ss;
+ (NSDate *)dateFromTZformat:(NSString *)date;
+ (NSString *)dateTZformat:(NSDate *)date;
+ (NSDate *)dateFromTimeFormat:(NSString *)date;
+ (NSString *)timeStringFromDate:(NSDate *)date;
+ (NSDateComponents *)componentsFromDate:(NSDate *)date;
+ (int)numOfDaysOnMonth:(NSDate *)date;
+ (int)dateCompareValue:(NSDate *)date;
+ (NSDate*)roundDate:(NSDate*)dateToRound withInterval:(int)minuteInterval;

@end

@interface DateUtils (Comparison)

+ (BOOL)date:(NSDate *)date1 isBetweenDate:(NSDate *)date2 :(NSDate *)date3;
+ (BOOL)date:(NSDate *)date1 isBetweenDate:(NSDate *)date2 :(NSDate *)date3 includeExtremes:(BOOL)includeExtremes;

@end

@interface DateUtils (Operation)

+ (NSDate *)dateByAddingYear:(int)year toDate:(NSDate *)date;
+ (NSDate *)dateByAddingMonth:(int)month toDate:(NSDate *)date;
+ (NSDate *)dateByAddingDay:(int)day toDate:(NSDate *)date;
+ (NSDate *)dateByAddingHour:(int)hour toDate:(NSDate *)date;
+ (NSDate *)dateByAddingMinute:(int)minute toDate:(NSDate *)date;
+ (NSDate *)dateByAddingSecond:(int)second toDate:(NSDate *)date;
+ (NSDate *)dateByAddingDate:(NSDate *)date1 toDate:(NSDate *)date2;

@end

@interface DateUtils (Holiday)

+ (BOOL)dateIsHoliday:(NSDate *)date;
+ (BOOL)dateIsHoliday:(NSDate *)date withLocale:(NSLocale *)locale;

@end

@interface DateUtils (DayOfWeek)

+ (BOOL)dateIsSunday:(NSDate *)date;
+ (BOOL)dateIsMonday:(NSDate *)date;
+ (BOOL)dateIsTuesday:(NSDate *)date;
+ (BOOL)dateIsWednesday:(NSDate *)date;
+ (BOOL)dateIsThurday:(NSDate *)date;
+ (BOOL)dateIsFriday:(NSDate *)date;
+ (BOOL)dateIsSaturday:(NSDate *)date;

@end
