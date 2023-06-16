using Statistics
using CSV
using DataFrames
using FreqTables
using Pipe

df = CSV.read("../data/credit_card_default.csv",DataFrame)

description = describe(df)

println(names(df))

#### Indexing && Subsetting ###############

subset_df = df[1:5,1:5]

subset_df_2 = df[1:2:10,1:5] ### Stepsize does apply

subsetdf_3 = df[[1,2,3],2] ### Single Indexing Column

subsetdf_4 = df[:,["LIMIT_BAL","SEX"]] ### Name indexing is supported


df[!,["LIMIT_BAL"]] ### This Returns an object whil
df[!,"LIMIT_BAL"] ### This Return a vector

df[!, ["LIMIT_BAL"]] == df[:, ["LIMIT_BAL"]] ### Both Expressions result in the same

### Using Regex to select Columns

### Using the Not operator to subset data
df[!,Not("LIMIT_BAL")]

### Using the Between operator to select dataframes
df[:,Between("LIMIT_BAL","AGE")]


### Using anyoniomus function
df[:,Cols(x->startswith(x,"P"))]

df[:,Cols(r"P",:)]

df[df.LIMIT_BAL .> 500000,"EDUCATION"] ### Return Vector

### Select & transform ##################

select(df[df.LIMIT_BAL .> 500000,:],"EDUCATION") ### Return Dataframe Obj

df[(df.LIMIT_BAL .> 50000) .& (df.LIMIT_BAL .< 500000),:]

df = select(df, "LIMIT_BAL" => :LB,:) # rename one column columns
names(df)

select(df,:LB => (x -> x .* minimum(x))=>"LB-Adjusted",:) ###Creates a new dataframe with given operation and only select cols

transform(df,:LB => (x -> x .* minimum(x))=>"LB-Adjusted") ### Creates a new dataframe with given operation and returns all cols

transform!(df,:LB => (x -> x .* minimum(x))=>"LB-Adjusted") ### Creates a new dataframe with given operation and returns all cols & performs the operation inplace


var1 = :Daffy
typeof(var1)


### Joins


people = DataFrame(ID=[20, 40], Name=["John Doe", "Jane Doe"])

jobs = DataFrame(ID=[20, 60], Job=["Lawyer", "Astronaut"])

innerjoin(people, jobs, on = :ID)

leftjoin(people,jobs,on= :ID)

rightjoin(people,jobs,on = :ID)

outerjoin(people,jobs,on= :ID)

semijoin(people, jobs, on = :ID)

antijoin(people, jobs, on = :ID)

job = DataFrame(IDNew=[20, 40], Job=["Lawyer", "Doctor"])

innerjoin(people, job, on = :ID => :IDNew)

auto = CSV.read("../data/auto-mpg.csv",DataFrame,header=["mpg","cylinders","displacement","horsepower","weight","acceleration","model_year","origin","name"])

println(names(auto))


rename!(auto, Symbol.(names(auto)))

auto = auto[2:end, :]



transform!(auto,:name => ByRow(x -> split.(x)[1]) => :brand)

sum(ismissing.(auto[!,:mpg]))


typeof(auto[!,:mpg])




auto .= ifelse.(auto .== "nothing",missing,auto)

auto.mpg = parse.(Float64, auto.mpg)
auto.cylinders = parse.(Int64, auto.cylinders)
auto.displacement = parse.(Float64, auto.displacement)

auto.weight = parse.(Float64, auto.weight)
auto.acceleration = parse.(Float64, auto.acceleration)
auto.model_year = parse.(Int64, auto.model_year)
# auto.displacement = parse.(Float64, auto.origin)

default_value = 0
auto.horsepower = coalesce.(auto.horsepower, default_value)
auto[!, :horsepower] = replace.(auto[!, :horsepower], "?" => 0)
auto.horsepower = parse.(Float64, auto.horsepower)
auto_desc = describe(auto)

gdf = groupby(auto,:brand)

freq_count = freqtable(auto[!,:brand])


gdf[("ford",)]



brand_mpg = combine(gdf, :mpg => mean => :mean_mpg)

sort!(brand_mpg,:mean_mpg,rev=true)

freqtable(auto, :brand, :origin)


value_count_brand = @pipe auto |> 
                     groupby(_, :brand) |> 
                     combine(_, nrow  => :brand_counts) |>
                     sort(_,:brand_counts,rev=true)



origins = @pipe auto |>
            groupby(_,:origin) |>
            combine(_,:brand => x-> Ref(unique(x)) )
