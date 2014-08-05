/*╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
  ║ NetworkClock.h                                                                                   ║
  ║                                                                                                  ║
  ║ Created by Gavin Eadie on Oct17/10                                                               ║
  ║ Copyright 2010 Ramsay Consulting. All rights reserved.                                           ║
  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝*/
@protocol GetNTPDateDelegate <NSObject>
-(void)getNTPDate:(NSDate *)date;
@end

@protocol InternalGetDateDelegate <NSObject>
-(void)internalGetDateDelegate:(NSDate *)date;
@end

#import "NetAssociation.h"
#import "NetworkClock.h"

