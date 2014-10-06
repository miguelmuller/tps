clear all;
page_output_immediately(1);
source ./redesNeuronalesLib.m;

# Parameters
N = 100; # amount of neurons
I = 5# amount of instances 
steps = 10*N*N;  # planteo pasar 100 veces por todos los elementos (esto es 25000 = 50*50*10) . Paso una vez por cada elemento con cada decimo de temperatura.
time = [0 : steps-1]; # podrias pensarlo en segundos (o milisegundos)

# Temperature vector function
T0 = 3; # temperatura inicial, podrias pensarlo en Celsius
k = T0 / (steps-1); # Lo llevas a cero en el valor maximo de time. O sea el ultimo valor de temperatura es 0. 
temp = T0 - k * time ;
Magnet = zeros(I,steps);
# The larger the steps parameter, the lower the slope (the slower the temp change). 
# The initial temperature is another parameter that can be modifies to lower the speed of the temperature change

# Create matrices for the different relizations
for i = [1:I];
  S(:,:,i) = createStateMatrix(N);
endfor

# plot network state as pixels
im = imshow(S(:,:,1));

status = 0;
for t = time
  S = changeRandomState(S, temp(1,t+1));
  Magnet(:,t+1) = calculateNetMagnetization3D(S);
  # Show progress
  if( t > steps*status/100 )
    set(im,'cdata',S(:,:,1));
    drawnow();
    status++;
    Magnet(:,t+1)
    printf("%s%i%s%f%s%f%s\n","progress = ",status," \%. Temperature = ", temp(1,t+1) , ". Magnetization = " , Magnet(1,t+1) , " %." );
  endif
endfor


#plot(temp,Magnet(1,:),temp)
#keyboard("press the any key to continue")

