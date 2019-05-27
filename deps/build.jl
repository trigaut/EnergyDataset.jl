using Pkg

# Load Ausgrid dataset
pkgdir = Pkg.dir("EnergyDataset")
ausgrid_train_dir = pkgdir*"data/Ausgrid/train_data"
ausgrid_test_dir = pkgdir*"data/Ausgrid/test_data"

ausgrid_repo = "https://www.ausgrid.com.au/-/media/Documents/Data-to-share/Solar-home-electricity-data/"
train_data_file = "Solar-home-half-hour-data---1-July-2011-to-30-June-2012.zip"
test_data_file = "Solar-home-half-hour-data---1-July-2012-to-30-June-2013.zip"


if ~isfile(ausgrid_train_dir*"/Ausgrid solar home electricity data notes (Aug 2014).pdf")
	tmpfile = download(ausgrid_repo*train_data_file)
	run(`unzip $tmpfile -d $ausgrid_train_dir`)
end

if ~isfile(ausgrid_test_dir*"/Ausgrid solar home electricity data notes (Aug 2014).pdf")
	tmpfile = download(ausgrid_repo*test_data_file)
	run(`unzip $tmpfile -d $ausgrid_test_dir`)
end