.data
# Arquivo e caminhos
localArq: .asciiz "C:/Users/lsilv/Desktop/facu/plmds/teste.xml"

# Prompts
promptTitulo: .asciiz "Digite o título do livro: "
promptAutor: .asciiz "Digite o autor do livro: "
promptAno: .asciiz "Digite o ano do livro: "
promptEditora: .asciiz "Digite a editora do livro: "
promptAdicionar: .asciiz "Deseja adicionar mais livros? (s/n): "

# Buffers para entrada
tituloBuffer: .space 100
autorBuffer: .space 100
anoBuffer: .space 10
editoraBuffer: .space 100
respostaBuffer: .space 3

# Tags XML com formatação correta
xmlHeader: .asciiz "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<biblioteca>\n"
tagLivroOpen: .asciiz "    <livro>\n"
tagTituloOpen: .asciiz "       <titulo>"
tagTituloClose: .asciiz "</titulo>\n"
tagAutorOpen: .asciiz "       <autor>"
tagAutorClose: .asciiz "</autor>\n"
tagAnoOpen: .asciiz "       <ano>"
tagAnoClose: .asciiz "</ano>\n"
tagEditoraOpen: .asciiz "       <editora>"
tagEditoraClose: .asciiz "</editora>\n"
tagLivroClose: .asciiz "    </livro>\n"
xmlFooter: .asciiz "</biblioteca>\n"

.text
.globl main

main:
    # Verificar se arquivo existe
    li $v0, 13
    la $a0, localArq
    li $a1, 0        # modo leitura
    syscall
    
    bltz $v0, criarArquivoNovo  # Se arquivo não existe, criar novo
    
    # Fechar arquivo existente
    move $s0, $v0
    li $v0, 16
    move $a0, $s0
    syscall
    
    # Reabrir em modo append
    j abrirAppend

criarArquivoNovo:
    # Criar novo arquivo
    li $v0, 13
    la $a0, localArq
    li $a1, 1        # modo escrita
    syscall
    move $s0, $v0
    
    # Escrever cabeçalho XML
    li $v0, 15
    move $a0, $s0
    la $a1, xmlHeader
    li $a2, 44
    syscall
    
    # Fechar arquivo
    li $v0, 16
    move $a0, $s0
    syscall

abrirAppend:
    # Abrir arquivo em modo append
    li $v0, 13
    la $a0, localArq
    li $a1, 9        # modo append
    syscall
    move $s0, $v0
    
    # Loop para ler e escrever múltiplos livros
    loop:
        jal lerDadosUsuario

        jal escreverLivroXML
        
        # Perguntar se deseja adicionar mais livros
        li $v0, 4
        la $a0, promptAdicionar
        syscall
        
        li $v0, 8
        la $a0, respostaBuffer
        li $a1,  3
        syscall
        
        # Checar se o usuário deseja continuar
        li $t0, 'n'
        lb $t1, respostaBuffer
        beq $t0, $t1, sairLoop
        
        j loop

    sairLoop:
        # Escrever rodapé XML
        li $v0, 15
        move $a0, $s0
        la $a1, xmlFooter
        li $a2, 14
        syscall
        
        # Fechar arquivo
        li $v0, 16
        move $a0, $s0
        syscall
    
    # Encerrar programa
    li $v0, 10
    syscall

lerDadosUsuario:
    # Função para ler os dados do usuário
    
    # Ler o título
    li $v0, 4
    la $a0, promptTitulo
    syscall
    li $v0, 8
    la $a0, tituloBuffer   # A partir da posição do buffer
    li $a1, 99        # Máximo de 99 caracteres
    syscall
    
    # Ler o autor
    li $v0, 4
    la $a0, promptAutor
    syscall
    li $v0, 8
    la $a0, autorBuffer    # A partir da posição do buffer
    li $a1, 99        # Máximo de 99 caracteres
    syscall
    
    # Ler o ano
    li $v0, 4
    la $a0, promptAno
    syscall
    li $v0, 8
    la $a0, anoBuffer      # A partir da posição do buffer
    li $a1, 9         # Máximo de 9 caracteres
    syscall
    
    # Ler a editora
    li $v0, 4
    la $a0, promptEditora
    syscall
    li $v0, 8
    la $a0, editoraBuffer  # A partir da posição do buffer
    li $a1, 99        # Máximo de 99 caracteres
    syscall
    
    jr $ra


# Função para escrever as tags no arquivo
escreverLivroXML:
    # Escrever a tag <livro> 
    li $v0, 15
    move $a0, $s0
    la $a1, tagLivroOpen
    li $a2, 11
    syscall

    # Escrever a tag <titulo> com o título do livro
    li $v0, 15
    move $a0, $s0
    la $a1, tagTituloOpen
    li $a2, 15
    syscall
    
    li $v0, 15
    move $a0, $s0
    la $a1, tituloBuffer  # Buffer com o título
    li $a2, 100
    syscall

    li $v0, 15
    move $a0, $s0
    la $a1, tagTituloClose
    li $a2, 10
    syscall

    # Escrever a tag <autor> com o autor do livro
    li $v0, 15
    move $a0, $s0
    la $a1, tagAutorOpen
    li $a2, 14
    syscall

    li $v0, 15
    move $a0, $s0
    la $a1, autorBuffer  # Buffer com o autor
    li $a2, 100
    syscall

    li $v0, 15
    move $a0, $s0
    la $a1, tagAutorClose
    li $a2, 9
    syscall

    # Escrever a tag <ano> com o ano do livro
    li $v0, 15
    move $a0, $s0
    la $a1, tagAnoOpen
    li $a2, 12
    syscall
    

    li $v0, 15
    move $a0, $s0
    la $a1, anoBuffer  # Buffer com o ano
    li $a2, 10
    syscall

    li $v0, 15
    move $a0, $s0
    la $a1, tagAnoClose
    li $a2, 7
    syscall

    # Escrever a tag <editora> com o nome da editora
    li $v0, 15
    move $a0, $s0
    la $a1, tagEditoraOpen
    li $a2, 16
    syscall

    li $v0, 15
    move $a0, $s0
    la $a1, editoraBuffer  # Buffer com a editora
    li $a2, 100
    syscall

    li $v0, 15
    move $a0, $s0
    la $a1, tagEditoraClose
    li $a2, 11
    syscall

    # Fechar a tag <livro>
    li $v0, 15
    move $a0, $s0
    la $a1, tagLivroClose
    li $a2, 13
    syscall

    jr $ra

