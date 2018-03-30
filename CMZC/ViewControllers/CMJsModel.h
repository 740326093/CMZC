//
//  CMJsModel.h
//  CMZC
//
//  Created by WangWei on 2017/12/8.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol CMWebModelDelegate <JSExport,NSObject>


-(void)callCameraOrPhotosLibrary:(int)type;
@end
@interface CMJsModel : NSObject<CMWebModelDelegate>
@property(nonatomic,weak) id<CMWebModelDelegate> delegate;
@end
