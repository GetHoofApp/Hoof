// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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

public final class CreateUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateUser($username: String!, $password: String!, $email: String!, $gender: String!, $bio: String, $favoritePosition: String, $foot: String, $preferedNumber: Int) {
      createUser(
        username: $username
        email: $email
        password: $password
        gender: $gender
        bio: $bio
        favoritePosition: $favoritePosition
        foot: $foot
        preferedNumber: $preferedNumber
      ) {
        __typename
        id
        username
        email
        gender
        bio
        favoritePosition
        foot
        preferedNumber
      }
    }
    """

  public let operationName: String = "CreateUser"

  public var username: String
  public var password: String
  public var email: String
  public var gender: String
  public var bio: String?
  public var favoritePosition: String?
  public var foot: String?
  public var preferedNumber: Int?

  public init(username: String, password: String, email: String, gender: String, bio: String? = nil, favoritePosition: String? = nil, foot: String? = nil, preferedNumber: Int? = nil) {
    self.username = username
    self.password = password
    self.email = email
    self.gender = gender
    self.bio = bio
    self.favoritePosition = favoritePosition
    self.foot = foot
    self.preferedNumber = preferedNumber
  }

  public var variables: GraphQLMap? {
    return ["username": username, "password": password, "email": email, "gender": gender, "bio": bio, "favoritePosition": favoritePosition, "foot": foot, "preferedNumber": preferedNumber]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createUser", arguments: ["username": GraphQLVariable("username"), "email": GraphQLVariable("email"), "password": GraphQLVariable("password"), "gender": GraphQLVariable("gender"), "bio": GraphQLVariable("bio"), "favoritePosition": GraphQLVariable("favoritePosition"), "foot": GraphQLVariable("foot"), "preferedNumber": GraphQLVariable("preferedNumber")], type: .object(CreateUser.selections)),
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
          GraphQLField("username", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("gender", type: .scalar(String.self)),
          GraphQLField("bio", type: .scalar(String.self)),
          GraphQLField("favoritePosition", type: .scalar(String.self)),
          GraphQLField("foot", type: .scalar(String.self)),
          GraphQLField("preferedNumber", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int? = nil, username: String? = nil, email: String? = nil, gender: String? = nil, bio: String? = nil, favoritePosition: String? = nil, foot: String? = nil, preferedNumber: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "CreateUser", "id": id, "username": username, "email": email, "gender": gender, "bio": bio, "favoritePosition": favoritePosition, "foot": foot, "preferedNumber": preferedNumber])
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

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
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

      public var bio: String? {
        get {
          return resultMap["bio"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "bio")
        }
      }

      public var favoritePosition: String? {
        get {
          return resultMap["favoritePosition"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "favoritePosition")
        }
      }

      public var foot: String? {
        get {
          return resultMap["foot"] as? String
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
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, username: String, email: String, gender: AthleteGender? = nil, bio: String? = nil, favoritePosition: AthleteFavoritePosition? = nil, foot: AthleteFoot? = nil, preferedNumber: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserType", "id": id, "username": username, "email": email, "gender": gender, "bio": bio, "favoritePosition": favoritePosition, "foot": foot, "preferedNumber": preferedNumber])
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
    }
  }
}
