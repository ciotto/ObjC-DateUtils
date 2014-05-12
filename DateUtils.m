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
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,00,00,00", yyyy, mm, dd]];
}


//
//  Returns a date object from year, month, day, hour and minute int values.
//
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,%d,%d,00", yyyy, mm, dd, hh, mi]];
}

//
//  Returns a date object from year, month, day, hour, minute and second int values.
//
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi second:(int)ss {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,%d,%d,%d", yyyy, mm, dd, hh, mi, ss]];
}

//
//	Returns a date object from a ISO 8601 date string.
//
+ (NSDate *)dateFromTZformat:(NSString *)date {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter dateFromString:date];
}

//
//  Returns a ISO 8601 date string from a date object.
//
+ (NSString *)dateTZformat:(NSDate *)date {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter stringFromDate:date];
}

//
//	Returns a date object from a time string in format 'HH:mm'.
//  Fix iOS 6+ http://stackoverflow.com/questions/12449553/ios6-nsdateformatter-default-year
//
+ (NSDate *)dateFromTimeFormat:(NSString *)dateString {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
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
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm:ss"];
//	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [dateFormatter stringFromDate:date];
}

//
//	Returns a NSDateComponents object from a date.
//
+ (NSDateComponents *)componentsFromDate:(NSDate *)date {
    if(!date) return nil;
    
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
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


#pragma mark Comparison

//
//	Return YES if date1 is between date2 and date3 with included extremes.
//
+ (BOOL)date:(NSDate *)date1 isBetweenDate:(NSDate *)date2 :(NSDate *)date3 {
    return [self date:date1 isBetweenDate:date2 :date3 includeExtremes:YES];
}

//
//	Return YES if date1 is between date2 and date3.
//
+ (BOOL)date:(NSDate *)date1 isBetweenDate:(NSDate *)date2 :(NSDate *)date3 includeExtremes:(BOOL)includeExtremes {
    return ([date2 compare:date1]==NSOrderedAscending && [date3 compare:date1]==NSOrderedDescending) ||
    (includeExtremes && [date2 compare:date1]!=NSOrderedDescending && [date3 compare:date1]!=NSOrderedAscending);
}


#pragma mark Operation

//
//	Return a date with year added.
//
+ (NSDate *)dateByAddingYear:(int)year toDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year=year;
    
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	Return a date with month added.
//
+ (NSDate *)dateByAddingMonth:(int)month toDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month=month;
    
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	Return a date with day added.
//
+ (NSDate *)dateByAddingDay:(int)day toDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day=day;
    
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	Return a date with hours added.
//
+ (NSDate *)dateByAddingHour:(int)hour toDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour=hour;
    
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	Return a date with minute added.
//
+ (NSDate *)dateByAddingMinute:(int)minute toDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.minute=minute;
    
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	Return a date with second added.
//
+ (NSDate *)dateByAddingSecond:(int)second toDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.second=second;
    
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	Return a date with date added.
//
+ (NSDate *)dateByAddingDate:(NSDate *)date1 toDate:(NSDate *)date2 {
    NSDateComponents *components = [DateUtils componentsFromDate:date2];
    
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [calendar dateByAddingComponents:components toDate:date1 options:0];
}


#pragma mark Holiday

//
//	Return YES if date is a holiday.
//
+ (BOOL)dateIsHoliday:(NSDate *)date {
    return [self dateIsHoliday:date withLocale:[NSLocale currentLocale]];
}

//
//	Return YES if date is a holiday in locale.
//
+ (BOOL)dateIsHoliday:(NSDate *)date withLocale:(NSLocale *)locale {
    NSString *countryCode=[locale objectForKey:NSLocaleCountryCode];
    NSDateComponents *components=[self componentsFromDate:date];
    
    if([countryCode isEqualToString:@"IT"]){
        if(components.month==1 && components.day==1) return YES;
        if(components.month==1 && components.day==6) return YES;
        if(components.month==4 && components.day==25) return YES;
        if(components.month==5 && components.day==1) return YES;
        if(components.month==6 && components.day==2) return YES;
        if(components.month==8 && components.day==15) return YES;
        if(components.month==11 && components.day==1) return YES;
        if(components.month==12 && components.day==8) return YES;
        if(components.month==12 && components.day==25) return YES;
        if(components.month==12 && components.day==26) return YES;
        
        // Easter and easter monday
        NSDateComponents *easterMonday=[self componentsFromDate:[self dateByAddingDay:(-1) toDate:date]];
        
        NSInteger a=components.year%19;
        NSInteger b=components.year%4;
        NSInteger c=components.year%7;
        
        NSInteger m=24;
        NSInteger n=5;
        
        if(components.year>1583 && components.year<1699){
            m=22;
            n=2;
        }else if(components.year>1700 && components.year<1799){
            m=23;
            n=3;
        }else if(components.year>1800 && components.year<1899){
            m=23;
            n=4;
        }else if(components.year>1900 && components.year<2099){
            m=24;
            n=5;
        }else if(components.year>2100 && components.year<2199){
            m=24;
            n=6;
        }else if(components.year>2200 && components.year<2299){
            m=25;
            n=0;
        }else if(components.year>2300 && components.year<2399){
            m=26;
            n=1;
        }else if(components.year>2400 && components.year<2499){
            m=25;
            n=1;
        }else{
            NSLog(@"Easter date not supported in %ld",(long)components.year);
            assert(NO);
        }
        
        NSInteger d=((19*a)+m)%30;
        NSInteger e=((2*b)+(4*c)+(6*d)+n)%7;
        
        
        
        if((d+e)<10){
            NSInteger day=d+e+22;
            if(day==26) day=19;
            else if(day==25 && d==28 && e==6 && a>10) day=19;
            
            if((components.month==3 && components.day==day) || (easterMonday.month==3 && easterMonday.day==day)) return YES;
        }else if((components.month==4 && components.day==d+e-9) || (easterMonday.month==4 && easterMonday.day==d+e-9)) return YES;
    }else{
        NSLog(@"Locale %@ not supported", countryCode);
        assert(NO);
    }
    
    return NO;
}


#pragma mark DayOfWeek

+ (BOOL)dateIsSunday:(NSDate *)date {
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==1;
}

+ (BOOL)dateIsMonday:(NSDate *)date {
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==2;
}

+ (BOOL)dateIsTuesday:(NSDate *)date {
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==3;
}

+ (BOOL)dateIsWednesday:(NSDate *)date {
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==4;
}

+ (BOOL)dateIsThurday:(NSDate *)date {
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==5;
}

+ (BOOL)dateIsFriday:(NSDate *)date {
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==6;
}

+ (BOOL)dateIsSaturday:(NSDate *)date {
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==7;
}

@end

























