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

JSExportAs(share, - (void)share:(NSString *)title describeContent:(NSString *)content interlnkageSite:(NSString *)siteUrl pictureStie:(NSString *)pictureUrl);
-(void)callCameraOrPhotosLibrary:(int)type;
-(void)appLogin;
-(void)appLog;

-(void)getTitle:(NSString*)titleStr;
@end
@interface CMJsModel : NSObject<CMWebModelDelegate>
@property(nonatomic,weak) id<CMWebModelDelegate> delegate;
@end
