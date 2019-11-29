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
    
    //2.
    func initFirebase() {
        FirebaseApp.configure()
    }
    
    //func ifUserStateChanges
}
