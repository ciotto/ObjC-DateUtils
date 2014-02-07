#import <Foundation/Foundation.h>
#import "DateUtils.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	NSDate *testDate;
    NSDate *testDate2;
    NSDate *testDate3;
	NSString *testDateStr;
	
	testDate = [DateUtils dateWithYear:1987 month:3 day:10];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-10T00:00:00Z"]);

	testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-10T08:36:00Z"]);
    
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-10T08:36:23Z"]);
	
	NSDate *testDateB = [DateUtils dateFromTZformat:testDateStr];
	assert([DateUtils dateCompareValue:testDate] == [DateUtils dateCompareValue:testDateB]);
	
	NSDateComponents *components = [DateUtils componentsFromDate:testDateB];
	assert([components year] == 1987);
	assert([components month] == 3);
	assert([components day] == 10);
	assert([components hour] == 8);
	assert([components minute] == 36);
    assert([components second] == 23);
	
	int monthDaysCount = [DateUtils numOfDaysOnMonth:testDate];
	assert(monthDaysCount == 31);
    int bissextileDaysCount = [DateUtils numOfDaysOnMonth:[DateUtils dateWithYear:2004 month:2 day:10]];
	assert(bissextileDaysCount == 29);
    int notBissextileDaysCount = [DateUtils numOfDaysOnMonth:[DateUtils dateWithYear:2005 month:2 day:10]];
	assert(notBissextileDaysCount == 28);
	
	testDate = [DateUtils roundDate:testDate withInterval:5];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-10T08:35:00Z"]);

	testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:39];
	testDateB = [DateUtils roundDate:testDate withInterval:5];
	testDateStr = [DateUtils dateTZformat:testDateB];
	assert([testDateStr isEqualToString:@"1987-03-10T08:40:00Z"]);
	
	testDate = [DateUtils dateFromTimeFormat:@"08:36:00"];
	testDateStr = [DateUtils dateTZformat:testDate]; 
	assert([testDateStr isEqualToString:@"1970-01-01T08:36:00Z"]);
	
	testDateStr = [DateUtils timeStringFromDate:testDate];
	assert([testDateStr isEqualToString:@"08:36:00"]);
    
    testDate = [DateUtils dateWithYear:1987 month:3 day:10];
    testDate2 = [DateUtils dateWithYear:1987 month:3 day:9];
    testDate3 = [DateUtils dateWithYear:1987 month:3 day:11];
	assert([DateUtils date:testDate isBetweenDate:testDate2 :testDate3]);
    testDate = [DateUtils dateFromTimeFormat:@"08:36:01"];
    testDate2 = [DateUtils dateFromTimeFormat:@"08:36:00"];
    testDate3 = [DateUtils dateFromTimeFormat:@"08:36:02"];
	assert([DateUtils date:testDate isBetweenDate:testDate2 :testDate3]);
    
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingYear:2 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1989-03-10T08:36:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingMonth:13 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1988-04-10T08:36:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingDay:32 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-04-11T08:36:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingHour:25 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-11T09:36:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingMinute:61 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-10T09:37:23Z"]);
    testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36 second:23];
    testDate = [DateUtils dateByAddingSecond:61 toDate:testDate];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-10T08:37:24Z"]);
    
    
    
    
    
    

    [pool drain];
    return 0;
}
