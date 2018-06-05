//
//  CoreNavigation.swift
//  Catalogue
//
//  Created by Andriy BODNAR on 5/2/18.
//  Copyright © 2018 Andriy BODNAR. All rights reserved.
//

import UIKit

class CoreNavigation: UINavigationController {
    
    @IBOutlet weak var coreNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //init navbar style
        coreNavigationBar.barTintColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1)
        coreNavigationBar.isTranslucent = false
        coreNavigationBar.layer.shadowOpacity = 0
        coreNavigationBar.shadowImage = UIImage()
        coreNavigationBar.setBackgroundImage(UIImage(), for: .default)

    }

    
    
}
