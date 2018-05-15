//
//  ViewController.swift
//  SimpleAPIParser
//
//  Created by Karthick on 5/15/18.
//  Copyright © 2018 Karthick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //UnComment to parse to your appi response
  /*  let param = "username=123123&password=12312313&device_id=\(123)&device_type=\(12345)"
    ApiParser().apiCall(url:URL.HomeApi, parameter:param, methodType:"POST", CompletionHandler: {(dictionary) in
      print(dictionary)
      print(dictionary.object(forKey:"status") ?? "")
    })*/
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

