//
//  MDCMedia.swift
//
//  Created by Philip Starner on 8/13/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class MDCMedia {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let type = "type"
    static let mimeType = "mimeType"
    static let id = "id"
    static let url = "url"
  }

  // MARK: Properties
  public var type: String?
  public var mimeType: String?
  public var id: Int?
  public var url: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    type = json[SerializationKeys.type].string
    mimeType = json[SerializationKeys.mimeType].string
    id = json[SerializationKeys.id].int
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = mimeType { dictionary[SerializationKeys.mimeType] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

}
