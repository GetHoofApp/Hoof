//
//  Environment.swift
//  Core
//
//  Created by Sameh Mabrouk on 28/12/2021.
//

public enum Environment {
    // MARK: - Keys
    public enum Keys {
        public enum Plist: String {
            case baseURL = "BaseURL"
      }
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
      guard let dict = Bundle.main.infoDictionary else {
        fatalError("Plist file not found")
      }
      return dict
    }()

    private static func value<T>(for key: String) -> T {
        guard let value = infoDictionary[key] as? T else {
            fatalError("\(key) not set in plist as \(T.self)")
        }
        return value
    }
    
    public static func string(for key: Environment.Keys.Plist) -> String {
        return value(for: key.rawValue)
    }
}
