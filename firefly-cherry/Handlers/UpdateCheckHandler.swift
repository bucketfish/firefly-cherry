//
//  UpdateCheckHandler.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 8/9/23.
//

import Foundation

struct Version: Identifiable, Codable {
    let id: Int
    var tag_name: String
    var name: String
    var html_url: String
}

func getLatestVersion(completion: @escaping (String, String) -> ()) {
    // NO WAY I GOT THIS WORKING
    let url = URL(string:"https://api.github.com/repos/bucketfish/firefly-cherry/releases/latest")!
    
    URLSession.shared.dataTask(with: url){
        data, response, error in
        
        let decoder = JSONDecoder()
        
        if let data = data{
            do{
                let data = try decoder.decode(Version.self, from: data)
                completion(data.tag_name, data.html_url)
            
            }catch{
                print(error)
                completion("", "")
            }
        }
    }.resume()
}


func isOnLatestVer(completion: @escaping (Bool, String) -> ()) {
    getLatestVersion { version, url in
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        completion(version == "v" + currentVersion, url)
    }
}


func getCurrentVer() -> (String) {
    return "v" + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
}
