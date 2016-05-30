//
//  AMZNLoginViewController.swift
//  LoginWithAmazonSample
//
//  Created by Z on 5/14/16.
//  Copyright © 2016 dereknetto. All rights reserved.
//

import UIKit

class AMZNLoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    
    var productId: String = ""
    var deviceSerialNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(AMZNLoginViewController.updateInfoLabels(_:)), name: "UserSuccessfullyLoggedIn", object: nil)
         notificationCenter.addObserver(self, selector: #selector(AMZNLoginViewController.clearInfoLabels(_:)), name: "UserSuccessfullyLoggedOut", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkIsUserSignedIn()
    }
    
    @IBAction func loginButtonTouched(sender: UIButton) {
        //Derek's code
//        let amazonAuthorizeUserDelegate = AMZNAuthorizeUserDelegate();
//        let requestScopes = ["profile","postal_code"]
//        AIMobileLib.authorizeUserForScopes(requestScopes, delegate: amazonAuthorizeUserDelegate)
        
        
        var options = [String: AnyObject]()
        
        let amazonAuthorizeUserDelegate = AMZNAuthorizeUserDelegate()
        
        let requestScopes = ["alexa:all"]
        
        let scopeData = String(format:"{\"alexa:all\":{\"productID\":\"%@\", ", "\"productInstanceAttributes\":{\"deviceSerialNumber\":\"%@\"}}}",
                               productId, deviceSerialNumber)
        
        options[kAIOptionScopeData] = scopeData
        
        
        AIMobileLib.authorizeUserForScopes(requestScopes, delegate: amazonAuthorizeUserDelegate, options: options)
        
        //Objective-C code
        //        NSArray requestScopes = [NSArray arrayWithObjects:@"alexa:all", nil];
        //        NSMutableDictionary options = [[NSMutableDictionary alloc] init];
        //
        //        NSString* scopeData = [NSString stringWithFormat:@"{\"alexa:all\":{\"productID\":\"%@\", "
        //        "\"productInstanceAttributes\":{\"deviceSerialNumber\":\"%@\"}}}",
        //        productId, deviceSerialNumber];
        //
        //        options[kAIOptionScopeData] = scopeData;
        //
        //        AuthorizeUserDelegate* delegate = [AuthorizeUserDelegate alloc];
        //
        //        [AIMobileLib authorizeUserForScopes:requestScopes delegate:delegate options:options];
    }
    
    @IBAction func logoutButtonTouched(sender: UIBarButtonItem) {
        let amazonLogoutDelegate = AMZNLogoutDelegate()
        AIMobileLib.clearAuthorizationState(amazonLogoutDelegate)
    }
    
    func checkIsUserSignedIn() {
        
        //Derek's code
        //let requestScopes = ["profile","postal_code"]
        //let amazonGetAccessTokenDelegate = AMZNGetAccessTokenDelegate()
       //AIMobileLib.getAccessTokenForScopes(requestScopes, withOverrideParams: nil, delegate: amazonGetAccessTokenDelegate)
        
        
        let amazonGetAccessTokenDelegate = AMZNGetAccessTokenDelegate()
        let requestScopes = ["alexa:all"]
        AIMobileLib.getAccessTokenForScopes(requestScopes, withOverrideParams: nil, delegate: amazonGetAccessTokenDelegate)
        
        //Objective-C code
//        GetAccessTokenDelegate* delegate = [GetAccessTokenDelegate alloc];
//        
//        NSArray *requestScopes = [NSArray arrayWithObjects:@"alexa:all", nil];
//        
//        [AIMobileLib getAccessTokenForScopes:requestScopes withOverrideParams:nil delegate:delegate];

    }
    
    func updateInfoLabels(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: String]
        
        self.nameLabel.text = "Name: " + userInfo["name"]!
        self.userIDLabel.text = "UserID: " + userInfo["user_id"]!
        self.emailLabel.text  = "Email: " + userInfo["email"]!
        
        if let postalCode = userInfo["postal_code"]{ 
            self.postalCodeLabel.text = "Postal Code: " + postalCode
        }
    }
    
    func clearInfoLabels(notification: NSNotification){
        self.nameLabel.text = "Name: "
        self.userIDLabel.text = "UserID: "
        self.emailLabel.text = "Email: "
        self.postalCodeLabel.text = "Postal Code: "
    }
}
