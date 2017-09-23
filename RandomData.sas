%let fpath = path/to/output/folder;

proc format;
	value boolfmt 0='False' 1='True';
	picture timefmt low-high = '%Y-%0m-%0d %0H:%0M:%0S' (datatype = datetime) ;
run ;

%macro run_iterations;

	%do i=1 %to 10;
		data Randomdata;
			length ID 3 GROUP $1;
			format BOOL boolfmt.;
			format DATE timefmt.;
			
			alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
			epoch = '01jan1970 00:00:00'dt;

			do i=1 to 20;      
			  ID = (1 + floor((1+15-1)*rand("uniform")));
			  GROUP = substr(alpha, (1 + floor((1+26-1)*rand("uniform"))), 1);
			  NUM1 = rand("normal", 0, 0.5);
			  NUM2 = rand("normal") * 100;
			  BOOL = round(abs(rand("normal", 0, 0.5)),1);
			  DATE = (epoch + floor((1+Datetime()-epoch)*rand("uniform")));
			  output;
			end;
			drop i alpha epoch;
		run;

		data Randomdata;
			retain ID GROUP NUM1 NUM2 BOOL DATE;
			set Randomdata;
		run;

		proc export 
			data = Work.Randomdata
			outfile = "&fpath\RandomData_SAS_&i..csv"
			dbms = csv replace;
		run;
	%end;

%mend;

%run_iterations;
