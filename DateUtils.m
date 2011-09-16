//
//  DateUtils.h
//  Created by Rodrigo Neri on 11/26/10.
//

#import "DateUtils.h"

@implementation DateUtils

//
//	Returns a date object from year, month and day int values.
//
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
	NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
	[dateFormatter setLocale:locale];
	return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,12,00,00", yyyy, mm, dd]];
}


//
//  Returns a date object from year, month, day, hour and minute int values.
//
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
	[dateFormatter setLocale:locale];
	return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,%d,%d,00", yyyy, mm, dd, hh, mi]];
}

//
//	Returns a date object from a ISO 8601 date string.
//
+ (NSDate *)dateFromTZformat:(NSString *)date {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm'Z'"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
	[dateFormatter setLocale:locale];
	return [dateFormatter dateFromString:date];
}

//
//  Returns a ISO 8601 date string from a date object. 
//
+ (NSString *)dateTZformat:(NSDate *)date {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm'Z'"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
	[dateFormatter setLocale:locale];
	return [dateFormatter stringFromDate:date];
}

//
//	Returns a date object from a time string.
//
+ (NSDate *)dateFromTimeFormat:(NSString *)date {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"HH:mm"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
	[dateFormatter setLocale:locale];
	return [dateFormatter dateFromString:date];
}

//
//	Returns a time string from a date object.
//
+ (NSString *)timeStringFromDate:(NSDate *)date {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"HH:mm"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
	[dateFormatter setLocale:locale];
	return [dateFormatter stringFromDate:date];
}

//
//	Returns a NSDateComponents object from a date.
//
+ (NSDateComponents *)componentsFromDate:(NSDate *)date {
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	[gregorian setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	return [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
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
	[dateFormatter setDateFormat:@"yyyyMMdd"];
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
