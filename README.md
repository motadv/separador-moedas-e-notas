# Implementação organizador de Notas e Moedas MIPS
## Separador de Moedas e Notas feito em Assembly (MIPS) no simulador MARS
O input do codigo é feito na label valor na area .data
Isso foi decidido por uma questão de simplicidade

Temos 2 vetores com o valor em centavos de cada uma das notas e moedas
Ou seja, para dividir em notas de 100 reais, na verdade estamos dividindo
em uma "nota" equivalente a 10.000 centavos. Todos os valores de cédulas
e centavos foram multiplicados por um escalar de 100 para evitar trabalhar com
valores double ou float por serem mais intensivos e mais complexos de programar

Alocamos também os textos que serão printados

Funcionamento:

Carrego o valor como float e multiplico pelo escalar, converto para um inteiro e
movo do Coproc 1 para o banco de registradores principal.
Salvo também nos registradores o escalar como um inteiro de valor 100

A lógica do código em si é relativamente simples, loopo pelo vetor de notas,
chamando a função calcular_nota, que printa através da printar_nota o quociente da
divisão entre o valor atual e a nota atual, e o restante vira meu novo valor atual
Esse processo se repete até que todo o vetor de notas tenha sido calculado em cima do valor
O que significa que, o restante do valor só pode ser divisível pelas moedas.

Nas moedas a mesma coisa acontece.

Importante ressaltar que, como nosso vetor é composto pelos valores das notas e moedas
multiplicados por 100, temos que dividir na hora de printar qual é aquele valor da nota/moeda.
Na parte das notas isso não gera problema pois a divisão é inteira, mas nas moedas, temos
que converter o valor para float para não perder informação da divisão.
Para isso movemos o valor para a Coproc 1 e convertemos para float.
