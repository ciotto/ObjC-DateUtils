//
//  DateUtilsTests.m
//  DateUtilsTests
//
//  Created by Christian Bianciotto on 10/02/14.
//
//

#import <XCTest/XCTest.h>

#import "DateUtils.h"

@interface DateUtilsTests : XCTestCase

@end

@implementation DateUtilsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test
{
	NSDate *testDate;
    NSDate *testDate2;
    NSDate *testDate3;
	NSString *testDateStr;
	
	testDate = [DateUtils dateWithYear:1987 month:3 day:10];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1987-03-10T00:00:00Z"]);
    
	testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1987-03-10T08:36:00Z"]);
    
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1987-03-10T08:36:23Z"]);
	
	NSDate *testDateB = [DateUtils dateFromTZformat:testDateStr];
	XCTAssert([DateUtils dateCompareValue:testDate] == [DateUtils dateCompareValue:testDateB]);
	
	NSDateComponents *components = [DateUtils componentsFromDate:testDateB];
	XCTAssert([components year] == 1987);
	XCTAssert([components month] == 3);
	XCTAssert([components day] == 10);
	XCTAssert([components hour] == 8);
	XCTAssert([components minute] == 36);
    XCTAssert([components second] == 23);
	
	int monthDaysCount = [DateUtils numOfDaysOnMonth:testDate];
	XCTAssert(monthDaysCount == 31);
    int bissextileDaysCount = [DateUtils numOfDaysOnMonth:[DateUtils dateWithYear:2004 month:2 day:10]];
	XCTAssert(bissextileDaysCount == 29);
    int notBissextileDaysCount = [DateUtils numOfDaysOnMonth:[DateUtils dateWithYear:2005 month:2 day:10]];
	XCTAssert(notBissextileDaysCount == 28);
	
	testDate = [DateUtils roundDate:testDate withInterval:5];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1987-03-10T08:35:00Z"]);
    
	testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:39];
	testDateB = [DateUtils roundDate:testDate withInterval:5];
	testDateStr = [DateUtils dateTZformat:testDateB];
	XCTAssert([testDateStr isEqualToString:@"1987-03-10T08:40:00Z"]);
	
	testDate = [DateUtils dateFromTimeFormat:@"08:36:00"];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1970-01-01T08:36:00Z"]);
	
	testDateStr = [DateUtils timeStringFromDate:testDate];
	XCTAssert([testDateStr isEqualToString:@"08:36:00"]);
    
    testDate = [DateUtils dateWithYear:1987 month:3 day:10];
    testDate2 = [DateUtils dateWithYear:1987 month:3 day:10];
    testDate3 = [DateUtils dateWithYear:1987 month:3 day:10];
	XCTAssert([DateUtils date:testDate isBetweenDate:testDate2 :testDate3]);
    testDate = [DateUtils dateFromTimeFormat:@"08:36:01"];
    testDate2 = [DateUtils dateFromTimeFormat:@"08:36:00"];
    testDate3 = [DateUtils dateFromTimeFormat:@"08:36:02"];
	XCTAssert([DateUtils date:testDate isBetweenDate:testDate2 :testDate3]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10];
    testDate2 = [DateUtils dateWithYear:1987 month:3 day:10];
    testDate3 = [DateUtils dateWithYear:1987 month:3 day:11];
	XCTAssert(![DateUtils date:testDate isBetweenDate:testDate2 :testDate3 includeExtremes:NO]);
    
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingYear:2 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1989-03-10T08:36:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingMonth:13 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1988-04-10T08:36:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingDay:32 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1987-04-11T08:36:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingHour:25 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1987-03-11T09:36:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingMinute:61 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1987-03-10T09:37:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingSecond:61 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	XCTAssert([testDateStr isEqualToString:@"1987-03-10T08:37:24Z"]);
    
    testDate = [DateUtils dateWithYear:2014 month:4 day:20 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:4 day:21 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2013 month:3 day:31 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2013 month:4 day:1 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2423 month:4 day:2 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2423 month:4 day:3 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    
    testDate = [DateUtils dateWithYear:2014 month:1 day:1 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:1 day:6 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:4 day:25 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:5 day:1 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:6 day:2 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:8 day:15 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:11 day:1 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:12 day:8 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:12 day:25 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    testDate = [DateUtils dateWithYear:2014 month:12 day:26 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsHoliday:testDate withLocale:[NSLocale localeWithLocaleIdentifier:@"IT_it"]]);
    
    testDate = [DateUtils dateWithYear:2014 month:2 day:9 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsSunday:testDate]);
    testDate = [DateUtils dateWithYear:2014 month:2 day:10 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsMonday:testDate]);
    testDate = [DateUtils dateWithYear:2014 month:2 day:11 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsTuesday:testDate]);
    testDate = [DateUtils dateWithYear:2014 month:2 day:12 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsWednesday:testDate]);
    testDate = [DateUtils dateWithYear:2014 month:2 day:13 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsThurday:testDate]);
    testDate = [DateUtils dateWithYear:2014 month:2 day:14 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsFriday:testDate]);
    testDate = [DateUtils dateWithYear:2014 month:2 day:15 hour:8 minute:36 second:23];
	XCTAssert([DateUtils dateIsSaturday:testDate]);
}

@end
