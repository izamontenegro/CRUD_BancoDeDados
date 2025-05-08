//
//  Departamento.swift
//  CRUD_BancoDeDados
//
//  Created by Izadora de Oliveira Albuquerque Montenegro on 28/04/25.
//

import Foundation

struct Departamento: Codable {
    var nome: String
    var projetos: [Projeto]
    var funcionarioGerente: [Funcionario]
    var numero: Int
}

// aqui to usando string pra armazenar o nome do funcionario gerente, se usasse o tipo funcionario ia dar uma referencia circular mucho loca
