
#import <UIKit/UIKit.h>

/*** 登录的接口 */
NSString * const TRLoginUrl = @"http://localhost:8080/TRMerchants/login";
/** 获取验证码的url */
NSString * const TRGetVcCodeUrl = @"http://yearwood.top/TRMerchants/sendmessage";

/** 注册的接口 */
NSString * const TRRegistUrl = @"http://yearwood.top/TRMerchants/regist";

/** 获取图片上传的token接口 */
NSString * const TRGetTokenUrl = @"http://localhost:8080/TRMerchants/gettoken";

/** 实名认证接口 */
NSString * const TRAuthenticationUrl = @"http://localhost:8080/TRMerchants/authentication";

/** 获取实名认证状态接口 */
NSString * const TRGetAuthenticationStateUrl = @"http://localhost:8080/TRMerchants/authorizationState";
