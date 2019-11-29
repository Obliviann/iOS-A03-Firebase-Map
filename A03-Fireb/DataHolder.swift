//
//  DataHolder.swift
//  A03-Fireb
//
//  Created by Olivia Sartorius Freschet on 28/11/19.
//  Copyright © 2019 Olivia. All rights reserved.
//

import UIKit
//2.
import Firebase

class DataHolder: NSObject {
    
    //1. Defino una var estática que apunta a una instancia de objeto de sí mismo.
    static let sharedInstance:DataHolder = DataHolder()
    //3. var to handle the AUTHENTICATION STATE LISTENER
    var handle: AuthStateDidChangeListenerHandle?
    
    //2.
    func initFirebase() {
        //use Firebase lib to configure APIs
        FirebaseApp.configure()
    }
    
    //3.
    func didUserStateChange() {
        //We set a listener on the FIRAuth obj go get current USER STATE
        //this listener gets called whenever the user's sing-in state changes
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
    //self.gitHubProvider = OAuthProvider(providerID:"github.com");
    }
    
    func detachStateListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}
