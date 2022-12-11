# JULIA 101 😃 

"""
Kurz: Julia = open source language, matlab on steroids with python like functions and the speed of
C/Fortran (petaflop-family 😎). 

Problem: Noch sehr junge Sprache (wenig StackOverflow Einträge, Syntax noch
dynamisch). Setzt sich jedoch allmählich durch (BigData): 
NASA, Amazon, BlackRock, Intel, IBM ... 

Am besten in: LinearAlgebra, DifferentialEquations, MachineLearning ... (state
of the art packages) aus diesen Grund werden ganze Projekte in die Sprache umgeschrieben 
z.B. Climate Modeling Alliance. Übrigens: Nativer Support für GPU-Berechnungen (CUDA)
"""

# Dies ist ein Kommentar

#= 
Dies ist ein Blockkommentar. 
=#

"""
Dies ist ein DocString.
"""

#= 
Alles klar, lasst uns mit den interessanten Dingen beginnen. 
Arrays!
=#

a = 1.                     
b = [0. , 1. , 2. , 3., 4.] 

c = a .+ b          # element wise addition (same with every other elementary operation (even self written functions))

# first value of c
c[1]
c[begin]

# last value of c
c[5]
c[end]

# pick subarrays 
c[2:end] 
c[1:2:end] #every second element 

# conclusion: Indexing works just like in matlab, but with [] brackets 

# lets create some useful arrays (just like in Matlab)
η = zeros(6) # create 6 element zeros array
# Wait! How did I write that eta? Just use common Latex : η = \eta + <tab>  --> extremely readable code


β = ones(Int64, (3, 5)) # creates ones-matrix with 3 rows and 5 columns 
# pick first row 
β[1, :]

# pick first column
β[:, 1]
# and so on and so forth 

# Remember linspace from Matlab? Julia has the same, but better/more efficent.  
u = 0.:0.1:0.4                      # the dirty way: start:step:stop
v₁ = range(30., 40., length = 9)
v₂ = range(0., 100., step = 0.1)

# Wait what is this? No Array? I want an array! --> Array wird wirklich nur dann erzeugt, wenn es auch wirklich benötigt wird: collect(collection)
# compare Bytes: 
sizeof(v₂)
sizeof(collect(v₂))

arr = collect(v₁)

# !!! BITTE KEINE ANGST VOR LOOPS HABEN !!! --> Vectorized code gleiche Performance wie elementweiser Code --> oftmals bessere Lesbarkeit 

# For loops over an array 
for elem in arr 
    println(elem)
end

# for loop over array indices
for idx in eachindex(arr)
    println(idx)
end

# for loop over array and indices at the same time 
for (idx, elem) in enumerate(arr)
    println("$idx" * ": " * "$elem") 
end

# while loop
herze = ["❤", "❤", "❤", "❤"]
while !isempty(herze)
    println(herze)
    popfirst!(herze)
end

# Funktionen in Julia

"""
Dokumentation der Funktion myadd. 
"""
function myadd(a, b)
    return a + b
end

p = myadd(2., 5.)
c = myadd("hi", " mom")

# multiple dispatch: Same function name, different methods.  

function Σ(a::Number, b::Number)
    return a + b
end

function Σ(a::String, b::String)
    return a * b
end

p = Σ(2., 5)
c = Σ("hi", " mom")

methods(Σ)

# Inplace Funktionen. Oft soll eine Funktion einen Input aktiv verändern und keine Kopie erzeugen. 
# z.B. [1., 2., 3., 4.] --> [1., 4., 9., 16.] ohne eine Kopie des Inputs (Inplace manipulation).

# Laden eines packages für einen Performance-Vergleich.
using BenchmarkTools

# out-of-place: 
x = collect(Float64, 1:10_000_000)

function quad(number_array)
    return number_array.^2
end

@benchmark z = quad(x)

# inplace (does not exist in Matlab), preallocate solution that shall be modified. 
# Convention: modify function name with "!", mutable argument comes first

sol = similar(x) # N/A in Matlab, create an empty array with the dimensions of x

function quad!(out, x)
    out .= x.^2
end

@benchmark quad!(sol, x)
sol

# Stellen wir uns vor wir möchten ein Array, das alle ungeraden Zahlen von 1 bis 8 quadriert. 
# the naive way:
x = collect(1:1:8)

function example(number_array)
    squared = Int64[]
    for number in number_array
        if isodd(number)
            push!(squared, number^2)
        end
    end
    return squared
end

y1 = example(x)

# Well, that is quite ugly. Let us use generators/list comprehension instead. (No equivalent in Matlab, but Python programmers will relate.)
y2 = [number^2 for number in 1:8 if isodd(number)]

# generell : z = [function for element in collection (optional: boolean Bedingung für Element)]


# Okay, soweit der Urschleim. 😄 

# Cheatsheet Umsteiger Matlab --> Julia: https://cheatsheets.quantecon.org