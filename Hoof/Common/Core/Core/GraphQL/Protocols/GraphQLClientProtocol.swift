//
//  GraphQLClientProtocol.swift
//  Core
//
//  Created by Sameh Mabrouk on 28/12/2021.
//

import Apollo
import RxSwift

/// The `GraphQLClientProtocol` provides the core API for GraphQL. This API provides methods to fetch and watch queries, and to perform mutations.

public protocol GraphQLClientProtocol {
    func fetch<Query: GraphQLQuery>(query: Query) -> Observable<Query.Data>
    func perform<Mutation: GraphQLMutation>(mutation: Mutation) -> Observable<Mutation.Data>
    func upload<Mutation: GraphQLMutation>(mutation: Mutation, files: [GraphQLFile]) -> Observable<Mutation.Data>
}
