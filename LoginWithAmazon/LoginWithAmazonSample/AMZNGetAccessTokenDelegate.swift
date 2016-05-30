//
//  AMZNGetAccessTokenDelegate.swift
//  LoginWithAmazonSample
//
//  Created by Z on 5/14/16.
//  Copyright © 2016 dereknetto. All rights reserved.
//

class AMZNGetAccessTokenDelegate: NSObject, AIAuthenticationDelegate {
    
    func requestDidSucceed(apiResult: APIResult!) {
        //Derek's code
//                let amazonGetProfileDelegate = AMZNGetProfileDelegate()
//                AIMobileLib.getProfile(amazonGetProfileDelegate)
        
        let accessToken = apiResult.result;
        print(accessToken)
    }
    
    func requestDidFail(errorResponse: APIError!) {
        Alert.presentMessage(errorResponse.error.message, title: "Please Login")
    }

}

//Other methods
//- `[AIMobileLib authorizeUserForScopes:delegate:]` : Passes `nil` as the result to the delegate.
//- `[AIMobileLib getAccessTokenForScopes:withOverrideParams:delegate:]` : Passes an access token as an `NSString` object
//to the delegate.
//- `[AIMobileLib clearAuthorizationState:]` : Passes nil as the result to the delegate.
//- `[AIMobileLib getProfile:]` : Passes profile data in an `NSDictionary` object to the delegate. See the API description