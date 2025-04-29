//
//  Funcionário.swift
//  CRUD_BancoDeDados
//
//  Created by Izadora de Oliveira Albuquerque Montenegro on 28/04/25.
//

struct Funcionario: Codable {
    var nome: NomeFuncionario
    var cpf: String
    var salario: Double
    var endereco: String
    var genero: GenderOptions
    var dataDeNascimento: String
    var departamento: Departamento?
    var projetos: [Projeto]?
}

enum GenderOptions: String, Codable {
    case male, female, other

    var displayText: String {
        switch self {
        case .male: return "Masculino"
        case .female: return "Feminino"
        case .other: return "Outro"
        }
    }
}
