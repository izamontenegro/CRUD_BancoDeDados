//
//  main.swift
//  CRUD_BancoDeDados
//
//  Created by Izadora de Oliveira Albuquerque Montenegro on 28/04/25.
//
// MARK: - Models
import Foundation

// Populando o banco com funcionarios

FuncionarioManager.create(primeiroNome: "Carlos", inicialDoMeio: "M", ultimoNome: "Silva", cpf: "12345678901", salario: 4200, genero: .male, endereco: "Rua das Palmeiras", dataDeNascimento: "05/12/1985", departamento: nil, projetos: nil)

FuncionarioManager.create(primeiroNome: "Marina", inicialDoMeio: "L", ultimoNome: "Souza", cpf: "98765432100", salario: 6100, genero: .female, endereco: "Av. Central, 102", dataDeNascimento: "11/30/1992", departamento: nil, projetos: nil)

FuncionarioManager.create(primeiroNome: "Eduardo", inicialDoMeio: "K", ultimoNome: "Ferreira", cpf: "45678912345", salario: 5400, genero: .male, endereco: "Travessa Boa Vista", dataDeNascimento: "03/15/1978", departamento: nil, projetos: nil)

// Populando o banco com departamentos

DepartamentoManager.create(nome: "Marketing", projetos: [], nomeFuncionarioGerente: FuncionarioManager.funcionarios[0], numero: 856)

// manipulando os projetos

ProjetoManager.menuProjeto()









