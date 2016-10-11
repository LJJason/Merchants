
#import <UIKit/UIKit.h>

/*** 登录的接口 */
NSString * const TRLoginUrl = @"http://yearwood.top/TRMerchants/login";
/** 获取验证码的url */
NSString * const TRGetVcCodeUrl = @"http://yearwood.top/TRMerchants/sendmessage";

/** 注册的接口 */
NSString * const TRRegistUrl = @"http://yearwood.top/TRMerchants/regist";

/** 获取图片上传的token接口 */
NSString * const TRGetTokenUrl = @"http://yearwood.top/TRMerchants/gettoken";

/** 实名认证接口 */
NSString * const TRAuthenticationUrl = @"http://yearwood.top/TRMerchants/authentication";

/** 获取实名认证状态接口 */
NSString * const TRGetAuthenticationStateUrl = @"http://yearwood.top/TRMerchants/authorizationState";

/** 添加房间接口 */
NSString * const TRAddRoomUrl = @"http://yearwood.top/TRMerchants/addroom";

/** 查看房间接口 */
NSString * const TRRoomUrl = @"http://yearwood.top/TRMerchants/getAllRoom";


/** 删除房间接口 */
NSString * const TRDeleteRoomUrl = @"http://yearwood.top/TRMerchants/deleteRoom";
