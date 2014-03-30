
#import "CPUMonitor.h"
#import "UsageExtraAppDelegate.h"

@implementation UsageExtraAppDelegate

- (void) applicationDidFinishLaunching:(NSNotification*)n {

  item                = [NSStatusBar.systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
  item.menu           = _menu;
  [item bind:@"title" toObject:cpu = CPUMonitor.new withKeyPath:@"usage" options:nil];
  item.highlightMode  =
  self.openAtLogin    = YES;
}

- (void)      setOpenAtLogIn:(BOOL)o  {

  if ((_openAtLogin = o)) {

    if ((loginItems = LSSharedFileListCreate( kCFAllocatorDefault, kLSSharedFileListSessionLoginItems, NULL)))

      loginItem = LSSharedFileListInsertItemURL( loginItems, kLSSharedFileListItemLast, NULL, NULL,
                                      (__bridge CFURLRef)NSBundle.mainBundle.bundleURL, NULL, NULL);
  } else if (!loginItems||!loginItem)

    LSSharedFileListItemRemove(loginItems, loginItem);
}
- (void) openActivityMonitor:(id)x    {

  [NSWorkspace.sharedWorkspace launchAppWithBundleIdentifier:@"com.apple.ActivityMonitor" options:0 additionalEventParamDescriptor:nil launchIdentifier:NULL];
}
- (void)        quitFromMenu:(id)x    { self.openAtLogin = NO; [NSApp terminate:x]; }

@end

int main(int argc, char const *argv[]) { @autoreleasepool {

    [NSUserDefaults.standardUserDefaults registerDefaults:@{@"normalizeCPUUsage":@YES}];
  }
  return NSApplicationMain(argc, argv);
}
