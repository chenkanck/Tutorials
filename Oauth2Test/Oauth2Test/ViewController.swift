//
//  ViewController.swift
//  Oauth2Test
//
//  Created by Kan Chen on 4/12/16.
//  Copyright © 2016 Kan Chen. All rights reserved.
//

import UIKit
import OAuthSwift
import Swifter

class ViewController: UIViewController {
    var oauthSwift: OAuth2Swift?
    @IBOutlet weak var oAuthWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let server = HttpServer()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickedOAuth2Drchrono(sender: AnyObject) {
        oauthSwift = OAuth2Swift(
            consumerKey:    "BCRUydURlon2ZfbeM8d0T4z92iXiqvu0wAdZRXZX",
            consumerSecret: "w9gVFrmnGzkx38mmtkGwjQFNxxXh9CoqCOCMdeGJr3uJcq1LnvUxp5LqHKqusTZSWZ2KAFnlOE3WXU0QEKu1eVX2He1w5qNPOTLadxKqPNHEZBvfOlitts3Lj5NDkrAf",
            authorizeUrl:   "http://drchrono.l/o/authorize/",
            accessTokenUrl: "http://drchrono.l/o/token/",
            responseType:   "code"
        )
        oauthSwift!.authorize_url_handler = SafariURLHandler(viewController: self)
        oauthSwift!.authorizeWithCallbackURL(NSURL(string: "drchrono-ios://oauth-callback/oauth-swift-test")!, scope: "", state: "state", success: { (credential, response, parameters) in
            print(credential)
            print(response)
            print(parameters)
        }) { (error) in
            print(error.localizedDescription)
        }

    }

    @IBAction func clickCurrentPatient(sender: AnyObject) {
        oauthSwift?.client.get("http://drchrono.l/api/users/current", success: { (data, response) in
            print(data)
            print(response)
            }, failure: { (error) in
                print(error.localizedDescription)
        })
    }

    @IBAction func clickedOAuth2(sender: AnyObject) {
        oauthSwift = OAuth2Swift(
            consumerKey:    "vza10z0rws17s78",
            consumerSecret: "kio61715su7p281",
            authorizeUrl:   "https://www.dropbox.com/1/oauth2/authorize",
            accessTokenUrl: "https://api.dropbox.com/1/oauth2/token",
            responseType:   "token"
        )

        oauthSwift!.authorize_url_handler = get_url_handler()
        oauthSwift!.authorizeWithCallbackURL(NSURL(string: "Oauth2Test://oauth-callback/dropbox")!, scope: "", state: "", success: { (credential, response, parameters) in
                print(credential)
                print(response)
                print(parameters)
            }) { (error) in
                print(error.localizedDescription)
        }
    }

    func get_url_handler() -> OAuthSwiftURLHandlerType {
        // Create a WebViewController with default behaviour from OAuthWebViewController
        let url_handler = createWebViewController()
        return url_handler
    }

    func createWebViewController() -> WebViewController {
        let controller = WebViewController()
        return controller
    }
}

