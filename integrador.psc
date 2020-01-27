Algoritmo Integrador
	// Te han contratado desde el planeta Mortyano para automatizar el procesamiento de squanchys.
	//Los squanchys se colectan y empacan en cajas. El proceso industrial arranca con el desempaquetado y selección.
	//Se reciben palletisadas 16 cajas, distribuidas 4 por lado (4x4). Se acompaña el pallet con un informe del peso de
	//cada caja (mínimo 5kg, máximo 50kg).
	//Luego un brazo mecánico selecciona 4 cajas en línea y las coloca en una cinta transportadora. Pero ¿cómo decidir si
	//hacerlo por filas o por columnas? Simple: se busca maximizar los Kg de squanchys destinados a consumo. Para esto
	//se siguen las siguientesreglas:
	//1. Las cajas que pesan más de 40kg se consideran óptimas para consumo.
	//2. Las cajas que pesan menos de 10kg se separarán en un futuro exclusivamente para semillas y se descarta su consumo.
	//3. Las restantes sólo se aprovechan para consumo si en la misma fila (o columna) hay dos cajas que si suman
	//su peso superan los 40kg. De lo contrario se separarán también para semillas. Es importante saber que solo
	//es posible sumar 2 cajas por fila/columna; esto significa que, por ej., si las 4 cajas de una fila/columa están
	//entre los 10kg y los 40kg, habría que seleccionar el par de cajas que sumadas pese más.
	//Tu misión es construir un programa que dado la información recibida de un pallet decida si el brazo mecánico debe
	//procesarlo por filas o por columnas. Además, debes entregar un resumen por pantalla de cuantos Kg de squanchys
	//quedarán destinados a consumo y cuántos destinados a semillas.
	
	Definir A,n,i,j,kilosS,kilosC,totalFilaS,totalFilaC,totalColumnaS,totalColumnaC,semilla,consumo como entero
	Dimension A(4,4)

	i<-0 
	j<-0
	Para i<-0 hasta 3
		Para j<-0 hasta 3
			A(i,j)<-aleatorio(5,50)
		FinPara
	FinPara
	mostrarMatriz(A)
	
	// Recorrer filas. Valor de consumo de semillas y consumo
	//	totalSumaFilaRES(A,x,semilla,consumo)
	// (**)Mostrar cuantos kilos hay para consumo y cuantos para semillas. Sumatoria de consumo y semilla total (comparar con sumatorias totales de Columnas)
	totalFilaS<-0
	totalFilaC<-0
	semilla<-0
	consumo<-0
	i<-0
	Para i<-0 hasta 3 hacer
		totalSumaFilaRES(A,i,semilla,consumo)
		kilosS <- semilla
		kilosC <- consumo
		totalFilaS<-totalFilaS + kilosS
		totalFilaC<-totalFilaC + kilosC
	FinPara
	
	// Recorrer columnas. Valor de consumo de semillas y consumo
	//	totalSumaColumnasRES(A,x,semilla,consumo)
	totalColumnaS<-0
	totalColumnaC<-0
	semilla<-0
	consumo<-0
	kilosS<-0
	kilosC<-0
	i<-0
	Para i<-0 hasta 3 hacer
		totalSumaColumnasRES(A,i,semilla,consumo)
		kilosS <- semilla
		kilosC <- consumo
		totalColumnaS<- totalColumnaS + kilosS
		totalColumnaC<- totalColumnaC + kilosC
	FinPara
	
	// Decidir si es mejor por fila o columna (*) 
	// Mostrar cuantos kilos hay para consumo y cuantos para semillas
	Si totalColumnaC > totalFilaC entonces
		Escribir "El brazo recorrerá las cajas en línea por FILA"
		Escribir "Total de kg para consumo: " totalColumnaC // Resultado de suma de columnas por fila
		Escribir "Total de kg para semilla: " totalColumnaS
	SiNo
		Escribir "El brazo recorrerá las cajas en línea por COLUMNA"
		Escribir "Total de kg para consumo: " totalFilaC    // Resultado de suma de columnas por columna
		Escribir "Total de kg para semilla: " totalFilaS
	FinSi
	
	
	
FinAlgoritmo

//Subproceso para mostrar matriz
Subproceso mostrarMatriz(M)
	Definir i,j como entero
	i<-0
	j<-0
	Para i<-0 hasta 3 hacer
		para j<-0 hasta 3 hacer
			Escribir sin saltar " " M(i,j)    
		FinPara
		Escribir ""
	FinPara
	Escribir ""
FinSubProceso

//Subproceso para recorrer filas (RESULTADO POR COLUMNA)
Subproceso totalSumaFilaRES(A,x,semilla por referencia,consumo por referencia)
	Definir i,may,may1 como entero
	i<-0
	may<-0
	may1<-0
	Para i<-0 hasta 3 
		si A(i,x)<=10 entonces
			semilla <- semilla + A(i,x)
		SiNo
			Si A(i,x)>=40 entonces
				consumo <- consumo + A(i,x)
			SiNo
				// almacenar valores mayores
				// si mayor + mayor1 >= 40 entonces -> consumo = mayor + mayor1
				may <- A(i,x)
				Si A(i,x) > may entonces
					may <- A(i,x)
				SiNo
					may1 <- A(i,x)
				FinSi	
				
				Si may + may1 >=40 Entonces
					consumo <- may + may1
				SiNo
					semilla <- may + may1
				FinSi
			FinSi
		FinSi
	FinPara

FinSubProceso

//Subproceso para recorrer columnas (RESULTADO POR FILA)
Subproceso totalSumaColumnasRES(A,x,semilla por referencia,consumo por referencia)
	Definir i,may,may1 como entero
	i<-0
	may<-0
	may1<-0
	Para i<-0 hasta 3 
		si A(x,i)<=10 entonces
			semilla <- semilla + A(x,i)
		SiNo
			Si A(x,i)>=40 entonces
				consumo <- consumo + A(x,i)
			SiNo
				// almacenar valores mayores
				// si mayor + mayor1 >= 40 entonces -> consumo = mayor + mayor1
				may <- A(x,i)
				Si A(x,i) > may entonces
					may <- A(x,i)
				SiNo
					may1 <- A(x,i)
				FinSi	
				
				Si may + may1 >=40 Entonces
					consumo <- may + may1
				SiNo
					semilla <- may + may1
				FinSi
			FinSi
		FinSi
	FinPara

FinSubProceso

// Segun que subproceso de mas kg de consumo es cual es mas óptimo (*)
