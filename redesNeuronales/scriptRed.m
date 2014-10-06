clear all;

1;

function y = signo(x)
 x(x>0) = 1; 
 x(x<=0) = -1; 
 y = x;
endfunction

# Preparo las cosas (solo tamaños)
imWidth  = size(imread('./torero.bmp'))(1);
imHeigth  = size(imread('./torero.bmp'))(2);
# Cantidad de vectores de prueba que voy a incluir
M = 3;
# Meto en matriz, serializo y convierto ceros en -1
p1 = signo(imread('./torero.bmp')(:)); 
p2 = signo(imread('./paloma.bmp')(:)); 
p3 = signo(imread('./quijote.bmp')(:)); 
N = size(p1(:))(1); # Los vectores son columna => el tamaño es la cantidad de filas

# Creo la matriz de la red
# puedo hacer una matriz 3D de Imagenes serializadas en un vector que despues es combinatoriado(entonces vuelve a ser una matrix)  
PallImages = p1'*p1;
PallImages(:,:,2) = p2'*p2;
PallImages(:,:,3) = p3'*p3;
Psum = cumsum(PallImages,3)(3);
# crear la red de la matriz.
W = Psum - M*eye(N); 

# Probar que es estable para las matrices que metiste. (Los vectores p con una iteracion dan ellos mismos)
## Que hay que hacer??? signo(W*pi) y a el vector que te da verificar que sea pi.
pm = [p1  p2  p3 ]; 
sm = signo(W*pm);
# comparar pm con sm
cumsum(pm - sm,2)(size(pm)(1),:)

### Ahora verificar con esta red y con imagenes cambiadas.

i1 = signo(imread('./torero.cambiada.bmp')(:)); 
i2 = signo(imread('./paloma.cambiada.bmp')(:)); 
i3 = signo(imread('./quijote.cambiada.bmp')(:)); 
im = [i1 i2 i3];



sm = im;
while( cumsum(pm -sm,2)(size(pm)(1,2))!=0 ) 
  sm = signo(W*sm);
endwhile  

## reconstruyo los vectores 

Images = reshape(sm,imWidth,imHeigth,M)

imshow(Images(:,:,1));
imshow(Images(:,:,2));
imshow(Images(:,:,3));







