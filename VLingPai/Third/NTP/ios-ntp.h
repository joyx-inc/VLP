/*╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
  ║ NetworkClock.h                                                                                   ║
  ║                                                                                                  ║
  ║ Created by Gavin Eadie on Oct17/10                                                               ║
  ║ Copyright 2010 Ramsay Consulting. All rights reserved.                                           ║
  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝*/

//使用对象只要实现这个代理就可以了
@protocol GetNTPDateDelegate <NSObject>
-(void)getNTPDate:(NSDate *)date;
@end




@protocol InternalGetDateDelegate <NSObject>
-(void)internalGetDateDelegate:(NSDate *)date;
@end

#import "NetAssociation.h"
#import "NetworkClock.h"

