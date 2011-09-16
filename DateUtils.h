//
//  DateUtils.h
//  Created by Rodrigo Neri on 11/26/10.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd;
+ (NSDate *)dateWithYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi;
+ (NSDate *)dateFromTZformat:(NSString *)date;
+ (NSString *)dateTZformat:(NSDate *)date;
+ (NSDate *)dateFromTimeFormat:(NSString *)date;
+ (NSString *)timeStringFromDate:(NSDate *)date;
+ (NSDateComponents *)componentsFromDate:(NSDate *)date;
+ (int)numOfDaysOnMonth:(NSDate *)date;
+ (int)dateCompareValue:(NSDate *)date;
+ (NSDate*)roundDate:(NSDate*)dateToRound withInterval:(int)minuteInterval;

@end
