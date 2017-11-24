function vehicles = InitializeVehicles(numCars,names)
%Code for initializing vechicle structure
%Number cars in simulation should be given as 1st input

%List with names of suitable hubs to use as possible 
%start locations as 2nd input

%Vehicles are identified by their index
%1st field represents current node
%2nd field represents current destination
%3rd field represents final destination
%4th field represents if vehicle is busy

%Initializing random starting nodes of type 1
X = randi(length(names),1,numCars);

%Initializing fields of vehicle structure
field1 = 'CurrentNode';  value1 = names(X);
%field2 = 'CurrentDest';  value2 = names(X);
field2 = 'Path';  value2 = {{}};
field3 = 'FinalDest';  value3 = names(X);
field4 = 'Busy';  value4 = false;

vehicles = struct(field1,value1,field2,value2,field3,value3,field4,value4)

end
