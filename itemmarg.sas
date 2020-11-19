/**************************************************************************
macro to make a plot of the marginal distribution of items

%itemmarg(data=sasuser.SF36, items=gh1-gh5);

the data set 'data' contains items.
**************************************************************************/

%macro itemmarg(data, items, tables=NO);
	options nomprint nomlogic nonotes nostimer;

	*********************************
	* save stuff as macro variables *
	*********************************;

	*save number of respondents as macro variable;
	data _null_;
		set &data end=final;
		if final then call symput('N',trim(left(_N_)));
	run;
	* save item names as macro variables;
	data _null_;
		set &data;
		array _y (*) &items;
		length ___name $8;
		if _n_=1 then do;
			do _i=1 to dim(_y);
				call vname(_y{_i},___name);
				call symput('_item'||trim(left(put(_i,4.))),trim(left(___name)));
			end;
			_p=dim(_y); 
			call symput('_nitems', trim(left(put(_p,4.))));
		end;
	run;
	***************************** 
	* write something in log    *
	*****************************;
	%put ---------------------------------------------------------;
	%put make a plot of the marginal distribution of items;
	%put reading data set &data, &N respondents;
	%put &_nitems items: ; 
	%put ;
	%put &items; 
	%put ---------------------------------------------------------;

	*ODS SELECT NONE;

	proc freq data=&data; 
		%do _i=1 %to &_nitems;
			ods output freq.table&_i..onewayfreqs=_t&_i.;
		%end;
		table &items / nocum;
	run;
	%do _i=1 %to &_nitems;
		data _t&_i.;
			set _t&_i.;
			item='                               ';
			item="&&_item&_i";
			score=&&_item&_i.;
			keep item frequency percent score;
		run;
	%end;
	data _new;
		set _t1-_t&_nitems;
	run;

	*ODS SELECT ALL;

	proc gchart data=_new;
		vbar item / discrete subgroup=score
		group=item g100 nozero
		freq=frequency type=percent;                                                                                                        
	run;                                                                                                                                    
	quit; 

	/* clean up */
	proc datasets nolist;
		delete _t1-_t&_nitems _new;
	run; quit;
	options notes stimer;

%mend itemmarg;
