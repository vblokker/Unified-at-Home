//
//  ViewController.swift
//  Unified at Home
//
//  Created by Vincent Blokker on 06/04/16.
//  Copyright © 2016 Vincent Blokker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeFront: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func updateTime(){
        timeFront.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
    }
    
}

