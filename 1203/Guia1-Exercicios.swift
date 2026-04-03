// ============================================================
// Guia 1 - Exercícios de Swift (Básico a Intermediário)
// Matéria: Mobile Development - iOS
// Data: 12/03/2025
// ============================================================

// MARK: - Exercício 1: Variáveis e Constantes

let nome = "Lucas"
var idade = 22

print("Nome: \(nome)")
print("Idade: \(idade)")

idade = 23
print("Idade atualizada: \(idade)")

// MARK: - Exercício 2: Verificação de Par ou Ímpar

let numero = 7

if numero % 2 == 0 {
    print("\(numero) é par")
} else {
    print("\(numero) é ímpar")
}

// MARK: - Exercício 3: Imprimir Números Pares de 1 a 10

print("Números pares de 1 a 10:")
for i in 1...10 where i % 2 == 0 {
    print(i)
}

// MARK: - Exercício 4: Função para Somar Números

func soma(_ a: Int, _ b: Int) -> Int {
    return a + b
}

let resultadoSoma = soma(10, 25)
print("A soma de 10 + 25 = \(resultadoSoma)")

// MARK: - Exercício 5: Iterando sobre um Array de Nomes

let nomes = ["Alice", "Bruno", "Carlos", "Diana", "Eduardo"]

print("Lista de nomes:")
for nomePessoa in nomes {
    print("- \(nomePessoa)")
}

// MARK: - Exercício 6: Criando e Acessando um Dicionário

let paisesCapitais = [
    "Brasil": "Brasília",
    "Argentina": "Buenos Aires",
    "Japão": "Tóquio",
    "França": "Paris",
    "Alemanha": "Berlim"
]

if let capitalBrasil = paisesCapitais["Brasil"] {
    print("A capital do Brasil é \(capitalBrasil)")
}

print("\nTodos os países e capitais:")
for (pais, capital) in paisesCapitais {
    print("\(pais): \(capital)")
}

// MARK: - Exercício 7: Usando Optionals com if let e guard let

var nomeOpcional: String? = "Maria"

// Usando if let
if let nomeDesempacotado = nomeOpcional {
    print("O nome é \(nomeDesempacotado)")
} else {
    print("Nome não definido")
}

// Usando guard let dentro de uma função
func imprimirNome(_ nome: String?) {
    guard let nomeDesempacotado = nome else {
        print("Nome não definido")
        return
    }
    print("O nome (guard let) é \(nomeDesempacotado)")
}

imprimirNome(nomeOpcional)
imprimirNome(nil)

// MARK: - Exercício 8: Verificação de Nota com Switch

let nota = "B"

switch nota {
case "A":
    print("Excelente! Nota máxima.")
case "B":
    print("Muito bom! Acima da média.")
case "C":
    print("Bom. Na média.")
case "D":
    print("Abaixo da média. Precisa melhorar.")
case "F":
    print("Reprovado. Estude mais!")
default:
    print("Nota inválida.")
}

// MARK: - Exercício 9: Usando Tuplas para Representar um Produto

let produto = (nome: "Notebook", preco: 4599.90, quantidade: 15)

print("Produto: \(produto.nome)")
print("Preço: R$ \(produto.preco)")
print("Quantidade em estoque: \(produto.quantidade)")

// MARK: - Exercício 10: Criando uma Struct para um Carro

struct Carro {
    var marca: String
    var modelo: String
    var ano: Int
}

let meuCarro = Carro(marca: "Toyota", modelo: "Corolla", ano: 2023)
print("Carro: \(meuCarro.marca) \(meuCarro.modelo), Ano: \(meuCarro.ano)")

// ============================================================
// MARK: - Desafio: Sistema de Cadastro de Livros
// ============================================================

struct Livro {
    var titulo: String
    var autor: String
    var anoPublicacao: Int
    var disponibilidade: Bool
}

var listaLivros: [Livro] = []

func adicionarLivro(titulo: String, autor: String, anoPublicacao: Int, disponibilidade: Bool) {
    let novoLivro = Livro(titulo: titulo, autor: autor, anoPublicacao: anoPublicacao, disponibilidade: disponibilidade)
    listaLivros.append(novoLivro)
    print("Livro '\(titulo)' adicionado com sucesso!")
}

func listarLivros() {
    print("\nLista de Livros:")
    for (indice, livro) in listaLivros.enumerated() {
        let status = livro.disponibilidade ? "Sim" : "Não"
        print("\(indice + 1). Título: \(livro.titulo) | Autor: \(livro.autor) | Ano: \(livro.anoPublicacao) | Disponível: \(status)")
    }
}

func alterarDisponibilidade(titulo: String) {
    print("\nAlterando disponibilidade do livro '\(titulo)'...")

    guard let indice = listaLivros.firstIndex(where: { $0.titulo == titulo }) else {
        print("Livro não encontrado.")
        return
    }

    listaLivros[indice].disponibilidade.toggle()

    switch listaLivros[indice].disponibilidade {
    case true:
        print("O livro '\(titulo)' está disponível novamente!")
    case false:
        print("O livro '\(titulo)' foi emprestado!")
    }
}

func buscarLivro(titulo: String) {
    print("\nProcurando pelo livro '\(titulo)'...")

    let livroEncontrado: Livro? = listaLivros.first(where: { $0.titulo == titulo })

    if let livro = livroEncontrado {
        let status = livro.disponibilidade ? "Sim" : "Não"
        print("Livro encontrado! Título: \(livro.titulo) | Autor: \(livro.autor) | Ano: \(livro.anoPublicacao) | Disponível: \(status)")
    } else {
        print("Livro não encontrado.")
    }
}

// Executando o sistema
print("\n========== SISTEMA DE CADASTRO DE LIVROS ==========\n")

adicionarLivro(titulo: "O Senhor dos Anéis", autor: "J.R.R. Tolkien", anoPublicacao: 1954, disponibilidade: true)
adicionarLivro(titulo: "Harry Potter", autor: "J.K. Rowling", anoPublicacao: 1997, disponibilidade: true)

listarLivros()

alterarDisponibilidade(titulo: "Harry Potter")

listarLivros()

buscarLivro(titulo: "O Hobbit")
buscarLivro(titulo: "O Senhor dos Anéis")
