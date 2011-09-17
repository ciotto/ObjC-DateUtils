//
//  DateUtils.h
//  Created by Rodrigo Neri on 11/26/10.
//	https://github.com/rigoneri/ObjC-DateUtils
//	
//	Copyright (c) 2011, Rodrigo Neri <@rigoneri>
//	
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//	
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//	
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
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
