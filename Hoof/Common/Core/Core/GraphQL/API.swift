// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// An enumeration.
public enum AthleteFavoritePosition: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Goalkeeper
  case goalkeeper
  /// Right Fullback
  case rightFullback
  /// Left Fullback
  case leftFullback
  /// Center Back
  case centerBack
  /// Midfielder
  case midfielder
  /// Stricker
  case stricker
  /// Playmaker
  case playmaker
  /// Stricker
  case stricker_7
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "GOALKEEPER": self = .goalkeeper
      case "RIGHT_FULLBACK": self = .rightFullback
      case "LEFT_FULLBACK": self = .leftFullback
      case "CENTER_BACK": self = .centerBack
      case "MIDFIELDER": self = .midfielder
      case "STRICKER": self = .stricker
      case "PLAYMAKER": self = .playmaker
      case "STRICKER_7": self = .stricker_7
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .goalkeeper: return "GOALKEEPER"
      case .rightFullback: return "RIGHT_FULLBACK"
      case .leftFullback: return "LEFT_FULLBACK"
      case .centerBack: return "CENTER_BACK"
      case .midfielder: return "MIDFIELDER"
      case .stricker: return "STRICKER"
      case .playmaker: return "PLAYMAKER"
      case .stricker_7: return "STRICKER_7"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: AthleteFavoritePosition, rhs: AthleteFavoritePosition) -> Bool {
    switch (lhs, rhs) {
      case (.goalkeeper, .goalkeeper): return true
      case (.rightFullback, .rightFullback): return true
      case (.leftFullback, .leftFullback): return true
      case (.centerBack, .centerBack): return true
      case (.midfielder, .midfielder): return true
      case (.stricker, .stricker): return true
      case (.playmaker, .playmaker): return true
      case (.stricker_7, .stricker_7): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [AthleteFavoritePosition] {
    return [
      .goalkeeper,
      .rightFullback,
      .leftFullback,
      .centerBack,
      .midfielder,
      .stricker,
      .playmaker,
      .stricker_7,
    ]
  }
}

/// An enumeration.
public enum AthleteFoot: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Right
  case `right`
  /// Left
  case `left`
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "RIGHT": self = .right
      case "LEFT": self = .left
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .right: return "RIGHT"
      case .left: return "LEFT"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: AthleteFoot, rhs: AthleteFoot) -> Bool {
    switch (lhs, rhs) {
      case (.right, .right): return true
      case (.left, .left): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [AthleteFoot] {
    return [
      .right,
      .left,
    ]
  }
}

/// An enumeration.
public enum AthleteGender: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Male
  case male
  /// Female
  case female
  /// Not specified
  case notSpecified
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "MALE": self = .male
      case "FEMALE": self = .female
      case "NOT_SPECIFIED": self = .notSpecified
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .male: return "MALE"
      case .female: return "FEMALE"
      case .notSpecified: return "NOT_SPECIFIED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: AthleteGender, rhs: AthleteGender) -> Bool {
    switch (lhs, rhs) {
      case (.male, .male): return true
      case (.female, .female): return true
      case (.notSpecified, .notSpecified): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [AthleteGender] {
    return [
      .male,
      .female,
      .notSpecified,
    ]
  }
}

public final class CommentOnPostMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CommentOnPost($userId: ID!, $postId: ID!, $message: String!) {
      commentOnPost(userId: $userId, postId: $postId, message: $message) {
        __typename
        success
      }
    }
    """

  public let operationName: String = "CommentOnPost"

  public var userId: GraphQLID
  public var postId: GraphQLID
  public var message: String

  public init(userId: GraphQLID, postId: GraphQLID, message: String) {
    self.userId = userId
    self.postId = postId
    self.message = message
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "postId": postId, "message": message]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("commentOnPost", arguments: ["userId": GraphQLVariable("userId"), "postId": GraphQLVariable("postId"), "message": GraphQLVariable("message")], type: .object(CommentOnPost.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(commentOnPost: CommentOnPost? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "commentOnPost": commentOnPost.flatMap { (value: CommentOnPost) -> ResultMap in value.resultMap }])
    }

    public var commentOnPost: CommentOnPost? {
      get {
        return (resultMap["commentOnPost"] as? ResultMap).flatMap { CommentOnPost(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "commentOnPost")
      }
    }

    public struct CommentOnPost: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CommentOnPost"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("success", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "CommentOnPost", "success": success])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool? {
        get {
          return resultMap["success"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }
    }
  }
}

public final class CreateUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateUser($firstName: String!, $lastName: String!, $password: String!, $email: String!, $gender: String!) {
      createUser(
        firstName: $firstName
        lastName: $lastName
        email: $email
        password: $password
        gender: $gender
      ) {
        __typename
        id
        firstName
        lastName
        email
        gender
      }
    }
    """

  public let operationName: String = "CreateUser"

  public var firstName: String
  public var lastName: String
  public var password: String
  public var email: String
  public var gender: String

  public init(firstName: String, lastName: String, password: String, email: String, gender: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.password = password
    self.email = email
    self.gender = gender
  }

  public var variables: GraphQLMap? {
    return ["firstName": firstName, "lastName": lastName, "password": password, "email": email, "gender": gender]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createUser", arguments: ["firstName": GraphQLVariable("firstName"), "lastName": GraphQLVariable("lastName"), "email": GraphQLVariable("email"), "password": GraphQLVariable("password"), "gender": GraphQLVariable("gender")], type: .object(CreateUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createUser: CreateUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createUser": createUser.flatMap { (value: CreateUser) -> ResultMap in value.resultMap }])
    }

    public var createUser: CreateUser? {
      get {
        return (resultMap["createUser"] as? ResultMap).flatMap { CreateUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createUser")
      }
    }

    public struct CreateUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CreateUser"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("gender", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, gender: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "CreateUser", "id": id, "firstName": firstName, "lastName": lastName, "email": email, "gender": gender])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int? {
        get {
          return resultMap["id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var firstName: String? {
        get {
          return resultMap["firstName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String? {
        get {
          return resultMap["lastName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var gender: String? {
        get {
          return resultMap["gender"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "gender")
        }
      }
    }
  }
}

public final class FollowAllMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation FollowAll($userId: ID!, $usersIdsToFollow: [ID!]) {
      followAll(id: $userId, usersIdsToFollow: $usersIdsToFollow) {
        __typename
        success
      }
    }
    """

  public let operationName: String = "FollowAll"

  public var userId: GraphQLID
  public var usersIdsToFollow: [GraphQLID]?

  public init(userId: GraphQLID, usersIdsToFollow: [GraphQLID]?) {
    self.userId = userId
    self.usersIdsToFollow = usersIdsToFollow
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "usersIdsToFollow": usersIdsToFollow]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("followAll", arguments: ["id": GraphQLVariable("userId"), "usersIdsToFollow": GraphQLVariable("usersIdsToFollow")], type: .object(FollowAll.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(followAll: FollowAll? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "followAll": followAll.flatMap { (value: FollowAll) -> ResultMap in value.resultMap }])
    }

    public var followAll: FollowAll? {
      get {
        return (resultMap["followAll"] as? ResultMap).flatMap { FollowAll(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "followAll")
      }
    }

    public struct FollowAll: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["FollowAll"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("success", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "FollowAll", "success": success])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool? {
        get {
          return resultMap["success"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }
    }
  }
}

public final class FollowUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation FollowUser($userId: ID!, $userToFollowId: ID!) {
      followUser(id: $userId, userToFollowId: $userToFollowId) {
        __typename
        user {
          __typename
          id
        }
      }
    }
    """

  public let operationName: String = "FollowUser"

  public var userId: GraphQLID
  public var userToFollowId: GraphQLID

  public init(userId: GraphQLID, userToFollowId: GraphQLID) {
    self.userId = userId
    self.userToFollowId = userToFollowId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "userToFollowId": userToFollowId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("followUser", arguments: ["id": GraphQLVariable("userId"), "userToFollowId": GraphQLVariable("userToFollowId")], type: .object(FollowUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(followUser: FollowUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "followUser": followUser.flatMap { (value: FollowUser) -> ResultMap in value.resultMap }])
    }

    public var followUser: FollowUser? {
      get {
        return (resultMap["followUser"] as? ResultMap).flatMap { FollowUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "followUser")
      }
    }

    public struct FollowUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["FollowUser"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("user", type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "FollowUser", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["UserType"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "UserType", "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}

public final class LikePostMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation LikePost($userId: ID!, $postId: ID!) {
      likePost(userId: $userId, postId: $postId) {
        __typename
        like {
          __typename
          id
          creator {
            __typename
            firstName
            lastName
          }
          post {
            __typename
            id
            title
          }
        }
      }
    }
    """

  public let operationName: String = "LikePost"

  public var userId: GraphQLID
  public var postId: GraphQLID

  public init(userId: GraphQLID, postId: GraphQLID) {
    self.userId = userId
    self.postId = postId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "postId": postId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("likePost", arguments: ["userId": GraphQLVariable("userId"), "postId": GraphQLVariable("postId")], type: .object(LikePost.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(likePost: LikePost? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "likePost": likePost.flatMap { (value: LikePost) -> ResultMap in value.resultMap }])
    }

    public var likePost: LikePost? {
      get {
        return (resultMap["likePost"] as? ResultMap).flatMap { LikePost(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "likePost")
      }
    }

    public struct LikePost: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["LikePost"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("like", type: .object(Like.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(like: Like? = nil) {
        self.init(unsafeResultMap: ["__typename": "LikePost", "like": like.flatMap { (value: Like) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var like: Like? {
        get {
          return (resultMap["like"] as? ResultMap).flatMap { Like(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "like")
        }
      }

      public struct Like: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["LikeType"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("creator", type: .object(Creator.selections)),
            GraphQLField("post", type: .object(Post.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, creator: Creator? = nil, post: Post? = nil) {
          self.init(unsafeResultMap: ["__typename": "LikeType", "id": id, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "post": post.flatMap { (value: Post) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var creator: Creator? {
          get {
            return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "creator")
          }
        }

        public var post: Post? {
          get {
            return (resultMap["post"] as? ResultMap).flatMap { Post(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "post")
          }
        }

        public struct Creator: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["UserType"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
              GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(firstName: String, lastName: String) {
            self.init(unsafeResultMap: ["__typename": "UserType", "firstName": firstName, "lastName": lastName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var firstName: String {
            get {
              return resultMap["firstName"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String {
            get {
              return resultMap["lastName"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }
        }

        public struct Post: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PostType"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, title: String) {
            self.init(unsafeResultMap: ["__typename": "PostType", "id": id, "title": title])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }
        }
      }
    }
  }
}

public final class UnfollowAllMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UnfollowAll($userId: ID!, $usersIdsToUnfollow: [ID!]) {
      unfollowAll(id: $userId, usersIdsToUnfollow: $usersIdsToUnfollow) {
        __typename
        success
      }
    }
    """

  public let operationName: String = "UnfollowAll"

  public var userId: GraphQLID
  public var usersIdsToUnfollow: [GraphQLID]?

  public init(userId: GraphQLID, usersIdsToUnfollow: [GraphQLID]?) {
    self.userId = userId
    self.usersIdsToUnfollow = usersIdsToUnfollow
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "usersIdsToUnfollow": usersIdsToUnfollow]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("unfollowAll", arguments: ["id": GraphQLVariable("userId"), "usersIdsToUnfollow": GraphQLVariable("usersIdsToUnfollow")], type: .object(UnfollowAll.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(unfollowAll: UnfollowAll? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "unfollowAll": unfollowAll.flatMap { (value: UnfollowAll) -> ResultMap in value.resultMap }])
    }

    public var unfollowAll: UnfollowAll? {
      get {
        return (resultMap["unfollowAll"] as? ResultMap).flatMap { UnfollowAll(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "unfollowAll")
      }
    }

    public struct UnfollowAll: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UnFollowAll"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("success", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "UnFollowAll", "success": success])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool? {
        get {
          return resultMap["success"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }
    }
  }
}

public final class UnFollowUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UnFollowUser($userId: ID!, $userToUnfollowId: ID!) {
      unfollowUser(id: $userId, userToUnfollowId: $userToUnfollowId) {
        __typename
        user {
          __typename
          id
        }
      }
    }
    """

  public let operationName: String = "UnFollowUser"

  public var userId: GraphQLID
  public var userToUnfollowId: GraphQLID

  public init(userId: GraphQLID, userToUnfollowId: GraphQLID) {
    self.userId = userId
    self.userToUnfollowId = userToUnfollowId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "userToUnfollowId": userToUnfollowId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("unfollowUser", arguments: ["id": GraphQLVariable("userId"), "userToUnfollowId": GraphQLVariable("userToUnfollowId")], type: .object(UnfollowUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(unfollowUser: UnfollowUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "unfollowUser": unfollowUser.flatMap { (value: UnfollowUser) -> ResultMap in value.resultMap }])
    }

    public var unfollowUser: UnfollowUser? {
      get {
        return (resultMap["unfollowUser"] as? ResultMap).flatMap { UnfollowUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "unfollowUser")
      }
    }

    public struct UnfollowUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UnFollowUser"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("user", type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "UnFollowUser", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["UserType"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "UserType", "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}

public final class UnlikePostMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UnlikePost($userId: ID!, $postId: ID!) {
      unlikePost(userId: $userId, postId: $postId) {
        __typename
        success
      }
    }
    """

  public let operationName: String = "UnlikePost"

  public var userId: GraphQLID
  public var postId: GraphQLID

  public init(userId: GraphQLID, postId: GraphQLID) {
    self.userId = userId
    self.postId = postId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "postId": postId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("unlikePost", arguments: ["userId": GraphQLVariable("userId"), "postId": GraphQLVariable("postId")], type: .object(UnlikePost.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(unlikePost: UnlikePost? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "unlikePost": unlikePost.flatMap { (value: UnlikePost) -> ResultMap in value.resultMap }])
    }

    public var unlikePost: UnlikePost? {
      get {
        return (resultMap["unlikePost"] as? ResultMap).flatMap { UnlikePost(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "unlikePost")
      }
    }

    public struct UnlikePost: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UnLikePost"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("success", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "UnLikePost", "success": success])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool? {
        get {
          return resultMap["success"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }
    }
  }
}

public final class UpdateUserProfileMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateUserProfile($firstName: String!, $lastName: String!, $gender: String!, $userId: ID!, $logo: Upload) {
      updateUserProfile(
        firstName: $firstName
        lastName: $lastName
        gender: $gender
        userId: $userId
        logo: $logo
      ) {
        __typename
        success
      }
    }
    """

  public let operationName: String = "UpdateUserProfile"

  public var firstName: String
  public var lastName: String
  public var gender: String
  public var userId: GraphQLID
  public var logo: Upload?

  public init(firstName: String, lastName: String, gender: String, userId: GraphQLID, logo: Upload? = nil) {
    self.firstName = firstName
    self.lastName = lastName
    self.gender = gender
    self.userId = userId
    self.logo = logo
  }

  public var variables: GraphQLMap? {
    return ["firstName": firstName, "lastName": lastName, "gender": gender, "userId": userId, "logo": logo]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateUserProfile", arguments: ["firstName": GraphQLVariable("firstName"), "lastName": GraphQLVariable("lastName"), "gender": GraphQLVariable("gender"), "userId": GraphQLVariable("userId"), "logo": GraphQLVariable("logo")], type: .object(UpdateUserProfile.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateUserProfile: UpdateUserProfile? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateUserProfile": updateUserProfile.flatMap { (value: UpdateUserProfile) -> ResultMap in value.resultMap }])
    }

    public var updateUserProfile: UpdateUserProfile? {
      get {
        return (resultMap["updateUserProfile"] as? ResultMap).flatMap { UpdateUserProfile(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateUserProfile")
      }
    }

    public struct UpdateUserProfile: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UpdateUserProfile"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("success", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "UpdateUserProfile", "success": success])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool? {
        get {
          return resultMap["success"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }
    }
  }
}

public final class UploadActivityMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UploadActivity($file: Upload!, $title: String!, $description: String!, $userId: ID!) {
      createPost(
        file: $file
        title: $title
        description: $description
        userId: $userId
      ) {
        __typename
        id
        title
        description
      }
    }
    """

  public let operationName: String = "UploadActivity"

  public var file: Upload
  public var title: String
  public var description: String
  public var userId: GraphQLID

  public init(file: Upload, title: String, description: String, userId: GraphQLID) {
    self.file = file
    self.title = title
    self.description = description
    self.userId = userId
  }

  public var variables: GraphQLMap? {
    return ["file": file, "title": title, "description": description, "userId": userId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createPost", arguments: ["file": GraphQLVariable("file"), "title": GraphQLVariable("title"), "description": GraphQLVariable("description"), "userId": GraphQLVariable("userId")], type: .object(CreatePost.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createPost: CreatePost? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createPost": createPost.flatMap { (value: CreatePost) -> ResultMap in value.resultMap }])
    }

    public var createPost: CreatePost? {
      get {
        return (resultMap["createPost"] as? ResultMap).flatMap { CreatePost(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createPost")
      }
    }

    public struct CreatePost: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CreatePost"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int? = nil, title: String? = nil, description: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "CreatePost", "id": id, "title": title, "description": description])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int? {
        get {
          return resultMap["id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return resultMap["title"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }
    }
  }
}

public final class PostsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Posts($userId: Int!) {
      posts(id: $userId) {
        __typename
        id
        title
        description
        createdAt
        coordinates
        duration
        distance
        pace
        creator {
          __typename
          id
          firstName
          lastName
          profileImage
        }
        likes {
          __typename
          id
          creator {
            __typename
            id
            firstName
            lastName
            profileImage
          }
        }
        comments {
          __typename
          id
          message
        }
      }
    }
    """

  public let operationName: String = "Posts"

  public var userId: Int

  public init(userId: Int) {
    self.userId = userId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("posts", arguments: ["id": GraphQLVariable("userId")], type: .list(.object(Post.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(posts: [Post?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "posts": posts.flatMap { (value: [Post?]) -> [ResultMap?] in value.map { (value: Post?) -> ResultMap? in value.flatMap { (value: Post) -> ResultMap in value.resultMap } } }])
    }

    public var posts: [Post?]? {
      get {
        return (resultMap["posts"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Post?] in value.map { (value: ResultMap?) -> Post? in value.flatMap { (value: ResultMap) -> Post in Post(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Post?]) -> [ResultMap?] in value.map { (value: Post?) -> ResultMap? in value.flatMap { (value: Post) -> ResultMap in value.resultMap } } }, forKey: "posts")
      }
    }

    public struct Post: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PostType"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(DateTime.self))),
          GraphQLField("coordinates", type: .nonNull(.scalar(GeoJSON.self))),
          GraphQLField("duration", type: .scalar(Double.self)),
          GraphQLField("distance", type: .scalar(Double.self)),
          GraphQLField("pace", type: .scalar(Double.self)),
          GraphQLField("creator", type: .object(Creator.selections)),
          GraphQLField("likes", type: .nonNull(.list(.nonNull(.object(Like.selections))))),
          GraphQLField("comments", type: .nonNull(.list(.nonNull(.object(Comment.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String, description: String, createdAt: DateTime, coordinates: GeoJSON, duration: Double? = nil, distance: Double? = nil, pace: Double? = nil, creator: Creator? = nil, likes: [Like], comments: [Comment]) {
        self.init(unsafeResultMap: ["__typename": "PostType", "id": id, "title": title, "description": description, "createdAt": createdAt, "coordinates": coordinates, "duration": duration, "distance": distance, "pace": pace, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "likes": likes.map { (value: Like) -> ResultMap in value.resultMap }, "comments": comments.map { (value: Comment) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var createdAt: DateTime {
        get {
          return resultMap["createdAt"]! as! DateTime
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var coordinates: GeoJSON {
        get {
          return resultMap["coordinates"]! as! GeoJSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "coordinates")
        }
      }

      /// In seconds. ( seconds = hours * 60 * 60 )
      public var duration: Double? {
        get {
          return resultMap["duration"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "duration")
        }
      }

      /// In meters.  ( meters = miles / 0.00062137 )
      public var distance: Double? {
        get {
          return resultMap["distance"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "distance")
        }
      }

      /// In meters per second. ( m/s = 26.8224 / minutes per mile )
      public var pace: Double? {
        get {
          return resultMap["pace"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "pace")
        }
      }

      public var creator: Creator? {
        get {
          return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "creator")
        }
      }

      public var likes: [Like] {
        get {
          return (resultMap["likes"] as! [ResultMap]).map { (value: ResultMap) -> Like in Like(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Like) -> ResultMap in value.resultMap }, forKey: "likes")
        }
      }

      public var comments: [Comment] {
        get {
          return (resultMap["comments"] as! [ResultMap]).map { (value: ResultMap) -> Comment in Comment(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Comment) -> ResultMap in value.resultMap }, forKey: "comments")
        }
      }

      public struct Creator: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["UserType"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
            GraphQLField("profileImage", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, firstName: String, lastName: String, profileImage: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserType", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var firstName: String {
          get {
            return resultMap["firstName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String {
          get {
            return resultMap["lastName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var profileImage: String? {
          get {
            return resultMap["profileImage"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "profileImage")
          }
        }
      }

      public struct Like: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["LikeType"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("creator", type: .object(Creator.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, creator: Creator? = nil) {
          self.init(unsafeResultMap: ["__typename": "LikeType", "id": id, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var creator: Creator? {
          get {
            return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "creator")
          }
        }

        public struct Creator: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["UserType"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
              GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
              GraphQLField("profileImage", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, firstName: String, lastName: String, profileImage: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "UserType", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var firstName: String {
            get {
              return resultMap["firstName"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String {
            get {
              return resultMap["lastName"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var profileImage: String? {
            get {
              return resultMap["profileImage"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileImage")
            }
          }
        }
      }

      public struct Comment: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CommentType"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("message", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, message: String) {
          self.init(unsafeResultMap: ["__typename": "CommentType", "id": id, "message": message])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }
      }
    }
  }
}

public final class SearchUsersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchUsers($query: String!) {
      searchUsers(query: $query) {
        __typename
        id
        firstName
        lastName
        username
        email
        bio
        favoritePosition
        foot
        preferedNumber
        profileImage
      }
    }
    """

  public let operationName: String = "SearchUsers"

  public var query: String

  public init(query: String) {
    self.query = query
  }

  public var variables: GraphQLMap? {
    return ["query": query]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("searchUsers", arguments: ["query": GraphQLVariable("query")], type: .list(.object(SearchUser.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchUsers: [SearchUser?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchUsers": searchUsers.flatMap { (value: [SearchUser?]) -> [ResultMap?] in value.map { (value: SearchUser?) -> ResultMap? in value.flatMap { (value: SearchUser) -> ResultMap in value.resultMap } } }])
    }

    public var searchUsers: [SearchUser?]? {
      get {
        return (resultMap["searchUsers"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SearchUser?] in value.map { (value: ResultMap?) -> SearchUser? in value.flatMap { (value: ResultMap) -> SearchUser in SearchUser(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [SearchUser?]) -> [ResultMap?] in value.map { (value: SearchUser?) -> ResultMap? in value.flatMap { (value: SearchUser) -> ResultMap in value.resultMap } } }, forKey: "searchUsers")
      }
    }

    public struct SearchUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserType"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
          GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
          GraphQLField("username", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("bio", type: .scalar(String.self)),
          GraphQLField("favoritePosition", type: .scalar(AthleteFavoritePosition.self)),
          GraphQLField("foot", type: .scalar(AthleteFoot.self)),
          GraphQLField("preferedNumber", type: .scalar(Int.self)),
          GraphQLField("profileImage", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, firstName: String, lastName: String, username: String, email: String, bio: String? = nil, favoritePosition: AthleteFavoritePosition? = nil, foot: AthleteFoot? = nil, preferedNumber: Int? = nil, profileImage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserType", "id": id, "firstName": firstName, "lastName": lastName, "username": username, "email": email, "bio": bio, "favoritePosition": favoritePosition, "foot": foot, "preferedNumber": preferedNumber, "profileImage": profileImage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var firstName: String {
        get {
          return resultMap["firstName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String {
        get {
          return resultMap["lastName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      /// Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.
      public var username: String {
        get {
          return resultMap["username"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var bio: String? {
        get {
          return resultMap["bio"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "bio")
        }
      }

      public var favoritePosition: AthleteFavoritePosition? {
        get {
          return resultMap["favoritePosition"] as? AthleteFavoritePosition
        }
        set {
          resultMap.updateValue(newValue, forKey: "favoritePosition")
        }
      }

      public var foot: AthleteFoot? {
        get {
          return resultMap["foot"] as? AthleteFoot
        }
        set {
          resultMap.updateValue(newValue, forKey: "foot")
        }
      }

      public var preferedNumber: Int? {
        get {
          return resultMap["preferedNumber"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "preferedNumber")
        }
      }

      public var profileImage: String? {
        get {
          return resultMap["profileImage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImage")
        }
      }
    }
  }
}

public final class SuggestedAthletesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SuggestedAthletes($userId: Int!) {
      athletesToFollow(id: $userId) {
        __typename
        id
        username
        firstName
        lastName
        email
        profileImage
        followers {
          __typename
          id
          firstName
          lastName
        }
      }
    }
    """

  public let operationName: String = "SuggestedAthletes"

  public var userId: Int

  public init(userId: Int) {
    self.userId = userId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("athletesToFollow", arguments: ["id": GraphQLVariable("userId")], type: .list(.object(AthletesToFollow.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(athletesToFollow: [AthletesToFollow?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "athletesToFollow": athletesToFollow.flatMap { (value: [AthletesToFollow?]) -> [ResultMap?] in value.map { (value: AthletesToFollow?) -> ResultMap? in value.flatMap { (value: AthletesToFollow) -> ResultMap in value.resultMap } } }])
    }

    public var athletesToFollow: [AthletesToFollow?]? {
      get {
        return (resultMap["athletesToFollow"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AthletesToFollow?] in value.map { (value: ResultMap?) -> AthletesToFollow? in value.flatMap { (value: ResultMap) -> AthletesToFollow in AthletesToFollow(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AthletesToFollow?]) -> [ResultMap?] in value.map { (value: AthletesToFollow?) -> ResultMap? in value.flatMap { (value: AthletesToFollow) -> ResultMap in value.resultMap } } }, forKey: "athletesToFollow")
      }
    }

    public struct AthletesToFollow: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserType"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("username", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
          GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("profileImage", type: .scalar(String.self)),
          GraphQLField("followers", type: .nonNull(.list(.nonNull(.object(Follower.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, username: String, firstName: String, lastName: String, email: String, profileImage: String? = nil, followers: [Follower]) {
        self.init(unsafeResultMap: ["__typename": "UserType", "id": id, "username": username, "firstName": firstName, "lastName": lastName, "email": email, "profileImage": profileImage, "followers": followers.map { (value: Follower) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.
      public var username: String {
        get {
          return resultMap["username"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var firstName: String {
        get {
          return resultMap["firstName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String {
        get {
          return resultMap["lastName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var profileImage: String? {
        get {
          return resultMap["profileImage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImage")
        }
      }

      public var followers: [Follower] {
        get {
          return (resultMap["followers"] as! [ResultMap]).map { (value: ResultMap) -> Follower in Follower(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Follower) -> ResultMap in value.resultMap }, forKey: "followers")
        }
      }

      public struct Follower: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["UserType"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, firstName: String, lastName: String) {
          self.init(unsafeResultMap: ["__typename": "UserType", "id": id, "firstName": firstName, "lastName": lastName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var firstName: String {
          get {
            return resultMap["firstName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String {
          get {
            return resultMap["lastName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }
      }
    }
  }
}

public final class UsersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Users {
      users {
        __typename
        id
        username
        email
        gender
        bio
        favoritePosition
        foot
        preferedNumber
        profileImage
      }
    }
    """

  public let operationName: String = "Users"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("users", type: .list(.object(User.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: [User?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "users": users.flatMap { (value: [User?]) -> [ResultMap?] in value.map { (value: User?) -> ResultMap? in value.flatMap { (value: User) -> ResultMap in value.resultMap } } }])
    }

    public var users: [User?]? {
      get {
        return (resultMap["users"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [User?] in value.map { (value: ResultMap?) -> User? in value.flatMap { (value: ResultMap) -> User in User(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [User?]) -> [ResultMap?] in value.map { (value: User?) -> ResultMap? in value.flatMap { (value: User) -> ResultMap in value.resultMap } } }, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserType"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("username", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("gender", type: .scalar(AthleteGender.self)),
          GraphQLField("bio", type: .scalar(String.self)),
          GraphQLField("favoritePosition", type: .scalar(AthleteFavoritePosition.self)),
          GraphQLField("foot", type: .scalar(AthleteFoot.self)),
          GraphQLField("preferedNumber", type: .scalar(Int.self)),
          GraphQLField("profileImage", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, username: String, email: String, gender: AthleteGender? = nil, bio: String? = nil, favoritePosition: AthleteFavoritePosition? = nil, foot: AthleteFoot? = nil, preferedNumber: Int? = nil, profileImage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserType", "id": id, "username": username, "email": email, "gender": gender, "bio": bio, "favoritePosition": favoritePosition, "foot": foot, "preferedNumber": preferedNumber, "profileImage": profileImage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.
      public var username: String {
        get {
          return resultMap["username"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var gender: AthleteGender? {
        get {
          return resultMap["gender"] as? AthleteGender
        }
        set {
          resultMap.updateValue(newValue, forKey: "gender")
        }
      }

      public var bio: String? {
        get {
          return resultMap["bio"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "bio")
        }
      }

      public var favoritePosition: AthleteFavoritePosition? {
        get {
          return resultMap["favoritePosition"] as? AthleteFavoritePosition
        }
        set {
          resultMap.updateValue(newValue, forKey: "favoritePosition")
        }
      }

      public var foot: AthleteFoot? {
        get {
          return resultMap["foot"] as? AthleteFoot
        }
        set {
          resultMap.updateValue(newValue, forKey: "foot")
        }
      }

      public var preferedNumber: Int? {
        get {
          return resultMap["preferedNumber"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "preferedNumber")
        }
      }

      public var profileImage: String? {
        get {
          return resultMap["profileImage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImage")
        }
      }
    }
  }
}
