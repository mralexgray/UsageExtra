
@class                CPUMonitor ;
@interface UsageExtraAppDelegate : NSObject <NSApplicationDelegate>
{
                    NSStatusItem * item;
                      CPUMonitor * cpu;
             LSSharedFileListRef   loginItems;
         LSSharedFileListItemRef   loginItem;
}

@property (weak) IBOutlet NSMenu * menu;
@property (nonatomic)       BOOL   openAtLogin;

- (IBAction)  openActivityMonitor:(id)x;
- (IBAction)         quitFromMenu:(id)x;

@end
