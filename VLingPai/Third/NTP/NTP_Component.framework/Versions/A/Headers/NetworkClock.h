/*╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
  ║ NetworkClock.h                                                                                   ║
  ║                                                                                                  ║
  ║ Created by Gavin Eadie on Oct17/10                                                               ║
  ║ Copyright 2010 Ramsay Consulting. All rights reserved.                                           ║
  ╚══════════════════════════════════════════════════════════════════════════════════════════╝*/
#import "ios-ntp.h"
#import <Foundation/Foundation.h>
#import <CFNetwork/CFNetwork.h>
#import "AsyncUdpSocket.h"
#import "NetAssociation.h"
#import <UIKit/UIApplication.h>

/*┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ┃ The NetworkClock sends notifications of the network time.  It will attempt to provide a very     ┃
  ┃ early estimate and then refine that and reduce the number of notifications ...                   ┃
  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛*/ 
@class InternalGetDateDelegate;

@interface NetworkClock : NSObject<InternalGetDateDelegate>
{

    NSTimeInterval          timeIntervalSinceDeviceTime;

    NSMutableArray *        timeAssociations;    
    id<GetNTPDateDelegate> getNTPDateDelegate;
  

@private
    
    NSSortDescriptor *      dispersionSortDescriptor;
    NSArray *               sortDescriptors;
    
    
}
+ (NetworkClock *) sharedNetworkClock;

@property(nonatomic,retain)id<GetNTPDateDelegate> getNTPDateDelegate;

- (void) createAssociations;
- (void) reportAssociations;
- (void) finishAssociations;

//- (NSDate *) networkTime;
//用于访问网络,返回日期
-(void)updateDate;
@end