//
//  NSDate-Utils.h
//  Created by Christian Bianciotto on 06/02/14.
//  https://github.com/ciotto/ObjC-DateUtils
//
//  Copyright (c) 2014, Christian Bianciotto <@ciotto>
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

#import "NSString+DateUtils.h"

@interface NSDate (Utils)

- (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd;
- (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi;
- (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi second:(int)ss;
- (NSString *)dateTZformat;
- (NSString *)timeString;
- (NSDateComponents *)components;
- (int)numOfDaysOnMonth;
- (int)dateCompareValue;
- (NSDate*)roundedDateWithInterval:(int)minuteInterval;

@end

@interface NSDate (UtilsComparison)

- (BOOL)isBetweenDate:(NSDate *)date1 :(NSDate *)date2;

@end

@interface NSDate (UtilsOperation)

- (NSDate *)dateByAddingYear:(int)year;
- (NSDate *)dateByAddingMonth:(int)month;
- (NSDate *)dateByAddingDay:(int)day;
- (NSDate *)dateByAddingHour:(int)hour;
- (NSDate *)dateByAddingMinute:(int)minute;
- (NSDate *)dateByAddingSecond:(int)second;
- (NSDate *)dateByAddingDate:(NSDate *)date;

@end