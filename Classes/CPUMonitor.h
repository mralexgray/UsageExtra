


@interface                CPUMonitor : NSObject

@property (readonly)        NSString * usage;
@property (nonatomic) NSTimeInterval   interval;
@property                    CGFloat   percent;
@property                       BOOL   normalize;

@end
