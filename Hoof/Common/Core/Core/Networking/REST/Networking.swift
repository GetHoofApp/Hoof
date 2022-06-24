//
//  Networking.swift
//  Core
//
//  Created by Sameh Mabrouk on 22/06/2022.
//

import Alamofire

public enum Router: URLRequestConvertible {
	case fetchAthelteActivitiesTimeline(userID: String)

	static let baseURLString = Config.baseURL

	var method: HTTPMethod {
		switch self {
		case .fetchAthelteActivitiesTimeline:
			return .get
		}
	}

	var path: String {
		switch self {
		case .fetchAthelteActivitiesTimeline:
			return "/athlete_activities_timeline"
		}
	}

	var parameters: [String: AnyObject]? {
		switch self {
		case let .fetchAthelteActivitiesTimeline(userID):
			let params = ["user_id": userID]
			return params as [String : AnyObject]?
		}
	}

	public func asURLRequest() throws -> URLRequest {
		let url = try Router.baseURLString.asURL()

		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		urlRequest.httpMethod = method.rawValue

		urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
		print("URL: \(String(describing: urlRequest.url))")
		return urlRequest
	}
}
