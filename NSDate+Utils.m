//
//  NSDate-Utils.m
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

#import "NSDate+Utils.h"

#import "DateUtils.h"

@implementation NSDate (Utils)

- (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd {
    return [DateUtils dateWithYear:yyyy month:mm day:dd];
}

- (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi {
    return [DateUtils dateWithYear:yyyy month:mm day:dd hour:hh minute:mm];
}

- (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi second:(int)ss {
    return [DateUtils dateWithYear:yyyy month:mm day:dd hour:hh minute:mm second:ss];
}

- (NSString *)dateTZformat {
    return [DateUtils dateTZformat:self];
}

- (NSString *)timeString {
    return [DateUtils timeStringFromDate:self];
}

- (NSDateComponents *)components {
    return [DateUtils componentsFromDate:self];
}

- (int)numOfDaysOnMonth {
    return [DateUtils numOfDaysOnMonth:self];
}

- (int)dateCompareValue {
    return [DateUtils dateCompareValue:self];
}

- (NSDate*)roundedDateWithInterval:(int)minuteInterval {
    return [DateUtils roundDate:self withInterval:minuteInterval];
}


#pragma mark Comparison

- (BOOL)isBetweenDate:(NSDate *)date1 :(NSDate *)date2 {
    return [DateUtils date:self isBetweenDate:date1 :date2];
}


#pragma mark Operation

- (NSDate *)dateByAddingYear:(int)year {
    return [DateUtils dateByAddingYear:year toDate:self];
}

- (NSDate *)dateByAddingMonth:(int)month {
    return [DateUtils dateByAddingMonth:month toDate:self];
}

- (NSDate *)dateByAddingDay:(int)day {
    return [DateUtils dateByAddingDay:day toDate:self];
}

- (NSDate *)dateByAddingHour:(int)hour {
    return [DateUtils dateByAddingHour:hour toDate:self];
}

- (NSDate *)dateByAddingMinute:(int)minute {
    return [DateUtils dateByAddingMinute:minute toDate:self];
}

- (NSDate *)dateByAddingSecond:(int)second {
    return [DateUtils dateByAddingSecond:second toDate:self];
}

- (NSDate *)dateByAddingDate:(NSDate *)date {
    return [DateUtils dateByAddingDate:date toDate:self];
}

@end










