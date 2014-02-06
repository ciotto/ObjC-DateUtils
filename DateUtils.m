//
//  DateUtils.m
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

#import "DateUtils.h"

@implementation DateUtils

//
//	Returns a date object from year, month and day int values.
//
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,00,00,00", yyyy, mm, dd]];
}


//
//  Returns a date object from year, month, day, hour and minute int values.
//
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,%d,%d,00", yyyy, mm, dd, hh, mi]];
}

//
//  Returns a date object from year, month, day, hour, minute and second int values.
//
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi second:(int)ss {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,%d,%d,%d", yyyy, mm, dd, hh, mi, ss]];
}

//
//	Returns a date object from a ISO 8601 date string.
//
+ (NSDate *)dateFromTZformat:(NSString *)date {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter dateFromString:date];
}

//
//  Returns a ISO 8601 date string from a date object.
//
+ (NSString *)dateTZformat:(NSDate *)date {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter stringFromDate:date];
}

//
//	Returns a date object from a time string in format 'HH:mm'.
//  Fix iOS 6+ http://stackoverflow.com/questions/12449553/ios6-nsdateformatter-default-year
//
+ (NSDate *)dateFromTimeFormat:(NSString *)dateString {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"HH:mm:ss"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDate *date=[dateFormatter dateFromString:dateString];
    
    if(!date) return nil;
    
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDateComponents *components=[calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
    
    return [calendar dateByAddingComponents:components toDate:[NSDate dateWithTimeIntervalSince1970:0] options:0];
}

//
//	Returns a time string from a date object in format 'HH:mm'.
//
+ (NSString *)timeStringFromDate:(NSDate *)date {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"HH:mm:ss"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter stringFromDate:date];
}

//
//	Returns a NSDateComponents object from a date.
//
+ (NSDateComponents *)componentsFromDate:(NSDate *)date {
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
//	[gregorian setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
}

//
//	Returns the number of days in a month from a given date.
//
+ (int)numOfDaysOnMonth:(NSDate *)date {
	NSDateComponents *components = [DateUtils componentsFromDate:date];
	
	NSInteger month = [components month];
	if(month == 4 || month == 6 || month == 9 || month == 11)
		return 30;
	
	if(month == 2) {
		NSInteger year = [components year];
		if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
			return 29;
		else
			return 28;
	}
	return 31;
}

//
//	Returns an integer representation of a date. To help when comparing dates.
//
+ (int)dateCompareValue:(NSDate *)date {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyyMMddss"];
	NSString *dateStr = [dateFormatter stringFromDate:date];
	[dateFormatter release];
	return [dateStr intValue];
}

//
//	Returns a rounded date object for a given date from a given minute interval.
//
+ (NSDate *)roundDate:(NSDate *)dateToRound withInterval:(int)minuteInterval {
	NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:dateToRound];
	NSInteger remainder = [dateComponents minute] % minuteInterval;
	
	if (remainder >= minuteInterval/2) 
        dateToRound = [dateToRound dateByAddingTimeInterval:((minuteInterval - remainder) * 60)];
	else if (remainder > 0 && remainder < minuteInterval/2)
        dateToRound = [dateToRound dateByAddingTimeInterval:(remainder * -60)];
	
	return [dateToRound dateByAddingTimeInterval:(-1 * [dateComponents second])];    
}

@end
