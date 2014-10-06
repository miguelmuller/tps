#Segunda clase

# El grupo de patrones es aprendido si poniendo los patrones a la entrada a la salida tengo menos de cierto error.

# Establecemos un error permitido
#=> agarra redes grandes (100 para arriba (lo que se pueda con la maquina que se este usando) ej: 100 a 500 con step de 50))

#Para cada tamaño tengo que ver cuantos patrones aprende con menos error del que considero minimo. 

#No arranco con patrones en 1 por que en general van a tener  mucho error
#Lo que decian en la teorica, la cantidad de patrones maxima me da 

#uso un 5% para de donde agarras

#va agregando hasta que no haya mas => vas a tener el minimo promedio si promedias varias curvas

# Queremos llegar a 1.05
#Hay una funcion para graficar el devio estandar

# Probabilidad de error para considerar que la red se equivoca (o sea siempre se equivoca, para mi es inaceptable con esta cantidad de error promedio)
Nmin = 100;
Nmax = 500;
p_err = 0.001;

Neurons = Nmin : 50 : Nmax;
results = ones(size(Neurons)(2),1);

i = 1;
for N = Neurons 
  i = i+1;
  for M =  0.05*N : N  
    
    P = signo(stdnormal_rnd(N,M));
    # genero una matriz de M*M
    W = P*P' - M*eye(N);
    Sestimado = signo( W*P );
    if( (sum(abs(Sestimado - P)(:))/2) /(M*N) > p_err )
         results(i) = M/N;
         continue
    endif
  endfor
endfor

# Esto deberia ser la recta
curve = results(i).*Neurons
plot(curve);
