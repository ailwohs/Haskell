'''#Programa que pede dois numeros ao usuario e apresenta o contexto todo em print, adição, 
multiplicação etc...'''
num1=input("Digite o primeiro número \n>")
num2=input("Digite o segundo número \n>")
num1_c = int (num1)
res=num1_c*num1_c
#print(res)
num2_c = int (num2)
res=num2_c*num2_c
#print(res)
num1_f=float(num1)
num2_f=float(num2)


print("a adição dos dois números é:", num1_c + num2_c)
print("a subtração dos dois números é:", num1_c - num2_c)
print("a multiplicação dos dois números é:", num1_c * num2_c)
print("a potencia inteira dos dois números é:", num1_c **num2_c)
print("a potencia em decimal dos dois números é:", num1_f ** num2_f)
print("o valor de divisão inteira dos dois números é:", num1_c // num2_c)
print("o resto da divisão inteira dos dois números é:", num1_c % num2_c)



print("Fale sua idade")
idd=input("sua idade:")
idade=int(idd)
meses=idade*12
print("voce ja viveu" , idade*12, 'meses')
dias=idade*365
print("E dias:", meses*365)