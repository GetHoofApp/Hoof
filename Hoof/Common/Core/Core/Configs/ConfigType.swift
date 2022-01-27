//
//  ConfigType.swift
//  Core
//
//  Created by Sameh Mabrouk on 28/12/2021.
//

public protocol CoreConfigurable {
    static var baseURL: String { get }
    static var grahQLBaseURL: String { get }
}

/// Use this method to inject the configuration for this framework.
public func setup(with config: CoreConfigurable.Type) {
    ConfigType.shared = ConfigType(config)
}

public var Config: ConfigType { // swiftlint:disable:this variable_name
    if let config = ConfigType.shared {
        return config
    } else {
        fatalError("Please set the Config for \(Bundle(for: ConfigType.self))")
    }
}

public final class ConfigType {
    
    static fileprivate var shared: ConfigType?
    
    public let baseURL: String
    public let graphQLBaseURL: String
    
    fileprivate init(_ config: CoreConfigurable.Type) {
        self.baseURL = config.baseURL
        self.graphQLBaseURL = config.grahQLBaseURL
    }
}
