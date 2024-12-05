# Sistema de Cadastro de Livros em XML

Este projeto é um sistema em Assembly que permite ao usuário cadastrar informações sobre livros em um arquivo XML. O programa solicita ao usuário o título, autor, ano e editora de cada livro e salva essas informações em um arquivo XML.

## Funcionalidades

- Adicionar múltiplos livros com informações como título, autor, ano e editora.
- Salvar os dados em um arquivo XML formatado corretamente.
- Verificar se o arquivo já existe e, se não existir, criar um novo.
- Permitir que o usuário adicione mais livros ou finalize a entrada.

## Estrutura do Código

O código é escrito em Assembly e utiliza chamadas de sistema para interagir com o sistema operacional. As principais seções do código incluem:

- **Definição de Dados**: Onde são definidos os prompts, buffers e tags XML.
- **Função Principal (`main`)**: Controla o fluxo do programa, incluindo a verificação da existência do arquivo e a leitura dos dados do usuário.
- **Funções Auxiliares**:
  - `lerDadosUsuario`: Lê os dados do usuário (título, autor, ano e editora).
  - `escreverLivroXML`: Escreve os dados do livro no formato XML no arquivo.

## Como Compilar e Executar

Para compilar e executar o código, siga os passos abaixo:

1. **Certifique-se de ter um ambiente de desenvolvimento para Assembly** (como MARS ou SPIM).
2. **Salve o código em um arquivo** chamado `cadastro_livros.asm`.
3. **Abra o MARS ou SPIM** e carregue o arquivo `cadastro_livros.asm`.
4. **Compile o código**.
5. **Execute o programa**.

## Uso

Após executar o programa, o usuário será solicitado a inserir as seguintes informações para cada livro:

1. **Título do Livro**: O título do livro a ser cadastrado.
2. **Autor do Livro**: O autor do livro.
3. **Ano do Livro**: O ano de publicação do livro.
4. **Editora do Livro**: A editora responsável pela publicação.

Após inserir os dados, o programa perguntará se o usuário deseja adicionar mais livros. O usuário pode responder com 's' (sim) ou 'n' (não). Se o usuário optar por não adicionar mais livros, o programa finalizará e o arquivo XML será salvo.

## Formato do Arquivo XML

O arquivo XML gerado terá a seguinte estrutura:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<biblioteca>
    <livro>
        <titulo>Título do Livro</titulo>
        <autor>Autor do Livro</autor>
        <ano>Ano do Livro</ano>
        <editora>Editora do Livro</editora>
    </livro>
    <!-- Outros livros podem ser adicionados aqui -->
</biblioteca>
