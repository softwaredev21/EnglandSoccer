//
//  APIClient.swift
//  CasAngel
//
//  Created by Admin on 28/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

enum APIEndpoint: String {
    case GetStandings = "leagueTable/"
    case GetFixtures = "fixtures/league/"
    case GetPostCategories = "wp-json/wp/v2/categories"
    case GetAllPosts = "wp-json/wp/v2/posts"
    case ProcessRegistration = "api/AndroidAppUsers/android_register"
    case ProcessLogin = "api/AndroidAppUsers/android_generate_cookie"
    case GetNonce = "api/get_nonce"
    case GetCouponInfo = "wp-json/wc/v2/coupons"
    case ProcessForgotPassword = "api/AndroidAppUsers/android_forgot_password"
    case PlaceOrder = "api/AndroidAppSettings/android_data_link"
    case GetAllOrders = "wp-json/wc/v2/orders"
    case GetSingleOrder = "wp-json/wc/v2/orders/"
}

class APIClient {
    public static let BASE_URL = "https://api-football-v1.p.rapidapi.com/v2/"
    
    private static let API_KEY_NAME = "X-RapidAPI-Key"
    private static let API_KEY = "e2c7c0490emsh46b61d7ad61453bp19c3e6jsn5653a6da513b"
    
    private static func post(urlStr: String, params: Parameters) -> DataRequest? {
        guard let url = URL(string: BASE_URL + urlStr) else {
            return nil
        }
        let headers = [
            "Accept": "application/json",
            API_KEY_NAME: API_KEY
        ]
        return Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.httpBody , headers: headers)
    }
    
    
    public static func getStandings(leagueId: Int, completionHandler: @escaping (_ productDetail: StandingsResponse?, _ success: Bool) -> Void) {
        guard let request = post(urlStr: APIEndpoint.GetStandings.rawValue + String(leagueId), params: Parameters.init()) else {
            print("error")
            completionHandler(nil, false)
            return
        }
        
        request.responseObject{ (response: DataResponse<StandingsResponse>) in
            guard response.result.isSuccess else {
                completionHandler(nil, false)
                return
            }
            guard let value = response.result.value else {
                completionHandler(nil, false)
                return
            }
            completionHandler(value, true)
        }
    }
    
    public static func getFixtures(leagueId: Int, completionHandler: @escaping (_ productDetail: FixturesResposne?, _ success: Bool) -> Void) {
        guard let request = post(urlStr: APIEndpoint.GetFixtures.rawValue + String(leagueId), params: Parameters.init()) else {
            print("error")
            completionHandler(nil, false)
            return
        }
        
        request.responseObject{ (response: DataResponse<FixturesResposne>) in
            guard response.result.isSuccess else {
                completionHandler(nil, false)
                return
            }
            guard let value = response.result.value else {
                completionHandler(nil, false)
                return
            }
            completionHandler(value, true)
        }
    }
}
