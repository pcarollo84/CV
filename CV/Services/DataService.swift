//
//  DataService.swift
//  CV
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation
import CocoaLumberjack

protocol DataServiceProtocol {
    
    var baseURL: URL { get }
    
    init(baseURL: URL)
    
    func areas(with name: String, sessionConfiguration: URLSessionConfiguration, completion: @escaping ([Area], Error?) -> ())
    
}

struct DataService: DataServiceProtocol {
    
    enum Error: Swift.Error {
        case missingJSON
        case invalidJSON
    }
    
    private(set) var baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func areas(with name: String, sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default, completion: @escaping ([Area], Swift.Error?) -> ())  {
        
        let request = URLRequest(url: baseURL.appendingPathComponent(name))
        let session = URLSession(configuration: sessionConfiguration)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            //  TODO: Add session as protocol in the params so it can be mocked
            //  TODO: when starting using real REST api add test for status response
            
            guard let data = data else {
                completion([], Error.missingJSON)
                return
            }
            
            do {
                
                let root: Root = try Deserializer.shared.deserialize(data: data)
                completion(root.areas, nil)
                
            } catch {
                
                if let json = String(data: data, encoding: .utf8) {
                    DDLogError("Error on decoding json: \(json). \(error.localizedDescription)")
                } else {
                    DDLogError("Data is corrupted. \(error.localizedDescription)")
                }
                
                completion([], Error.invalidJSON)
                return
                
            }
            
        }
        
        dataTask.resume()
        
    }
    
    func image(with name: String, sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default, completion: @escaping (UIImage?) -> ()) {
        
        let request = URLRequest(url: baseURL.appendingPathComponent(name))
        let session = URLSession(configuration: sessionConfiguration)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            completion(UIImage(data: data))
            
        }
        
        dataTask.resume()
        
    }
    
}
