
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
    # genero una matriz de N*N (N suele ser mayor que M por que N es la cantidad de neuronas y M la cantidad de patrones)
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



#Tercera clase

# Hay que graficar Error promedio cuando se meten neuronas rotas (0 en la matriz (o sea deja de ser binario?))
# El error se mide como la cantidad de confusiones con respecto al patron que hay en los patrones de salida al ser ingresados en un paso en la red. (multiplico una vez W * p con p = [p1, p2, p3, p4, p5, ...pN]t) y obtengo los valores a los cuales convierte al patron 


#Tamanio de red y cantidad de patrones (ponele que 20 hubieran andado para tener menos de una milesima de probabilidad de error )
N= 200;
M= 11;

# Patrones aleatorios cuasiortogonales
P = signo(stdnormal_rnd(N,M));
# Matriz de la Red
W = P*P' - M*eye(N);
Waux = zeros(N*N);
randPos = randperm(N*N);

# Porcentaje de interconexiones (unidireccioneales) rotas
I = [ 10 : 10 : 80 ];
errors = zeros(sizeof(I)(2));
i = 0;
for i = I
  # aca tengo los indices que voy a hacer cero en la matriz 
  ceroPos = randPos(1:floor((I/100)*N*N));
  W(ceroPos) = 0;
  errors(i++) = getTaughtPatternError(W,P); # ya lo hiciste en el 2 (multiplicads por W por P y te fijas la diferencia porcentual en bits)
endfor
  
# Esto puede ser una funcion que itere varias veces hasta que quede estable la cosa. esto seria lo ideal aunque al cabo de una iteracion tendria yo ya una buena idea de el error que va a haber. Si queres iterar hasta que este estable (la diferencia menor que cierto error) o hasta cuando iteraste 100 veces.
getTaughtPatternError(W,P)
{

}


###
#Mira esto, Uso...

#A = reshape([10:10:100],N,M);
#queda 
#10 60
#20 70
#30 80
#40 90
#50 100

# randPos = randperm(N*N);
# ceroPos = randPos(1:(I/100)*N*N) 
# 








