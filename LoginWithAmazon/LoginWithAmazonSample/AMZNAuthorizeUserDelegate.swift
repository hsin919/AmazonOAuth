//
//  AMZNAuthorizeUserDelegate.swift
//  LoginWithAmazonSample
//
//  Created by Z on 5/14/16.
//  Copyright © 2016 dereknetto. All rights reserved.
//

class AMZNAuthorizeUserDelegate: NSObject, AIAuthenticationDelegate {
    
    func requestDidSucceed(apiResult: APIResult!) {
        //Derek's code
//        let amazonGetProfileDelegate = AMZNGetProfileDelegate()
//        AIMobileLib.getProfile(amazonGetProfileDelegate)
   
        let amazonGetAccessTokenDelegate = AMZNGetAccessTokenDelegate()
        var requestScopes = ["alexa:all"]
        AIMobileLib.getAccessTokenForScopes(requestScopes, withOverrideParams: nil, delegate: amazonGetAccessTokenDelegate)
    }
    
    func requestDidFail(errorResponse: APIError!) {
        Alert.presentMessage(errorResponse.error.message, title: "User Authorization Failed")
    }
}
