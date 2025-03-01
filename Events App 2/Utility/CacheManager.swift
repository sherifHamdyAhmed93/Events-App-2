//
//  CacheManager.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 01/03/2025.
//

import Foundation

class CacheManager{
    static let shared = CacheManager()
    
    private var cache = NSCache<NSString,AnyObject>()
    
    private init(){}
    
    func saveObject(key:String , object:AnyObject){
        cache.setObject(object, forKey: key as NSString)
    }
    
    func getObject(key:String)->AnyObject?{
        return cache.object(forKey: key as NSString)
    }
    
}
