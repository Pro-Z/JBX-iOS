//
//  RequestModel.h


#import <Foundation/Foundation.h>

@interface RequestModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) NSString *msg;

@end

