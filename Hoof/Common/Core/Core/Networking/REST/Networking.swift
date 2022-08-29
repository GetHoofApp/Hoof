//
//  Networking.swift
//  Core
//
//  Created by Sameh Mabrouk on 22/06/2022.
//

import Alamofire

public enum Router: URLRequestConvertible {
	case fetchAthelteActivitiesTimeline(userID: String, lastVisibleUserId: String, limit: Int)
	case fetchAthelteActivities(userID: String, lastVisibleActivityId: String, limit: Int)
	case uploadActivity

	static let baseURLString = Config.baseURL

	var method: HTTPMethod {
		switch self {
		case .fetchAthelteActivitiesTimeline, .fetchAthelteActivities:
			return .get
		case .uploadActivity:
			return .post
		}
	}

	var path: String {
		switch self {
		case .fetchAthelteActivitiesTimeline:
			return "/athlete_activities_timeline"
		case .fetchAthelteActivities:
			return "/athlete_activities"
		case .uploadActivity:
			return "/upload_activity"
		}
	}

	var headers: HTTPHeaders? {
		switch self {
		case .fetchAthelteActivitiesTimeline, .fetchAthelteActivities:
			return nil
		case .uploadActivity:
			return ["Content-Type": "multipart/form-data"]
		}
	}

	var parameters: [String: Any]? {
		switch self {
		case let .fetchAthelteActivitiesTimeline(userID, lastVisibleUserId, limit):
			var params: [String: Any]
			if !lastVisibleUserId.isEmpty {
				params = ["user_id": userID, "last_visible_user_id": lastVisibleUserId, "limit": limit] as [String : Any]
			} else {
				params = ["user_id": userID, "limit": limit] as [String : Any]
			}

			return params as [String : Any]?
		case let .fetchAthelteActivities(userID, lastVisibleActivityId, limit):
			var params: [String: Any]
			if !lastVisibleActivityId.isEmpty {
				params = ["user_id": userID, "last_visible_activity_id": lastVisibleActivityId, "limit": limit] as [String : Any]
			} else {
				params = ["user_id": userID, "limit": limit] as [String : Any]
			}

			return params as [String : Any]?
		case .uploadActivity:
			return nil 
		}
	}

	public func asURLRequest() throws -> URLRequest {
		let url = try Router.baseURLString.asURL()

//		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method, headers: headers)
		urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
		print("URL: \(String(describing: urlRequest.url))")
		return urlRequest
	}
}
