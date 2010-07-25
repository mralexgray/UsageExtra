#import <mach/mach.h>

#import "UsageExtraAppDelegate.h"

@implementation UsageExtraAppDelegate

- (void)getProcessorUsage:(unsigned long *)outUsed total:(unsigned long *)outTotal
{
	natural_t cpuCount;
	processor_info_array_t infoArray;
	mach_msg_type_number_t infoCount;

	kern_return_t error = host_processor_info(mach_host_self(),
		PROCESSOR_CPU_LOAD_INFO, &cpuCount, &infoArray, &infoCount);
	if (error) {
		mach_error("host_processor_info error:", error);
		abort();
	}

	processor_cpu_load_info_data_t* cpuLoadInfo =
		(processor_cpu_load_info_data_t*) infoArray;

	unsigned long totalTicks = 0;
	unsigned long usedTicks = 0;

	for (int cpu=0; cpu<cpuCount; cpu++)
		for (int state=0; state<CPU_STATE_MAX; state++) {
			unsigned long ticks = cpuLoadInfo[cpu].cpu_ticks[state];
			
			if (state != CPU_STATE_IDLE) usedTicks += ticks;
			totalTicks += ticks;
		}

	*outUsed = usedTicks;
	*outTotal = totalTicks;

	vm_deallocate(mach_task_self(), (vm_address_t)infoArray, infoCount);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    
    item = [[bar statusItemWithLength:NSVariableStatusItemLength] retain];
    [item setTitle:@"CPU%"];
    [item setHighlightMode:YES];
    [item setMenu:menu];
    
    [self getProcessorUsage:&prevUsed total:&prevTotal];
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (void)update:(id)_
{
    unsigned long used, total;
    [self getProcessorUsage:&used total:&total];
    
    unsigned long diffUsed = used - prevUsed, diffTotal = total - prevTotal;
		
    prevUsed = used;
    prevTotal = total;
    
    [item setTitle:[NSString stringWithFormat:@"%d%%", (int)(100.0 * (double)diffUsed / (double)diffTotal)]];
}

@synthesize menu;

@end