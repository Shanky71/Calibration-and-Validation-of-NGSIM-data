 function [Smooth_Para] = Smoothening(Parameter)

N=521;
T = 1.0;                                   % Smoothing width
dt = 0.1;                                    % Time interval
de = T/dt;                                % Smoothing width measured in data points
d = 3*de;                        

for n=1:N
 D= min([d n-1 N-n]);
 k = (n-D);
 l= (n+D);
 z = 0.00000000001;
 a = 0.00000000001,
 for j=k:l+1
     Z = 2.718*(-(abs(n-j))/de);
     if j<=520
         at = Parameter(j);
     else
         at= Parameter(j-1);
     end

     A = at.*2.718*((-1*abs(n-j))/de);
     z = z +Z;
     a = a + A;
 end
Smooth_Para(n,1) = a/z;
end

end
