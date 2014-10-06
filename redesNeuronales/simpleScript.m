page_output_immediately(1);
N = 1000000;

for t = [ 1: N]
  1;
  progress = t/10000;
  if( progress - fix(progress) == 0 )	
    printf( "%s%i%s\n","progress:", progress , "\%");
  end
end
