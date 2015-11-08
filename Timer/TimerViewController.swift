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
  @IBOutlet var secondCircle: CircleView!
  @IBOutlet var minuteCircle: CircleView!
  @IBOutlet var hourCircle: CircleView!

  var timer = NSTimer()
  let timerPickerData = [Array(1...24), Array(1...60), Array(1...60)]
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureView()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationHasChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
  }

  func configureView() {
    secondCircle.backgroundColor = UIColor.clearColor()
    minuteCircle.backgroundColor = UIColor.clearColor()
    hourCircle.backgroundColor = UIColor.clearColor()
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
      if (minutesSelectedRow < 0)
      {
        minutesSelectedRow = timerPickerData[Component.Minutes.rawValue].count - 1
        hoursSelectedRow--
        if (hoursSelectedRow < 0)
        {
          hoursSelectedRow = timerPickerData[Component.Hours.rawValue].count - 1
        }
        self.timerPickerView.selectRow(hoursSelectedRow, inComponent: Component.Hours.rawValue, animated: false)
      }
      self.timerPickerView.selectRow(minutesSelectedRow, inComponent: Component.Minutes.rawValue, animated: false)
    }
    self.timerPickerView.selectRow(secondsSelectedRow, inComponent: Component.Seconds.rawValue, animated: false)
    
    drawCicles()
  }
  
  func drawCicles() {
    let secondsSelectedRow = timerPickerView.selectedRowInComponent(Component.Seconds.rawValue)
    let minuteSelectedRow = timerPickerView.selectedRowInComponent(Component.Minutes.rawValue)
    let hourSelectedRow = timerPickerView.selectedRowInComponent(Component.Hours.rawValue)
    
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    secondCircle.circleLayer.strokeEnd =
      CGFloat(timerPickerData[Component.Seconds.rawValue].count - secondsSelectedRow) / CGFloat(timerPickerData[Component.Seconds.rawValue].count)
    minuteCircle.circleLayer.strokeEnd =
      CGFloat(timerPickerData[Component.Minutes.rawValue].count - minuteSelectedRow) / CGFloat(timerPickerData[Component.Minutes.rawValue].count)
    hourCircle.circleLayer.strokeEnd =
      CGFloat(timerPickerData[Component.Hours.rawValue].count - hourSelectedRow) / CGFloat(timerPickerData[Component.Hours.rawValue].count)
    CATransaction.commit()
  }
  
  func orientationHasChanged()
  {
    secondCircle.drawRect(secondCircle.frame)
    minuteCircle.drawRect(minuteCircle.frame)
    hourCircle.drawRect(hourCircle.frame)
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
  
  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView{
    var pickerLabel = view as? UILabel;
  
    if (pickerLabel == nil) {
      pickerLabel = UILabel()
      pickerLabel?.font = UIFont(name: "SlimJoe_NOT", size: 30.0)
      pickerLabel?.textColor = UIColor.whiteColor()
      pickerLabel?.textAlignment = NSTextAlignment.Center
    }

    pickerLabel?.text = String(format:"%02d", timerPickerData[component][row])
    return pickerLabel!;
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    drawCicles()
  }


  //MARK: - Actions
  @IBAction func timerButtonPressed(sender: UIButton) {
    if timerButton.titleLabel?.text == "START" {
      timerButton.setTitle("STOP", forState: UIControlState.Normal)
      timer = NSTimer.scheduledTimerWithTimeInterval(1/100, target: self, selector: "countDown", userInfo: nil, repeats: true)
      NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    else {
      timerButton.setTitle("START", forState: UIControlState.Normal)
      timer.invalidate()
    }
  }
  
 
}

