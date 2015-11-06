//
//  TimerViewController.swift
//  Timer
//
//  Created by Etay Luz on 11/6/15.
//  Copyright © 2015 Etay Luz. All rights reserved.
//

import UIKit

enum Component: Int {
  case Hours = 0, Minutes, Seconds
}


class TimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
  @IBOutlet var timerPickerView: UIPickerView!
  @IBOutlet var timerButton: UIButton!
  
  var timer = NSTimer()
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
  
  
//  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView{
//    var pickerLabel = view as? UILabel;
//  
//    if (pickerLabel == nil) {
//      pickerLabel = UILabel()
//      pickerLabel?.font = UIFont(name: "SlimJoe1", size: 30.0)
//      pickerLabel?.textColor = UIColor.whiteColor()
//      pickerLabel?.textAlignment = NSTextAlignment.Center
//    }
//
//    pickerLabel?.text = String(format:"%02d", timerPickerData[component][row])
//    return pickerLabel!;
//  }
  
  //MARK: - Actions
  @IBAction func timerButtonPressed(sender: UIButton) {
    if timerButton.titleLabel?.text == "START" {
      timerButton.setTitle("STOP", forState: UIControlState.Normal)
      timer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: "countDown", userInfo: nil, repeats: true)
      NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    else {
      timerButton.setTitle("START", forState: UIControlState.Normal)
      timer.invalidate()
    }
  }
  
  func countDown() {
    var secondsSelectedRow = timerPickerView.selectedRowInComponent(Component.Seconds.rawValue)
    var minutesSelectedRow = timerPickerView.selectedRowInComponent(Component.Minutes.rawValue)
    var hoursSelectedRow = timerPickerView.selectedRowInComponent(Component.Hours.rawValue)

    secondsSelectedRow--
    
    if (secondsSelectedRow < 0)
    {
      secondsSelectedRow = timerPickerData[Component.Seconds.rawValue].count - 1
      minutesSelectedRow--
    }
    if (minutesSelectedRow < 0)
    {
      minutesSelectedRow = timerPickerData[Component.Minutes.rawValue].count - 1
      hoursSelectedRow--
    }
    if (hoursSelectedRow < 0)
    {
      hoursSelectedRow = timerPickerData[Component.Hours.rawValue].count - 1
    }
    
    self.timerPickerView.selectRow(secondsSelectedRow, inComponent: Component.Seconds.rawValue, animated: false)
    self.timerPickerView.selectRow(minutesSelectedRow, inComponent: Component.Minutes.rawValue, animated: false)
    self.timerPickerView.selectRow(hoursSelectedRow, inComponent: Component.Hours.rawValue, animated: false)
    
  }
  
  

}

