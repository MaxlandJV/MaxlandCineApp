//
//  MovieImportExportModel.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 31/1/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct MovieImportExportModel: Encodable, Decodable {
    public var isSerie: Bool
    public var movieName: String?
    public var score: Int16
    public var showDate: Date?
    public var sinopsis: String?
}

struct JsonFile: FileDocument {
    static var readableContentTypes = [UTType.json]
    var json = ""
    
    init(json: String = "") {
        self.json = json
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            fatalError("Error exportando datos")
        }
        json = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: json.data(using: .utf8)!)
    }
}
