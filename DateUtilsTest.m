#import <Foundation/Foundation.h>
#import "DateUtils.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	NSDate *testDate;
	NSString *testDateStr;
	
	testDate = [DateUtils dateWithYear:1987 month:3 day:10];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-10T18:00Z"]);

	testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:36];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-10T08:36Z"]);
	
	NSDate *testDateB = [DateUtils dateFromTZformat:testDateStr];
	assert([DateUtils dateCompareValue:testDate] == [DateUtils dateCompareValue:testDateB]);
	
	NSDateComponents *components = [DateUtils componentsFromDate:testDateB];
	assert([components year] == 1987);
	assert([components month] == 3);
	assert([components day] == 10);
	assert([components hour] == 8);
	assert([components minute] == 36);
	
	int monthDaysCount = [DateUtils numOfDaysOnMonth:testDate];
	assert(monthDaysCount == 31);
	
	testDate = [DateUtils roundDate:testDate withInterval:5];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1987-03-10T08:35Z"]);

	testDate = [DateUtils dateWithYear:1987 month:3 day:10 hour:8 minute:39];
	testDateB = [DateUtils roundDate:testDate withInterval:5];
	testDateStr = [DateUtils dateTZformat:testDateB];
	assert([testDateStr isEqualToString:@"1987-03-10T08:40Z"]);
	
	testDate = [DateUtils dateFromTimeFormat:@"08:36"];
	testDateStr = [DateUtils dateTZformat:testDate];
	assert([testDateStr isEqualToString:@"1970-01-01T08:36Z"]);
	
	testDateStr = [DateUtils timeStringFromDate:testDate];
	assert([testDateStr isEqualToString:@"08:36"]);

    [pool drain];
    return 0;
}
