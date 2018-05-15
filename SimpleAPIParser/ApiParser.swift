//
//  ApiParser.swift
//  HalfFrame
//
//  Created by Karthick on 2/10/18.
//  Copyright © 2018 Karthick. All rights reserved.
//

import UIKit

class ApiParser: NSObject {
  
  func apiCall(url:String, parameter:String, methodType: String, CompletionHandler:@escaping(NSDictionary) ->()) {
    print("Call func")
    let encodeURL : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    print(encodeURL)
    print(parameter)
    
    var headers = NSDictionary()
    GlobalClass.sharedInstance.activity()
    
   
//      headers = ["Accept-Language": "en",
//                 "Authorization" : "Bearer \(UserDefaults.standard.object(forKey: Key.UserDefaults.accessToken) ?? "")"]

    headers = ["Accept-Language": "en",
               "User-Id" : "owbgkesbyhamryvr"]
    let sampleCall2 : SSHTTPClient  = SSHTTPClient(url: encodeURL , method: methodType, httpBody:parameter, headerFieldsAndValues: headers as? [String : String])
    sampleCall2.getJsonData { (obj, error) -> Void in
     // GlobalClass.sharedInstance.removeActivity()
      if error != nil {
        print(error ?? "no error")
      }else {
        print(obj ?? "")
        let dataDict = obj as! NSDictionary
        print(dataDict.object(forKey:"status") ?? "")
        if dataDict.object(forKey:"status") as! Int == 200 {
        CompletionHandler(dataDict)
        } else {
          DispatchQueue.main.async {
           self.showToast(message:dataDict.object(forKey:"message") as! String)
          }
        }
      }
    }
  }
  
  //MARK:- Upload Multipart data
  func apiCallMultipart(url:String, parameter:NSMutableDictionary, methodType: String, image:UIImage, CompletionHandler:@escaping(NSDictionary) ->()) {
    
     GlobalClass.sharedInstance.activity()
    let encodeURL : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    print(parameter)
    print(encodeURL)
    
    let url = URL(string:encodeURL);
    let request = NSMutableURLRequest(url: url!);
    request.httpMethod = "POST"
    let boundary = "Boundary-\(NSUUID().uuidString)"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    request.allHTTPHeaderFields = ["Accept-Language": "en","Authorization" : "Bearer your token"]
    let imageData = UIImageJPEGRepresentation(image, 1)
    if (imageData == nil) {
      print("UIImageJPEGRepresentation return nil")
      return
    }
    let body = NSMutableData()
    if parameter != nil {
      for (key, value) in parameter {
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
      }
    }
    body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
    
    body.append(NSString(format:"Content-Disposition: form-data; name=\"profile_image\"; filename=\"testfromios.jpg\"\r\n").data(using: String.Encoding.utf8.rawValue)!)
    body.append(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
    body.append(imageData!)
    body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
    
    request.httpBody = body as Data
    
    let task =  URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
      (data, response, error) -> Void in
      GlobalClass.sharedInstance.removeActivity() //Remove Activity
      if let data = data {
        //print(response as Any)
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        let dataDict = json as! NSDictionary
        print(dataDict)
        print(dataDict.object(forKey:"status") ?? "")
        
        if dataDict.object(forKey:"status") as! Int == 200 {
          CompletionHandler(dataDict)
        } else {
          DispatchQueue.main.async {
           self.showToast(message:dataDict.object(forKey:"message") as! String)
          }
        }
      } else if let error = error {
        print(error.localizedDescription)
      }
    })
    
    task.resume()
  }
  //MARK:- Toast view
  func showToast(message : String) {
    
    let lblHeight = self.height(constraintedWidth:UIScreen.main.bounds.size.width-40 , font:UIFont.regularFont12,text:message)
    
    let toastLabel = UILabel(frame: CGRect(x: 20, y: UIScreen.main.bounds.size.height-100, width: UIScreen.main.bounds.size.width-40, height:lblHeight+30))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont.regularFont12
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    toastLabel.numberOfLines = 0
    let view = UIApplication.shared.keyWindow!
    view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
      toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
      toastLabel.removeFromSuperview()
    })
  }
  
  //MARK:- label height calculate
  func height(constraintedWidth width: CGFloat, font: UIFont, text:String) -> CGFloat {
    let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.text = text
    label.font = font
    label.sizeToFit()
    return label.frame.height
  }
}

