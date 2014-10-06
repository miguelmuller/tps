# Redes Neuronales lib

function y = signo(x)
 x(x>0) = 1; 
 x(x<=0) = -1; 
 y = x;
endfunction

function S = createStateMatrix(N)
  S = zeros(N);
  S = signo(stdnormal_rnd(N));
endfunction

# circular increment and decrement
function n = next(curr, N)
  if(curr == N)
   n = 1;
  else
   n=curr+1;	
  endif
endfunction

function p = prev(curr, N)
  if(curr == 1)
   p = N;
  else
   p=curr-1;	
  endif
endfunction


function deltaE =  obtenerDeltaEnergia( S , posx , posy )
  N = size(S)(1);

  x  = S( posx , posy);
  x1 = S( next(posx,N) , posy);
  x2 = S( posx , next(posy,N) ); 
  x3 = S( prev(posx,N) , posy);
  x4 = S( posx , prev(posy,N)) ; 
	
  Ei = -1*( x1 + x2 + x3 + x4 )* x;  # ojo, creo que esto lo tengo que multiplicar por 2 (done originalmente el -1 era ujn 0.5)
  Ef = Ei*(-1); 
  deltaE = Ef - Ei ;
endfunction

function Sout = changeState(Sin, posx , posy , T)
  Sout = Sin;
  deltaE = obtenerDeltaEnergia(Sin,posx,posy);	
  P = exp(-deltaE / T);
  if( deltaE > 0 && rand > P)
   # If energy change is positive , reject the change with probability P = exp(-deltaE/T)
  else
    Sout(posx,posy) =  (-1)* Sin(posx,posy);
  endif
endfunction

# changeState wrapper for 3D Matrices (call changeState for all the paralell matrices)
# I wanted the funtion to modify S itself, but apparently in octave passes by reference are not permitted (o pointers in order to alter the arguments passed to the function)
# Returning the refreshed S matrix instead
function  Sout = changeState3D(Sin , posx, posy, T)
    # Code to make this function 3d matrices friendly. 
    if( size( size(Sin) ) == 3 )
      instances = size(Sin)(3);
    else
      instances = 1;
    endif
    for i = [ 1 : instances ]
      Sout(:,:,i) = changeState(Sin(:,:,i) , posx, posy, T);
    endfor
endfunction

function  Sout = changeRandomState(Sin, T)
  posx = ceil(rand*size(Sin)(1));
  posy = ceil(rand*size(Sin)(1));
  Sout = changeState3D(Sin,posx, posy, T);
endfunction

function M = calculateNetMagnetization(S)
  M = sum(S(:))/(size(S(:))(1));  #funciona para matrices de 3 dimensiones
endfunction

function M = calculateNetMagnetization3D(S)
    # Code to make this function 3d matrices friendly. 
    if( size(size(S))(2) == 3 )
      instances = size(S)(3);
      M = zeros(instances,1);
    else
      instances = 1;
      M = 0;
    endif
    for i = [ 1 : instances ]
      M(i,1) = calculateNetMagnetization(S(:,:,i));
    endfor
endfunction	
