//
//  ViewController.swift
//  Weather
//
//  Created by Валентина Лінчук on 12/09/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    var dogUrl: String = "" {
        didSet {
            downloadImage(from: dogUrl)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testJSON()
//        firstRequest()
//        fullRequest()
//        downloadImage()
        getUrlDog()
    }
    
    func getUrlDog() {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data, let responce else { return }
            
            let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]) ?? [:]
            if let urlStr = jsonDictionary["message"] as? String {
                self.dogUrl = urlStr
            }
            print(jsonDictionary)
        }
        task.resume()
    }
    
    func downloadImage(from urlStr: String) {
   
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let url = URL(string: urlStr)!
            
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    self?.imgView.image = UIImage(data: data)
                }
            }
        }
    }
    
    
    
    
    func testJSON() {
        let me = User(name: "Valentyna", email: "val@gmail.com", age: 26)
        
        let jsonData = (try? JSONEncoder().encode(me)) ?? Data()
        //JSONEncoder() - объект, предоставляемый Swift для кодирования (преобразования в JSON) данных. С помощью JSONEncoder, объект me (экземпляр User) кодируется в формат JSON с использованием метода encode. Это означает, что свойства name, email и age из объекта me будут преобразованы в JSON-строку.
        
        //В итоге, переменная jsonData содержит данные пользователя me в формате JSON, которые могут быть использованы для отправки на сервер, сохранения в файле и других операциях, связанных с обработкой данных в формате JSON.
        
        var decodedMe: User?
        decodedMe = try? JSONDecoder().decode(User.self, from: jsonData)
        
        let decodedString = String(data: jsonData, encoding: .utf8)
        // decodedString - содержит текстовое представление данных в jsonData.
        
        
        print(decodedMe)
        print(decodedString)
    }
    
    func firstRequest() {
        let url = URL(string: "https://api.genderize.io?name=Bebra")!
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            guard let data, let responce else { return }
            print("Responce from:", responce.url)
            
            let responceModel = try? JSONDecoder().decode(GenderizeResponseModel.self, from: data)
            print(responceModel)
        }
        task.resume()
    }
    
    func fullRequest() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        let session = URLSession(configuration: configuration)
        
        let url = buildGenderizeUrl()
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                print("Request Error")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Response Error")
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("Oops!! there is \(response.statusCode) error")
                return
            }
            
            
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                print("The Responce is: \n", jsonDictionary!)
            } catch {
                print("JSON serialisation error: \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }
    
    func buildGenderizeUrl() -> URL {
        let name = "Obi"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.genderize.io"
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: name)
        ]
        return urlComponents.url!
    }
    
}

struct User: Codable {
    let name: String
    let email: String
    let age: UInt
}

struct GenderizeRequestModel: Codable {
    let name: String
}

struct GenderizeResponseModel: Codable {
    let count: Int
    let name: String
    let gender: String
}
