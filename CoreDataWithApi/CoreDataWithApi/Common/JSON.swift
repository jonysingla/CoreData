//
//  JSON.swift
//
//  Created by day on 28/09/17.
//  Copyright © 2017 day. All rights reserved.
//
import Foundation

// Helper methods
public struct JSON {
    
    /*
     do{
     json = try (NSJSONSerialization.JSONObjectWithData(pollData, options: .MutableLeaves) as? NSDictionary)!
     }catch let errJSON as NSError{
     err = errJSON
     }
     */
    /*
     self.id = JSON.Int32ValueForKey(json, key: "id")
     self.name = JSON.StringValueForKey(json, key: "name")
     */
    
    
    public static func DictionaryForJSONString(data:String) -> NSDictionary? {
        var json:NSDictionary?
        
        do{
            json = try (JSONSerialization.jsonObject(with: data.data(using: String.Encoding.utf8)!, options: .mutableContainers) as? NSDictionary)!
        }catch _ as NSError{
            //print(errJSON)
        }
        
        return json
        
        
    }
    
    public static func DictionaryForJSONData(data:NSData) -> NSDictionary? {
        var json:NSDictionary?
        
        do{
            json = try (JSONSerialization.jsonObject(with: data as Data, options: .mutableLeaves) as? NSDictionary)!
        }catch _ as NSError{
            //print(errJSON)
        }
        
        return json
    }
    
    
    public static func StringValueForJSONDictionary(dict:NSDictionary ) -> String {
        var val:String = ""
        let theJSONData = try!JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions(rawValue: 0))
        val = NSString(data: theJSONData, encoding: String.Encoding.utf8.rawValue)! as String
        return val
    }
    
    
//    public static func encodeString(str:String) -> String!
//    {
//
//        return str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
//    }
    
    public static func StringValueForKey(json:NSDictionary, key:String ) -> String {
        var val:String = ""
        if let keyVal = json[key] {
            // All good
            val = "\(keyVal)"
        }
        
        if val == "<null>" || val == "null"{
            val = ""
        }
        
        return val
    }
    
    public static func IntValueForKey(json:NSDictionary, key:String ) -> Int {
        var val:Int = 0
        if let keyVal = json[key] as? Int {
            // All good
            val = keyVal
        }
        else if let keyVal = json[key] as? String {
            // try parsing
            if let parseVal = Int(keyVal)
            {
                val = parseVal
            }
        }
        
        return val
    }
    
    
    public static func Int32ValueForKey(json:NSDictionary, key:String ) -> Int32 {
        var val:Int32 = 0
        if let keyVal = json[key] as? Int32 {
            // All good
            val = keyVal
        }
        else if let keyVal = json[key] as? String {
            // try parsing
            if let parseVal = Int32(keyVal)
            {
                val = parseVal
            }
        }
        
        return val
    }
    
    public static func BoolValueForKey(json:NSDictionary, key:String ) -> Bool {
        var val:Bool = false
        if let keyVal = json[key] as? Bool {
            // All good
            val = keyVal
        }
        
        return val
    }
    
    public static func DoubleValueForKey(json:NSDictionary, key:String ) -> Double {
        var val:Double = 0
        if let keyVal = json[key] as? Double {
            // All good
            val = keyVal
        }
        else if let keyVal = json[key] as? Double {
            // try parsing
            val = Double(keyVal)
        }
        else if let keyVal = json[key] as? String {
            // try parsing
            val = Double(keyVal)!
        }
        else {
            // last resort, try as an int and then use it, if not, just pass back 0
            val = Double( IntValueForKey(json: json, key: key))
        }
        
        return val
    }
    
    public static func MutableArrayValueForKey(json:NSDictionary, key:String ) -> NSMutableArray {
        var val:NSMutableArray = []
        if let keyVal = json[key] as? NSMutableArray {
            // All good
            val = keyVal
        }
        return val
    }
    
    public static func ArrayValueForKey(json:NSDictionary, key:String ) -> NSArray {
        var val:NSArray = []
        if let keyVal = json[key] as? NSArray {
            // All good
            val = keyVal
        }
        return val
    }
    
    public static func MutableDictionaryValueForKey(json:NSDictionary, key:String ) -> NSMutableDictionary {
        var val:NSMutableDictionary = NSMutableDictionary()
        if let keyVal = json[key] as? NSMutableDictionary {
            // All good
            val = keyVal
        }
        return val
    }
    
    public static func DictionaryValueForKey(json:NSDictionary, key:String ) -> NSDictionary {
        var val:NSDictionary = NSDictionary()
        if let keyVal = json[key] as? NSDictionary {
            // All good
            val = keyVal
        }
        return val
    }
}

