import Foundation

// ============================================================
// Guia 3 - Swift Avançado
// Matéria: Mobile Development - iOS
// Data: 26/03/2025
// ============================================================

// MARK: - Exercício 1: Enum TipoMidia com Valores Associados

enum Resolucao {
    case sd
    case hd
    case uhd
}

enum TipoMidia {
    case musica(titulo: String, artista: String, duracao: Int)
    case video(titulo: String, duracao: Int, resolucao: Resolucao)
    case podcast(titulo: String, host: String, episodio: Int)
}

func descreverMidia(_ midia: TipoMidia) {
    switch midia {
    case .musica(let titulo, let artista, let duracao):
        let minutos = duracao / 60
        let segundos = duracao % 60
        print("🎵 Música: \"\(titulo)\" por \(artista) - Duração: \(minutos)m\(segundos)s")

    case .video(let titulo, let duracao, let resolucao):
        let minutos = duracao / 60
        let resolucaoStr: String
        switch resolucao {
        case .sd: resolucaoStr = "SD (480p)"
        case .hd: resolucaoStr = "HD (1080p)"
        case .uhd: resolucaoStr = "UHD (4K)"
        }
        print("🎬 Vídeo: \"\(titulo)\" - Duração: \(minutos)min - Resolução: \(resolucaoStr)")

    case .podcast(let titulo, let host, let episodio):
        print("🎙️ Podcast: \"\(titulo)\" - Host: \(host) - Episódio #\(episodio)")
    }
}

print("=== Exercício 1: Enum TipoMidia ===")
let musica = TipoMidia.musica(titulo: "Bohemian Rhapsody", artista: "Queen", duracao: 354)
let video = TipoMidia.video(titulo: "Swift Tutorial", duracao: 1800, resolucao: .hd)
let podcast = TipoMidia.podcast(titulo: "Swift by Sundell", host: "John Sundell", episodio: 142)

descreverMidia(musica)
descreverMidia(video)
descreverMidia(podcast)

// MARK: - Exercício 2: Função filtrarArray com Closures

func filtrarArray(_ array: [Int], criterio: (Int) -> Bool) -> [Int] {
    var resultado: [Int] = []
    for elemento in array {
        if criterio(elemento) {
            resultado.append(elemento)
        }
    }
    return resultado
}

print("\n=== Exercício 2: Closures - filtrarArray ===")
let numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25]

// Trailing closure: filtrar pares
let pares = filtrarArray(numeros) { $0 % 2 == 0 }
print("Números pares: \(pares)")

// Trailing closure: filtrar maiores que 5
let maioresQue5 = filtrarArray(numeros) { $0 > 5 }
print("Maiores que 5: \(maioresQue5)")

// Trailing closure: filtrar múltiplos de 3
let multiplosDe3 = filtrarArray(numeros) { $0 % 3 == 0 }
print("Múltiplos de 3: \(multiplosDe3)")

// Versão com capture list para evitar memory leak
class FiltroManager {
    var limiteMinimo = 10

    lazy var filtrar: ([Int]) -> [Int] = { [weak self] array in
        guard let self = self else { return [] }
        return array.filter { $0 >= self.limiteMinimo }
    }

    deinit {
        print("FiltroManager desalocado")
    }
}

var manager: FiltroManager? = FiltroManager()
let filtrados = manager?.filtrar(numeros) ?? []
print("Filtrados (>= 10) com capture list: \(filtrados)")
manager = nil

// MARK: - Exercício 3: Struct Genérica ResultadoOperacao

struct ResultadoOperacao<T, E> {
    let sucesso: T?
    let erro: E?

    static func comSucesso(_ valor: T) -> ResultadoOperacao {
        return ResultadoOperacao(sucesso: valor, erro: nil)
    }

    static func comErro(_ erro: E) -> ResultadoOperacao {
        return ResultadoOperacao(sucesso: nil, erro: erro)
    }
}

func converterStringsParaInteiros(_ strings: [String]) -> [ResultadoOperacao<Int, String>] {
    return strings.map { str in
        if let numero = Int(str) {
            return .comSucesso(numero)
        } else {
            return .comErro("'\(str)' não é um número válido")
        }
    }
}

print("\n=== Exercício 3: Generics - ResultadoOperacao ===")
let entradas = ["42", "abc", "7", "hello", "100", "3.14"]
let resultados = converterStringsParaInteiros(entradas)

for (indice, resultado) in resultados.enumerated() {
    if let valor = resultado.sucesso {
        print("Entrada[\(indice)] '\(entradas[indice])' -> Sucesso: \(valor)")
    } else if let erro = resultado.erro {
        print("Entrada[\(indice)] '\(entradas[indice])' -> Erro: \(erro)")
    }
}

// MARK: - Exercício 4: Protocolo Desenhavel com POP

protocol Desenhavel {
    var area: Double { get }
    func desenhar()
}

extension Desenhavel {
    func imprimirDescricao() {
        print("Forma com área de \(String(format: "%.2f", area)) unidades²")
    }
}

struct CirculoDesenhavel: Desenhavel {
    var raio: Double

    var area: Double {
        return Double.pi * raio * raio
    }

    func desenhar() {
        print("⭕ Desenhando círculo com raio \(raio)")
    }
}

struct RetanguloDesenhavel: Desenhavel {
    var largura: Double
    var altura: Double

    var area: Double {
        return largura * altura
    }

    func desenhar() {
        print("🟦 Desenhando retângulo \(largura) x \(altura)")
    }
}

func desenharFormas(_ formas: [Desenhavel]) {
    print("Desenhando \(formas.count) formas:")
    for forma in formas {
        forma.desenhar()
        forma.imprimirDescricao()
        print()
    }
}

print("\n=== Exercício 4: Protocol-Oriented Programming ===")
let circuloPOP = CirculoDesenhavel(raio: 5.0)
let retanguloPOP = RetanguloDesenhavel(largura: 8.0, altura: 4.0)
let circuloPequeno = CirculoDesenhavel(raio: 2.0)

let formas: [Desenhavel] = [circuloPOP, retanguloPOP, circuloPequeno]
desenharFormas(formas)
