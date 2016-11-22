#!/usr/bin/perl 
#**********************************************************************************************************************
#**
#** tools/sizes/generate_sizes_scad.pl
#**
#** This script generates an OpenSCAD script that will dump all of the fixed, configured and derived sizes.
#**
#**********************************************************************************************************************/

use strict;
use warnings;

#
# the files to include and parse
#
our @FILES = ( "conf/part_sizes.scad", "conf/derived_sizes.scad" );

#
# generate the file header with include statements
#
print("// GENERATED FILE, DO NOT EDIT MANUALLY\n");
foreach my $file (@FILES) {
	print("include <../../$file>\n");
}

#
# parse the files line by line and look for function definitions
#
foreach my $filename (@FILES) {
	open(my $srcfile, "<", $filename) or die "Can't open $filename: $!";
	while (my $srcline = <$srcfile>) {
		chomp($srcline);
		if ($srcline =~ /function (.*?)\(\)/) {
			my $function = $1;
			print "echo($function = $function());\n"
		}
	}	
	close($srcfile);
}
