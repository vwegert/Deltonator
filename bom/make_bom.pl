#!/usr/bin/perl 
#**********************************************************************************************************************
#**
#** bom/make_bom.pl
#**
#** This script takes the BOM data logged by OpenSCAD (which might be "contaminated" with other output lines)
#** and renders a simple text-file BOM.
#**
#**********************************************************************************************************************/

use strict;
use warnings;

use constant TEXT_COL_WIDTH => 70;

# 
# input line format:
#   ECHO: "BOM;<material>;<size>;<number>;<usage path>"
#
# example:
#   ECHO: "BOM;MakerSlide Extrusion;800 mm;1;>vertical_axis_assembly>_vertical_axis_assembly>makerslide_vertical_rail"
#
my %material_totals;
my %material_usage;

#
# read the input data
#
while (<>) {
	if ($_ =~ /^ECHO: "BOM;(.*);(.*);(.*);(.*)"$/) {
		my $material = $1;
		my $size = $2;
		my $number = $3;
		my $usage = $4;

		# clean up the usage path a little: remove the leading > and internal modules (beginning with _)
		my @usage_path = split(/>/, $usage);
		shift(@usage_path);
		@usage_path = grep(!/^_/, @usage_path);
		$usage = join(' >> ', @usage_path);

		$material_totals{$material}{$size} += $number;
		$material_usage{$material}{$size}{$usage} += $number;
	}
}

# 
# produce the output in the following format:
#   <material>
#     <size>...................<total_number>
#       <usage>                (<number>)
#       <usage>                (<number>)
#     <size>...................<total_number>
#       <usage>                <number>
#
foreach my $material (sort keys %material_totals) {
	print("$material\n");
	foreach my $size (sort keys %{ $material_totals{$material} }) {
		my $total_number = $material_totals{$material}{$size};
		my $display_size = $size . "." x (TEXT_COL_WIDTH - length($size));
		print("  $display_size $total_number\n");
		foreach my $usage (sort keys %{ $material_usage{$material}{$size} }) {			
			my $usage_number = $material_usage{$material}{$size}{$usage};
			my $display_usage = $usage . " " x (TEXT_COL_WIDTH - length($usage));
			print("    $display_usage ($usage_number)\n");
		}
	}
}