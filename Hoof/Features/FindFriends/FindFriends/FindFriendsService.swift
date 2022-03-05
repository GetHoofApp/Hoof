//
//  FindFriendsService.swift
//  FindFriends
//
//  Created Sameh Mabrouk on 24/02/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core

public protocol FindFriendsServicePerforming {
    func fetchSuggestedAthletes(userID: Int) -> Single<[User?]>
    func followUser(userID: String, userToFollowID: String) -> Single<Bool>
    func unfollowUser(userID: String, userToUnfollowID: String) -> Single<Bool>
    func searchUsers(query: String) -> Single<[User?]>
    func followAll(userID: String, usersIdsToFollow: [String]) -> Single<Bool>
    func unfollowAll(userID: String, usersIdsToUnfollow: [String]) -> Single<Bool>
}

class FindFriendsService: FindFriendsServicePerforming {
    
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
    func fetchSuggestedAthletes(userID: Int) -> Single<[User?]> {
        return client.fetch(query: SuggestedAthletesQuery(userId: userID))
            .map {
                $0.athletesToFollow?.compactMap {
                    return User(data: $0)
                } ?? []
            }.asSingle()
    }
    
    func followUser(userID: String, userToFollowID: String) -> Single<Bool> {
        return client.perform(mutation: FollowUserMutation(userId: userID, userToFollowId: userToFollowID))
            .map {
                $0.followUser?.user?.id != nil
            }
            .asSingle()
    }
    
    func unfollowUser(userID: String, userToUnfollowID: String) -> Single<Bool> {
        return client.perform(mutation: UnFollowUserMutation(userId: userID, userToUnfollowId: userToUnfollowID))
            .map {
                $0.unfollowUser?.user?.id != nil
            }
            .asSingle()
    }
    
    func searchUsers(query: String) -> Single<[User?]> {
        return client.fetch(query: SearchUsersQuery(query: query))
            .map {
                $0.searchUsers?.compactMap {
                    return User(data: $0)
                } ?? []
            }.asSingle()
    }
    
    func followAll(userID: String, usersIdsToFollow: [String]) -> Single<Bool> {
        return client.perform(mutation: FollowAllMutation(userId: userID, usersIdsToFollow: usersIdsToFollow))
            .map {
                $0.followAll?.success ?? false
            }
            .asSingle()
    }
    
    func unfollowAll(userID: String, usersIdsToUnfollow: [String]) -> Single<Bool> {
        return client.perform(mutation: UnfollowAllMutation(userId: userID, usersIdsToUnfollow: usersIdsToUnfollow))
            .map {
                $0.unfollowAll?.success ?? false
            }
            .asSingle()
    }
}
