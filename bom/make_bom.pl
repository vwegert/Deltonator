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

use constant TEXT_COL_WIDTH => 80;

# 
# input line format:
#   ECHO: "BOM;<section>;<material>;<size>;<number>;<usage path>"
#
# example:
#   ECHO: "BOM;Extrusions;MakerSlide Extrusion;800 mm;1;>vertical_axis_assembly>_vertical_axis_assembly>makerslide_vertical_rail"
#
my %material_totals;
my %material_usage;

#
# read the input data
#
while (<>) {
	if ($_ =~ /^ECHO: "BOM;(.*);(.*);(.*);(.*);(.*)"$/) {
		my $section  = $1;
		my $material = $2;
		my $size     = $3;
		my $number   = $4;
		my $usage    = $5;

		# clean up the usage path a little: remove the leading > and internal modules (beginning with _)
		my @usage_path = split(/>/, $usage);
		shift(@usage_path);
		@usage_path = grep(!/^_/, @usage_path);
		$usage = join(' >> ', @usage_path);

		$material_totals{$section}{$material}{$size} += $number;
		$material_usage{$section}{$material}{$size}{$usage} += $number;
	}
}

# 
# produce the output in the following format:
#
#   ===== Section =============================
#
#   <material>
#     <size>...................<total_number>
#       <usage>                (<number>)
#       <usage>                (<number>)
#     <size>...................<total_number>
#       <usage>                <number>
#
print("\n");
foreach my $section (sort keys %material_totals) {
	my $display_section = $section . " " . "=" x (TEXT_COL_WIDTH - length($section));
	print("===== $display_section\n");
	 print("\n");
	foreach my $material (sort keys %{ $material_totals{$section} }) {
		print("$material\n");
		foreach my $size (sort keys %{ $material_totals{$section}{$material} }) {
			my $total_number = $material_totals{$section}{$material}{$size};
			my $display_size = $size . "." x (TEXT_COL_WIDTH - length($size));
			print("  $display_size $total_number\n");
			foreach my $usage (sort keys %{ $material_usage{$section}{$material}{$size} }) {			
				my $usage_number = $material_usage{$section}{$material}{$size}{$usage};
				my $display_usage = $usage . " " x (TEXT_COL_WIDTH - length($usage) - 8);
				print("    $display_usage ($usage_number)\n");
			}
		}
		print("\n");
	}
}