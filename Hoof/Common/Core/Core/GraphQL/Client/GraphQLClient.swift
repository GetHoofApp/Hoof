//
//  GraphQLClient.swift
//  Core
//
//  Created by Sameh Mabrouk on 28/12/2021.
//

import Foundation
import Apollo
import RxSwift
import AdSupport

public class GraphQLClient: GraphQLClientProtocol {
    
    private lazy var client: ApolloClient = {
        let serverUrl = URL(staticString: Config.graphQLBaseURL)
        
        //https://www.apollographql.com/docs/ios/initialization/#basic-client-creation
        // Accept-Language HTTP Header; see https://tools.ietf.org/html/rfc7231#section-5.3.5
//        let acceptLanguage = Locale.preferredLanguages.prefix(6).enumerated().map { index, languageCode in
//            let quality = 1.0 - (Double(index) * 0.1)
//            return "\(languageCode);q=\(quality)"
//        }.joined(separator: ", ")
//
//        let urlSessionConfiguration = URLSessionConfiguration.default
//        urlSessionConfiguration.httpAdditionalHeaders = [
////            "Authorization": "Bearer \(CoreConfiguration.sharedInstance.sessionToken ?? "")",
////            "User-Agent": CoreConfiguration.sharedInstance.UserAgent,
//            "Accept-Language": acceptLanguage
//        ]
//
//        // The cache is necessary to set up the store, which we're going to hand to the provider
//        let cache = InMemoryNormalizedCache()
//        let store = ApolloStore(cache: cache)
//
//        let client = URLSessionClient()
//        let provider = NetworkInterceptorProvider(store: store, client: client)
//
//        let networkTransport = HTTPNetworkTransport(url: serverUrl, client: client)
//        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
//                                                                 endpointURL: url)
//        return ApolloClient(networkTransport: requestChainTransport, store: <#ApolloStore#>)
        return ApolloClient(url: serverUrl)
    }()
    
    public init() {}
    
    public func fetch<Query: GraphQLQuery>(query: Query) -> Observable<Query.Data> {
        return client.rx.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely).asObservable()
    }
    
    public func perform<Mutation>(mutation: Mutation) -> Observable<Mutation.Data> where Mutation: GraphQLMutation {
        return client.rx.perform(mutation: mutation).asObservable()
    }
}
