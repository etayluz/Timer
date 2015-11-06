//
//  ViewController.swift
//  Timer
//
//  Created by Etay Luz on 11/6/15.
//  Copyright © 2015 Etay Luz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    

    for family: String in UIFont.familyNames()
    {
      print("\(family)")
      for names: String in UIFont.fontNamesForFamilyName(family)
      {
        print("== \(names)")
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

