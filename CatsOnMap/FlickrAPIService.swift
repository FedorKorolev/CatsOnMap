//
//  FlickrAPIService.swift
//  CatsOnMap
//
//  Created by Nikolay Shubenkov on 01/04/2017.
//  Copyright © 2017 Nikolay Shubenkov. All rights reserved.
//

import Foundation

class FlickrAPIService {
    
    //URLSession - класс, который позволяет обращаться к данным в сети
    //загружать их и отправлять из приложения на сервер
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func search(tag:String,
                //escaping означает, что это замыкание будет выполнено не в течение работы метода search
                //а когда-то потом
                success:@escaping( ([Any])->Void ),
                failure:@escaping( (Error)->Void ))
    {
        print("а сейчас мы обратимся к серверу")
        
        let url = self.buildURL(tag: tag)
        
         //https://api.flickr.com/services/rest/?
        print("вызов метода search завершен")
    }
    
    private struct Constants {
        static let serviceURL = "https://api.flickr.com/services/rest/"
        static let method = "method"
        static let apiKey = "2b2c9f8abc28afe8d7749aee246d951c"
        
        static func buildWith(methodName:String)->String
        {
            return serviceURL + "?" + method + "=" + methodName + "&api_key=" + apiKey + "&format=json" + "&nojsoncallback=1"
        }
    }
    
    private func buildURL(tag:String)->URL {
        var urlString = Constants.buildWith(methodName: "flickr.photos.search")
        print("создали ссылку с методом\n\(urlString)")
    //tags=cat&
        //has_geo=1&
        //extras=geo%2Curl_l%2Curl_s&
        var params = ["has_geo":"1",
                      "tags":tag,
                      "extras":"geo,url_l,url_s"]
        for (key,value) in params {
            urlString.append("&\(key)=\(value)")
        }
        
        //эта строка может содержать недопустимые символы для параметров ссылки.
        //поэтому мы ее преобразуем. (ввведите в поисковике
        //любой запрос и посмотрите, что выводится в ссылке с этим запросом
        //вы увидите, что часть символов меняется еа вид %XX
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        print("итого:\n\(urlString)")
        
        return URL(string: urlString)!
    }
    
}
