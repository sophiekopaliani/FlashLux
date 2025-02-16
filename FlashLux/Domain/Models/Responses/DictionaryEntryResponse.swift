//
//  DictionaryEntryResponse.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

public struct DictionaryEntryResponse {
  public let entry: Entry
  public let entryImage: String
  public let previousEntries: [EntryReference]
  public let nextEntries: [EntryReference]

  public init(
    entry: Entry,
    entryImage: String,
    previousEntries: [EntryReference] = [],
    nextEntries: [EntryReference] = []
  ) {
    self.entry = entry
    self.entryImage = entryImage
    self.previousEntries = previousEntries
    self.nextEntries = nextEntries
  }
}

extension DictionaryEntryResponse: Codable { }
extension DictionaryEntryResponse: Equatable { }
extension DictionaryEntryResponse: Hashable { }
extension DictionaryEntryResponse: Sendable { }

// MARK: - Entry Reference
public struct EntryReference {
  public let lodID: String
  public let lemma: String

  public init(lodID: String, lemma: String) {
    self.lodID = lodID
    self.lemma = lemma
  }
}

extension EntryReference: Codable { }
extension EntryReference: Equatable { }
extension EntryReference: Hashable { }
extension EntryReference: Sendable { }

// MARK: - Entry
public struct Entry {
  public let lodID: String
  public let partOfSpeech: String
  public let partOfSpeechLabel: String
  public let lemma: String
  public let nRuleForm: String?
  public let trademark: Bool
  public let ipa: String
  public let tables: Tables?
  public let microStructures: [MicroStructure]
  public let audioString: String
  public let audioFiles: AudioFiles
//  public let allSynonyms: AllSynonyms?
//  public let videos: [VideoReference]
 // public let infoboxes: InfoBoxes?
  public let categories: [Category]
}

extension Entry: Codable {
  enum CodingKeys: String, CodingKey {
    case partOfSpeech,
      partOfSpeechLabel,
      lemma,
      nRuleForm,
      trademark,
      ipa,
      tables,
      microStructures,
      audioString,
      audioFiles,
 //     allSynonyms,
//      videos,
    //  infoboxes,
      categories
    case lodID = "lod_id"
  }
}
extension Entry: Equatable { }
extension Entry: Hashable { }
extension Entry: Sendable { }

// MARK: - Tables
public struct Tables {
  public let verbConjugation: VerbConjugation?
}

extension Tables: Codable { }
extension Tables: Equatable { }
extension Tables: Hashable { }
extension Tables: Sendable { }

// MARK: - Verb Conjugation
public struct VerbConjugation {
  public let attributes: VerbAttributes?
  public let infinitive: String?
  public let pastParticiple: String?
  public let auxiliaryVerb: String?
  public let indicative: VerbTenses?
  public let conditional: VerbTenses?
  public let imperative: ImperativeTense?
}

extension VerbConjugation: Codable {
  enum CodingKeys: String, CodingKey {
    case infinitive, pastParticiple, auxiliaryVerb, indicative, conditional, imperative
    case attributes = "@attributes"
  }
}
extension VerbConjugation: Equatable { }
extension VerbConjugation: Hashable { }
extension VerbConjugation: Sendable { }

public struct VerbAttributes {
  public let id: String?
  public let model: String?
  public let separableVerb: String?

  enum CodingKeys: String, CodingKey {
    case id, model
    case separableVerb = "separableVerb"
  }
}

extension VerbAttributes: Codable { }
extension VerbAttributes: Equatable { }
extension VerbAttributes: Hashable { }
extension VerbAttributes: Sendable { }

// MARK: - Verb Tenses
public struct VerbTenses {
  public let present: VerbConjugationForms?
  public let pastSimple: VerbConjugationForms?
  public let presentPerfect: VerbConjugationForms?
  public let pastPerfect: VerbConjugationForms?
  public let presentSimple: VerbConjugationForms?
}

extension VerbTenses: Codable { }
extension VerbTenses: Equatable { }
extension VerbTenses: Hashable { }
extension VerbTenses: Sendable { }

public struct VerbConjugationForms {
  public let p1: String?
  public let p2: String?
  public let p3: String?
  public let p4: String?
  public let p5: String?
  public let p6: String?
}

extension VerbConjugationForms: Codable { }
extension VerbConjugationForms: Equatable { }
extension VerbConjugationForms: Hashable { }
extension VerbConjugationForms: Sendable { }

public struct ImperativeTense {
  public let present: ImperativeForms
}

extension ImperativeTense: Codable { }
extension ImperativeTense: Equatable { }
extension ImperativeTense: Hashable { }
extension ImperativeTense: Sendable { }

public struct ImperativeForms {
  public let p2: String?
  public let p5: String?
}

extension ImperativeForms: Codable { }
extension ImperativeForms: Equatable { }
extension ImperativeForms: Hashable { }
extension ImperativeForms: Sendable { }

// MARK: - Audio Files
public struct AudioFiles {
  public let ogg: String?
  public let aac: String?
}

extension AudioFiles: Codable { }
extension AudioFiles: Equatable { }
extension AudioFiles: Hashable { }
extension AudioFiles: Sendable { }

public struct AllSynonyms: Codable {
  public let synonymGroups: [SynonymGroup]?
}

extension AllSynonyms: Equatable { }
extension AllSynonyms: Hashable { }
extension AllSynonyms: Sendable { }

public struct SynonymGroup: Codable {
  public let number: Int?
  public let attributes: [String]?
  public let fromTerms: [String]?
  public let toSynonyms: [Synonym]?
}

extension SynonymGroup: Equatable { }
extension SynonymGroup: Hashable { }
extension SynonymGroup: Sendable { }

public struct Synonym: Codable {
  public let syn: String
}
extension Synonym: Equatable { }
extension Synonym: Hashable { }
extension Synonym: Sendable { }

// MARK: - Micro Structure
public struct MicroStructure {
  public let partOfSpeech: String
  public let partOfSpeechLabel: String
  public let auxiliaryVerb: String?
  public let pastParticiple: [String]?
  public let grammaticalUnits: [GrammaticalUnit]?
}

extension MicroStructure: Codable { }
extension MicroStructure: Equatable { }
extension MicroStructure: Hashable { }
extension MicroStructure: Sendable { }

public struct GrammaticalUnit {
  public let grammaticalInformation: [String]?
  public let meanings: [Meaning]
  public let attributes: [String]?
}

extension GrammaticalUnit: Codable { }
extension GrammaticalUnit: Equatable { }
extension GrammaticalUnit: Hashable { }
extension GrammaticalUnit: Sendable { }

public struct Meaning {
  public let meaningID: String
  public let number: Int?
  public let meaningVideo: String?
  public let secondaryHeadword: String?
  public let attributes: [String]?
  public let targetLanguages: [String: LanguageTranslation]
  public let examples: [Example]
}

extension Meaning: Codable { }
extension Meaning: Equatable { }
extension Meaning: Hashable { }
extension Meaning: Sendable { }

// Add remaining necessary structs following same pattern...

// MARK: - Language Translation
public struct LanguageTranslation {
  public let parts: [TranslationPart]

  public init(parts: [TranslationPart] = []) {
    self.parts = parts
  }
}

public struct TranslationPart {
  public let type: String
  public let content: String

  public init(type: String, content: String) {
    self.type = type
    self.content = content
  }
}

// MARK: - Example
public struct Example {
  public let parts: [ExamplePart]
  public let hasInfobox: Bool
  public let audioFiles: AudioFiles?

  public init(
    parts: [ExamplePart],
    hasInfobox: Bool,
    audioFiles: AudioFiles? = nil
  ) {
    self.parts = parts
    self.hasInfobox = hasInfobox
    self.audioFiles = audioFiles
  }
}

public struct ExamplePart {
  public let type: String
  public let parts: [TextPart]

  public init(type: String, parts: [TextPart]) {
    self.type = type
    self.parts = parts
  }
}

public struct TextPart {
  public let type: String
  public let content: String
  public let joinWithPreviousWord: Bool?

  public init(
    type: String,
    content: String,
    joinWithPreviousWord: Bool? = nil
  ) {
    self.type = type
    self.content = content
    self.joinWithPreviousWord = joinWithPreviousWord
  }
}

// MARK: - Video Reference
public struct VideoReference {
  public let meaningID: String
  public let meaningVideo: String
  public let meaningNumber: Int?

  public init(
    meaningID: String,
    meaningVideo: String,
    meaningNumber: Int?
  ) {
    self.meaningID = meaningID
    self.meaningVideo = meaningVideo
    self.meaningNumber = meaningNumber
  }
}

// MARK: - InfoBoxes
public struct InfoBoxes {
  public let seeAlso: [InfoBoxItem]?

  public init(seeAlso: [InfoBoxItem] = []) {
    self.seeAlso = seeAlso
  }
}

public struct InfoBoxItem {
  public let label: String
  public let type: String
  public let content: [InfoBoxContent]
  public let intro: String
  public let concernsExample: Bool

  public init(
    label: String,
    type: String,
    content: [InfoBoxContent],
    intro: String,
    concernsExample: Bool
  ) {
    self.label = label
    self.type = type
    self.content = content
    self.intro = intro
    self.concernsExample = concernsExample
  }
}

public struct InfoBoxContent {
  public let tag: String
  public let layout: String?
  public let items: [InfoBoxListItem]

  public init(
    tag: String,
    layout: String? = nil,
    items: [InfoBoxListItem]
  ) {
    self.tag = tag
    self.layout = layout
    self.items = items
  }
}

public struct InfoBoxListItem {
  public let tag: String
  public let items: [InfoBoxLink]

  public init(tag: String, items: [InfoBoxLink]) {
    self.tag = tag
    self.items = items
  }
}

public struct InfoBoxLink {
  public let tag: String
  public let content: String
  public let idRef: String

  public init(
    tag: String,
    content: String,
    idRef: String
  ) {
    self.tag = tag
    self.content = content
    self.idRef = idRef
  }
}

// MARK: - Category
public struct Category {
  public let label: String
  public let code: String

  public init(label: String, code: String) {
    self.label = label
    self.code = code
  }
}

// MARK: - Protocol Conformance Extensions
extension LanguageTranslation: Codable { }
extension LanguageTranslation: Equatable { }
extension LanguageTranslation: Hashable { }
extension LanguageTranslation: Sendable { }

extension TranslationPart: Codable { }
extension TranslationPart: Equatable { }
extension TranslationPart: Hashable { }
extension TranslationPart: Sendable { }

extension Example: Codable { }
extension Example: Equatable { }
extension Example: Hashable { }
extension Example: Sendable { }

extension ExamplePart: Codable { }
extension ExamplePart: Equatable { }
extension ExamplePart: Hashable { }
extension ExamplePart: Sendable { }

extension TextPart: Codable { }
extension TextPart: Equatable { }
extension TextPart: Hashable { }
extension TextPart: Sendable { }

extension VideoReference: Codable { }
extension VideoReference: Equatable { }
extension VideoReference: Hashable { }
extension VideoReference: Sendable { }

extension InfoBoxes: Codable { }
extension InfoBoxes: Equatable { }
extension InfoBoxes: Hashable { }
extension InfoBoxes: Sendable { }

extension InfoBoxItem: Codable { }
extension InfoBoxItem: Equatable { }
extension InfoBoxItem: Hashable { }
extension InfoBoxItem: Sendable { }

extension InfoBoxContent: Codable { }
extension InfoBoxContent: Equatable { }
extension InfoBoxContent: Hashable { }
extension InfoBoxContent: Sendable { }

extension InfoBoxListItem: Codable { }
extension InfoBoxListItem: Equatable { }
extension InfoBoxListItem: Hashable { }
extension InfoBoxListItem: Sendable { }

extension InfoBoxLink: Codable { }
extension InfoBoxLink: Equatable { }
extension InfoBoxLink: Hashable { }
extension InfoBoxLink: Sendable { }

extension Category: Codable { }
extension Category: Equatable { }
extension Category: Hashable { }
extension Category: Sendable { }
