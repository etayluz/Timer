//
//  TimerViewController.swift
//  Timer
//
//  Created by Etay Luz on 11/6/15.
//  Copyright © 2015 Etay Luz. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
  @IBOutlet var timerPickerView: UIPickerView!
  
  let timerPickerData = [Array(1...24), Array(1...60), Array(1...60)]

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  //MARK: - UIPickerView Delegates and data sources
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return timerPickerData.count
  }
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return timerPickerData[component].count
  }
  
  func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 36.0
  }
  
  func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let titleData = String(format:"%02d", timerPickerData[component][row])
    let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SlimJoe", size: 30.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
    return myTitle
  }

}

