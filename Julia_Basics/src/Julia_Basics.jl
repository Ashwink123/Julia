using LinearAlgebra
using DataFrames, CSV
using Printf


A = [
	[1 2 3]
	[4 5 6]
	[7 8 9]
]
println("Determinant: ",det(A))


println(A)

df = DataFrame(name=["Julia","Robert","Bob","Mary"],age=[12,15,45,32])


df[1:3,"age"]

older = df[df.age .>15,:]

println(older)

new_df = sort(df,"age")

println(new_df)

decending_df = sort(df,"age",rev=true)

println(decending_df)

df.sex = ["female","male","male","female"]

println(df)

using Plots


plot([1,2,3,4,5],[3,6,9,15,16],title="Basic line chart",label="Line")

plot(df.name,df.age,title="Ages",label=nothing,seriestype="bar")


age =12
if age > 12 && age <=6
	println("You are in kindergarten")
elseif age >= 7 && age<=13
	println("You are in Middle School")
elseif age >=14 && age <=18
	println("You are in middle School")
else 
	println("Stay Home")
end	

i= 1
while i < 20
	if(i%2)==0
		println(i)
		global i +=1
		continue
	end
	global i+=1
	if i >=10
		break
	end		
end	


i = 0
while i <= 10
	i += 1
	if i %2 ==0
		println("Even Numbers",i)
		continue
	else
		println("Odd Numbers",i)	
	end
end		

for i = 1:5
	print(i,"\n")
end	

for i in [1,2,3,4,5]
	print(i,"\n")
end	


for i = 1:5, j=2:2:5
	println(i," ",j,"\n")
end	

## Arrays
a1 = zeros(Int64,2,2)

a2 = Array{Int64}(undef,5)

a3 = Float64[]

a7::Matrix{Int64} = [4 5 6 ; 3 5 3]


println(a7[1,end])

println(5 in a7)

println(findfirst(isequal(5),a7))

f(a) = (a == 5 ) ? true : false

println(findall(f,a7))

println(size(a7))
println(length(a7))
println(sum(a7))

println(maximum(a7))
println(minimum(a7))

a4 = [1,2,3,3.14,"Heloo!"]

a6 = [sin,cos,tan]
for n in a6
	println(n(0))
end	


println(a7[1,3])

a8 = collect(1:5)

a9 = collect(2:2:10)

a10 = collect(10:-2:0)

### Array Comprehension
a11 = [n^2 for n in 0:2:10]

### Multidimensional Array
a11 = [n * m for n in 1:5, m in 1:5]

a12 = rand(0:100,5,5)

tup1 = (1,2,3,4)
print(tup1[1])

 ### Named Tuples
 tp2 = (ashwin=("Ashwin",100),paule=("Paule",23))

 tp2.ashwin

 ### Dictionaries

 d1 = Dict("pi"=>3.14,"e"=>2.718)
 println(d1["pi"])

 delete!(d1,"pi")

 println(haskey(d1,"e"))

 println(("pi"=>3.14))

println(keys(d1))
println(values(d1))

for(k,v) in d1
	println(k ,"\n",v)
end	


### Functions

getSum(x::Int64,y::Int64)::Int64 = x + y 

x::Int64 , y::Int64 = 5,4

@printf("%d + %d = %d\n",x,y,getSum(x,y))


function canIvote(age)
	if age >18
		println("Can Vote")
	else
		println("Cant Vote")
	end
end		


canIvote(13)


function getSum2(args...)
	sum(args)
end

getSum2(1,2,3,4,5,6)


function next2(val)
	return val + 1
end	

next2(5)


### Anonymous Functions

v1 = map(x -> x * x,[1,2,3])

println(v1)

v2 = map((x,y) -> x+y,[1,2],[3,4])
println(v2)

v3 = reduce(+,1:1000)

sentence = "This is a string"
s = split(sentence)

### Math

x = 5
println(2x)

arr_new = [1,2,3,4,5]
println(arr_new .*3)


### Enums

@enum Color begin
	red =1
	blue =2
	green = 3
end

favColor = green::Color
println(favColor)

### Symbols

d2 = Dict(:pi=>3.14)

println(d2[:pi])


### Stucts

mutable struct Customer
	name::String
	balance::Float32
	id::Int
end
bob = Customer("Bob Smith",10.50,123)	

bob.name

### Exception Handeling and user input
print("Enter a number")
num1 = chomp(readline())
print("Enter a number")
num2 = chomp(readline())

try
	val = (parse(Int64,num1) / parse(Int32,num2))
	if (val == Inf)
		error("Cannot divide by zero")
	else
		println(val)
	end		
catch e
	println(e)
end





