//
//  main.swift
//  CRUD_BancoDeDados
//
//  Created by Izadora de Oliveira Albuquerque Montenegro on 28/04/25.
//
// MARK: - Models
import Foundation

FuncionarioManager.create(primeiroNome: "Izadora", inicialDoMeio: nil, ultimoNome: "Montenegro", cpf: "02902713207", salario: 1500, genero: .female, endereco: "Senador pompeu", dataDeNascimento: "06/12/2005", departamento: nil, projetos: nil)

// da pra tentar filtrar o funcionario por nome, cpf sla
ProjetoManager.create(nome: "Projeto 1", local: "Casa", funcionarios: [FuncionarioManager.funcionarios[0]])

DepartamentoManager.create(nome: "Financas", projetos: [ProjetoManager.projetos[0]], nomeFuncionarioGerente: "Izadora")








