const ausgrid_train_dir = Pkg.dir("EnergyDataset")*"data/Ausgrid/train_data"
const ausgrid_test_dir = Pkg.dir("EnergyDataset")*"data/Ausgrid/test_data"


function load_ausgrid_train_data()
	CSV.read(ausgrid_train_dir*"/2011-2012 Solar home electricity data v2.csv", 
			datarow=3, header=2, dateformat="dd/mm/yyyy", normalizenames=true, 
			missingstring="-999")
end

function load_ausgrid_test_data()
	CSV.read(ausgrid_train_dir*"/2012-2013 Solar home electricity data v2.csv", 
			datarow=3, header=2, dateformat="dd/mm/yyyy", normalizenames=true, 
			missingstring="-999")
end

function load_customer_data(df, customer::Int)
	
	dfc = df[(df.Customer .== customer),:]

	consumption = convert(Matrix, dfc[(dfc.Consumption_Category .== "GC"), 6:end-1])'
	production = convert(Matrix, dfc[(dfc.Consumption_Category .== "GG"), 6:end-1])'

	M, D = size(consumption)

	scenarios = zeros(Float64, M, D, 2)
	for m in 1:M
		for d in 1:D
			scenarios[m,d,1] = consumption[m,d]
			scenarios[m,d,2] = production[m,d]
		end
	end

	scenarios

end

function load_customer_train_data(customer::Int)
	df = load_ausgrid_train_data()
	load_customer_data(df, customer)
end

function load_customer_test_data(customer::Int)
	df = load_ausgrid_test_data()
	load_customer_data(df, customer)
end