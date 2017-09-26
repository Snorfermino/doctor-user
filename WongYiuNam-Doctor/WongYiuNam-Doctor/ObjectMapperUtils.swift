//
//  ObjectMapperUtils.swift
//  WongYiuNam-Doctor
//
//  Created by Hoang Tien Dat on 12/7/16.
//  Copyright © 2017 Hoang Tien Dat. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya

class Utils {
    class private func getObject(paths: [String]?, from data: Any) -> AnyObject? {
        guard let data = data as AnyObject?  else {
            return nil
        }
        
        var result = data
        for item in paths ?? [] {
            if let res = result[item] as AnyObject? {
                result = res
            } else {
                return nil
            }
        }
        
        return result
    }
    
    /* Ex: let list: [User]? = Utils.mapArray(paths: ["data", "users"], from: response) */
    class func mapArray<T: Mappable>(paths: [String]? = nil, from data: Response) -> [T]? {
        do {
            let json = try data.mapJSON()
            return Utils.mapArray(paths: paths, from: json)
        } catch {
            return nil
        }
    }
    
    /* Ex: let list: User? = Utils.mapArray(paths: ["data", "user"], from: response) */
    class func mapOne<T: Mappable>(paths: [String]? = nil, from data: Response) -> T? {
        do {
            let json = try data.mapJSON()
            return Utils.mapOne(paths: paths, from: json)
        } catch {
            return nil
        }
    }
    
    /* Ex: let list: [User]? = Utils.mapArray(paths: ["data", "users"], from: json) */
    class func mapArray<T: Mappable>(paths: [String]? = nil, from data: Any) -> [T]? {
        let object = Utils.getObject(paths: paths, from: data)
        return Mapper<T>().mapArray(JSONObject: object)
    }
    
    /* Ex: let list: User? = Utils.mapArray(paths: ["data", "user"], from: json) */
    class func mapOne<T: Mappable>(paths: [String]? = nil, from data: Any) -> T? {
        let object = Utils.getObject(paths: paths, from: data)
        return Mapper<T>().map(JSONObject: object)
    }

}
