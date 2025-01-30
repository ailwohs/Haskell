nome=(input("Digite seu nome \n"))
idade=int(input("Digite sua idade \n"))
peso=float(input("Digite seu peso \n"))
print("Seu nome é:", nome, "sua idade é:", idade, "seu peso é:", peso)

meses=idade*12
print("Você já viveu", meses, "meses")

ano=idade*365
print("E", ano, "tudo isso de anos")

'''#Programa que pede dois numeros ao usuario e apresenta o contexto todo em print, adição, 
multiplicação etc...'''


n1=float(input("Digite o primeiro número \n"))
n2=float(input("Digite o segundo número \n"))

soma = n1+n2
mut = n1**n2
divi= n1/n2
print("A soma dos números é:", soma, "E a multiplicação é:", mut , "a divisão é:", divi)                 