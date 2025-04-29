//
//  FileManager.swift
//  CRUD_BancoDeDados
//
//  Created by Izadora de Oliveira Albuquerque Montenegro on 28/04/25.
//

import Foundation

class FileHelper {
    static func save<T: Codable>(_ objects: [T], to filename: String) {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(objects)
            let url = getDocumentsDirectory().appendingPathComponent(filename)
            try data.write(to: url)
            print("Arquivo salvo em: \(url)")
        } catch {
            print("Erro ao salvar arquivo: \(error)")
        }
    }

    static func load<T: Codable>(from filename: String) -> [T] {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let objects = try decoder.decode([T].self, from: data)
            return objects
        } catch {
            print("Erro ao carregar arquivo: \(error)")
            return []
        }
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


