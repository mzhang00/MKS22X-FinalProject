PVector v1 = new PVector(10, 20);
PVector v2 = new PVector(60, 80); 
float a = PVector.angleBetween(v2, v1);
println(degrees(a));  // Prints "10.304827"
