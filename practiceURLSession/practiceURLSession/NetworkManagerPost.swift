//
//  NetworkManagerPost.swift
//  practiceURLSession
//
//  Created by Valentin Fernandez on 17/8/24.
//

import Foundation

class NetworkManagerPost {
    
    func getPost(completion: @escaping([Post]) -> ()) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{
            fatalError("La URL no se ha podido cargar o es inválida")
        }
        
        URLSession.shared.dataTask(with: url){ datos, respuesta, error in
            guard let data = datos, error == nil, let response = respuesta as? HTTPURLResponse else{
                return
            }
        
            if response.statusCode == 200 {
                
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(posts)
                } catch let error {
                    print("Se ha producido un error: \(error).localizedDescription)")
                }
            }
            
        }.resume()
    }
}
