// ============================================================
// Guia 2 - Programação Orientada a Objetos em Swift
// Matéria: Mobile Development - iOS
// Data: 19/03/2025
// ============================================================

// MARK: - Exercício 1: Classe Carro com willSet

class CarroOOP {
    var marca: String
    var modelo: String
    var ano: Int {
        willSet {
            print("O ano do carro vai mudar de \(ano) para \(newValue)")
        }
        didSet {
            print("O ano do carro mudou de \(oldValue) para \(ano)")
        }
    }

    init(marca: String, modelo: String, ano: Int) {
        self.marca = marca
        self.modelo = modelo
        self.ano = ano
    }
}

print("=== Exercício 1: Classe Carro com willSet ===")
let carro1 = CarroOOP(marca: "Honda", modelo: "Civic", ano: 2020)
print("Carro: \(carro1.marca) \(carro1.modelo), Ano: \(carro1.ano)")
carro1.ano = 2024

// MARK: - Exercício 2: Classe Pessoa com init e deinit

class Pessoa {
    var nome: String
    var idade: Int

    init(nome: String, idade: Int) {
        self.nome = nome
        self.idade = idade
        print("Pessoa '\(nome)' criada com \(idade) anos.")
    }

    func exibirInformacoes() {
        print("Nome: \(nome), Idade: \(idade) anos")
    }

    deinit {
        print("Pessoa '\(nome)' foi desalocada da memória.")
    }
}

print("\n=== Exercício 2: Classe Pessoa com init e deinit ===")
var pessoa1: Pessoa? = Pessoa(nome: "João", idade: 30)
pessoa1?.exibirInformacoes()
pessoa1 = nil

// MARK: - Exercício 3: Herança - Animal e Cachorro

class Animal {
    private var nome: String

    init(nome: String) {
        self.nome = nome
    }

    func fazerSom() {
        print("Som genérico de animal")
    }

    func getNome() -> String {
        return nome
    }
}

class Cachorro: Animal {
    override init(nome: String) {
        super.init(nome: nome)
    }

    override func fazerSom() {
        print("Au Au!")
    }
}

class Gato: Animal {
    override init(nome: String) {
        super.init(nome: nome)
    }

    override func fazerSom() {
        print("Miau!")
    }
}

print("\n=== Exercício 3: Herança e Polimorfismo ===")
let animalGenerico = Animal(nome: "Animal Genérico")
let meuCachorro = Cachorro(nome: "Rex")
let meuGato = Gato(nome: "Snow")

animalGenerico.fazerSom()
print(animalGenerico.getNome())

meuCachorro.fazerSom()
print(meuCachorro.getNome())

meuGato.fazerSom()
print(meuGato.getNome())

// Polimorfismo com array
let animais: [Animal] = [animalGenerico, meuCachorro, meuGato]
print("\nIterando pelo array de animais:")
for animal in animais {
    animal.fazerSom()
    print(animal.getNome())
}

// MARK: - Exercício 4: Override e Final

class Funcionario {
    var nome: String
    var salarioBase: Double

    init(nome: String, salarioBase: Double) {
        self.nome = nome
        self.salarioBase = salarioBase
    }

    func calcularSalario() -> Double {
        return salarioBase
    }

    func exibirSalario() {
        print("\(nome) - Salário: R$ \(calcularSalario())")
    }
}

final class Gerente: Funcionario {
    var bonus: Double

    init(nome: String, salarioBase: Double, bonus: Double) {
        self.bonus = bonus
        super.init(nome: nome, salarioBase: salarioBase)
    }

    override func calcularSalario() -> Double {
        return salarioBase + bonus
    }
}

print("\n=== Exercício 4: Override e Final ===")
let funcionario = Funcionario(nome: "Maria", salarioBase: 3000.0)
let gerente = Gerente(nome: "Carlos", salarioBase: 5000.0, bonus: 2000.0)

funcionario.exibirSalario()
gerente.exibirSalario()

// MARK: - Exercício 5: Protocolo FormaGeometrica

protocol FormaGeometrica {
    func calcularArea() -> Double
}

struct Retangulo: FormaGeometrica {
    var largura: Double
    var altura: Double

    func calcularArea() -> Double {
        return largura * altura
    }
}

struct Circulo: FormaGeometrica {
    var raio: Double

    func calcularArea() -> Double {
        return Double.pi * raio * raio
    }
}

print("\n=== Exercício 5: Protocolo FormaGeometrica ===")
let retangulo = Retangulo(largura: 5.0, altura: 3.0)
let circulo = Circulo(raio: 4.0)

print("Área do retângulo: \(retangulo.calcularArea())")
print("Área do círculo: \(circulo.calcularArea())")

// MARK: - Exercício 6: Struct Ponto - Valor vs Referência

struct PontoStruct {
    var x: Int
    var y: Int
}

class PontoClass {
    var x: Int
    var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

print("\n=== Exercício 6: Struct vs Class (Valor vs Referência) ===")

// Struct (tipo de valor) - cópia independente
var pontoA = PontoStruct(x: 10, y: 20)
var pontoB = pontoA
pontoB.x = 30
print("Struct - pontoA.x = \(pontoA.x) (não alterado)")
print("Struct - pontoB.x = \(pontoB.x) (cópia alterada)")

// Class (tipo de referência) - mesma instância
var pontoC = PontoClass(x: 10, y: 20)
var pontoD = pontoC
pontoD.x = 30
print("Class - pontoC.x = \(pontoC.x) (alterado pela referência)")
print("Class - pontoD.x = \(pontoD.x) (mesma referência)")

// ============================================================
// MARK: - Desafio: Sistema de Gerenciamento de Dispositivos Eletrônicos
// ============================================================

print("\n========== SISTEMA DE GERENCIAMENTO DE DISPOSITIVOS ==========\n")

// Classe Base
class DispositivoEletronico {
    let marca: String
    var modelo: String
    var preco: Double {
        willSet {
            print("Preço de \(marca) \(modelo) vai mudar de R$ \(preco) para R$ \(newValue)")
        }
        didSet {
            print("Preço de \(marca) \(modelo) mudou de R$ \(oldValue) para R$ \(preco)")
        }
    }
    private(set) var numeroSerie: String
    var ligado: Bool

    var precoComDesconto: Double {
        return preco * 0.9
    }

    init(marca: String, modelo: String, preco: Double) {
        self.marca = marca
        self.modelo = modelo
        self.preco = preco
        self.numeroSerie = "SN-\(Int.random(in: 10000...99999))"
        self.ligado = false
        print("Dispositivo \(marca) \(modelo) criado! (S/N: \(self.numeroSerie))")
    }

    convenience init(marca: String, modelo: String) {
        self.init(marca: marca, modelo: modelo, preco: 99.99)
        print("Inicialização rápida de \(marca) \(modelo)")
    }

    func ligar() {
        if !ligado {
            ligado = true
            print("\(marca) \(modelo) ligado.")
        } else {
            print("\(marca) \(modelo) já está ligado.")
        }
    }

    func desligar() {
        if ligado {
            ligado = false
            print("\(marca) \(modelo) desligado.")
        } else {
            print("\(marca) \(modelo) já está desligado.")
        }
    }

    func exibirDetalhes() {
        let status = ligado ? "Ligado" : "Desligado"
        print("[\(marca)] \(modelo) | S/N: \(numeroSerie) | Preço: R$ \(preco) | Status: \(status)")
    }

    func aplicarDesconto(percentual: Double) {
        preco -= preco * (percentual / 100)
    }

    deinit {
        print("Dispositivo \(marca) \(modelo) sendo destruído.")
    }
}

// Subclasse Smartphone
final class Smartphone: DispositivoEletronico {
    var tamanhoTela: Double
    var temCamera: Bool

    init(marca: String, modelo: String, preco: Double, tamanhoTela: Double, temCamera: Bool) {
        self.tamanhoTela = tamanhoTela
        self.temCamera = temCamera
        super.init(marca: marca, modelo: modelo, preco: preco)
    }

    override func exibirDetalhes() {
        super.exibirDetalhes()
        print("  Tela: \(tamanhoTela)\" | Câmera: \(temCamera ? "Sim" : "Não")")
    }

    func tirarFoto() {
        guard ligado else {
            print("O dispositivo precisa estar ligado para tirar foto.")
            return
        }
        guard temCamera else {
            print("Este dispositivo não possui câmera.")
            return
        }
        print("📸 Foto tirada com o \(marca) \(modelo)!")
    }
}

// Subclasse Notebook
class Notebook: DispositivoEletronico {
    var tamanhoTela: Double
    var capacidadeArmazenamento: Int

    init(marca: String, modelo: String, preco: Double, tamanhoTela: Double, capacidadeArmazenamento: Int) {
        self.tamanhoTela = tamanhoTela
        self.capacidadeArmazenamento = capacidadeArmazenamento
        super.init(marca: marca, modelo: modelo, preco: preco)
    }

    override func exibirDetalhes() {
        super.exibirDetalhes()
        print("  Tela: \(tamanhoTela)\" | Armazenamento: \(capacidadeArmazenamento)GB")
    }
}

// Protocolo Atualizavel
protocol Atualizavel {
    func atualizarSoftware()
}

// Extensão do Notebook para implementar Atualizavel
extension Notebook: Atualizavel {
    func atualizarSoftware() {
        print("💻 Software do \(marca) \(modelo) foi atualizado com sucesso!")
    }
}

// Extensão de String
extension String {
    func formatarParaNumeroSerie(tamanho: Int = 10) -> String {
        if self.count >= tamanho {
            return String(self.prefix(tamanho))
        }
        return String(repeating: "0", count: tamanho - self.count) + self
    }
}

// Struct Acessório (tipo de valor - não precisa de herança, identidade ou estado complexo)
struct Acessorio {
    var nome: String
    var preco: Double
    var compativel: String

    func exibirDetalhes() {
        print("Acessório: \(nome) | Preço: R$ \(preco) | Compatível com: \(compativel)")
    }
}

// Demonstração
let iphone = Smartphone(marca: "Apple", modelo: "iPhone 15", preco: 7999.0, tamanhoTela: 6.1, temCamera: true)
let macbook = Notebook(marca: "Apple", modelo: "MacBook Pro", preco: 15999.0, tamanhoTela: 14.0, capacidadeArmazenamento: 512)

iphone.ligar()
iphone.tirarFoto()

macbook.ligar()
macbook.atualizarSoftware()

// Polimorfismo com array
print("\n--- Polimorfismo com Array ---")
let dispositivos: [DispositivoEletronico] = [iphone, macbook]
for dispositivo in dispositivos {
    dispositivo.exibirDetalhes()
    print()
}

// Desconto
print("--- Aplicando desconto ---")
macbook.aplicarDesconto(percentual: 15)
print("Preço com desconto de 10%: R$ \(macbook.precoComDesconto)")

// Extensão String
print("\n--- Extensão String ---")
let serial = "ABC12"
print("Número de série formatado: \(serial.formatarParaNumeroSerie())")

// Struct Acessório
print("\n--- Acessório (Struct) ---")
let capa = Acessorio(nome: "Capa de Silicone", preco: 79.90, compativel: "iPhone 15")
capa.exibirDetalhes()
