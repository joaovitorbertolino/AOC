# AOC — Desenvolvimento de jogo para NES

Projeto desenvolvido em Assembly para o Nintendo Entertainment System (NES), como parte da disciplina de Arquitetura e Organização de Computadores (AOC).

O projeto utiliza o assembler ca65 e o linker ld65, com compilação automatizada por meio de um Makefile.

## 1. Requisitos

Para compilar o projeto, é necessário ter instalado:

- [Git](https://git-scm.com/)
- [GNU Make](https://www.gnu.org/software/make/)
- [cc65](https://cc65.github.io/), que inclui o ca65 e o ld65
- [Mesen](https://www.mesen.ca/), para executar e testar a ROM

O Mesen é necessário apenas para executar o jogo. A compilação é realizada pelo ca65, ld65 e Make.

## 2. Clonando o repositório

Clone o repositório e entre no diretório do projeto:

```bash
git clone https://github.com/joaovitorbertolino/AOC.git
cd AOC
```

## 3. Estrutura do projeto

```text
AOC/
├── build/
│   ├── main.o
│   └── teste.nes
├── cfg/
│   └── nes.cfg
├── src/
│   └── main.s
├── Makefile
└── README.md
```

Os arquivos dentro de `build/` são gerados durante a compilação e podem não estar presentes antes da primeira execução do Make.

### `src/`

Contém os arquivos-fonte Assembly do projeto.

- `main.s`: arquivo principal, contendo o cabeçalho da ROM, a inicialização da CPU, a rotina inicial de configuração da PPU e o loop principal.

Novos módulos podem ser adicionados a esse diretório conforme o desenvolvimento avançar.

### `cfg/`

Contém a configuração de memória utilizada pelo linker.

- `nes.cfg`: define as regiões de memória e os segmentos utilizados para gerar a ROM do NES.

Sempre que a organização da ROM ou dos segmentos mudar, essa configuração poderá precisar de ajustes.

### `build/`

Diretório destinado aos arquivos gerados durante a compilação.

- `main.o`: arquivo objeto produzido pelo ca65.
- `teste.nes`: ROM gerada pelo ld65, que pode ser executada no emulador.

Os arquivos desse diretório não devem ser editados manualmente, pois são resultados do processo de compilação.

### `Makefile`

Automatiza as etapas de montagem, linkedição, execução e limpeza dos arquivos gerados.

## 4. Compilação

Na raiz do repositório, execute:

```bash
make
```

O Makefile realiza as seguintes etapas:

1. O ca65 monta `src/main.s` e gera `build/main.o`.
2. O ld65 utiliza `build/main.o` e `cfg/nes.cfg` para gerar `build/teste.nes`.

Se os arquivos de entrada não tiverem sido modificados, o Make poderá reutilizar os resultados existentes.

Ao final, a ROM estará disponível em:

```text
build/teste.nes
```

### Compilação limpa

Para remover os arquivos gerados e realizar uma nova compilação:

```bash
make clean
make
```

O comando `make clean` remove os arquivos presentes em `build/`.

## 5. Executando o jogo

Para compilar e executar a ROM pelo Makefile:

```bash
make run
```

Esse comando depende de o executável do Mesen estar disponível no `PATH` com o nome `mesen`.

Caso o comando não seja reconhecido, abra o Mesen manualmente e carregue o arquivo:

```text
build/teste.nes
```

A ROM também pode ser aberta diretamente pelo emulador, sem utilizar o comando `make run`.

## 6. Como funciona o processo de compilação?

O fluxo de compilação é:

```text
src/main.s
    |
    v
   ca65
    |
    v
build/main.o
    |
    |       cfg/nes.cfg
    |              |
    +-------+------+
            |
            v
          ld65
            |
            v
    build/teste.nes
            |
            v
          Mesen
```

### ca65

Converte os arquivos Assembly em arquivos objeto.

### ld65

Combina os arquivos objeto e aplica a configuração de memória definida em `cfg/nes.cfg`, produzindo a ROM.

### Mesen

Executa a ROM para permitir testar e depurar o programa.

## 7. Organização do código Assembly

O projeto utiliza segmentos para organizar diferentes tipos de dados e código.

Os segmentos atualmente utilizados em `main.s` são:

| Segmento | Finalidade |
|---|---|
| `HEADER` | Cabeçalho iNES, que identifica o formato da ROM e informa características básicas da organização do cartucho. |
| `ZEROPAGE` | Região destinada a variáveis que utilizam endereçamento de página zero. |
| `CODE` | Código executável do programa. |
| `VECTORS` | Vetores de reset e interrupções, localizados no final do espaço de endereçamento da CPU. |

Esses segmentos são associados às regiões de memória correspondentes em `cfg/nes.cfg`.

Ao adicionar novos arquivos Assembly, é importante verificar se os segmentos utilizados estão definidos na configuração do linker.

## 8. Fluxo de trabalho recomendado

Para contribuir com o projeto:

1. Atualize sua cópia local do repositório.
2. Implemente as alterações nos arquivos de código-fonte.
3. Execute `make` para compilar.
4. Abra a ROM no Mesen e teste as alterações.
5. Verifique se a compilação e a execução continuam funcionando antes de enviar suas mudanças.

Evite editar manualmente os arquivos gerados em `build/`. As alterações devem ser feitas nos arquivos-fonte e nas configurações do projeto.

## 9. Estado atual

A estrutura básica de compilação está configurada.

O código inicial contém o cabeçalho iNES, a rotina de reset, configurações iniciais da CPU e da PPU, uma espera pelo VBlank, uma escrita inicial na PPU e um loop principal.

As mecânicas do jogo e os demais recursos gráficos ainda serão desenvolvidos.

---
