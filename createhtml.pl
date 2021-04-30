#!/usr/bin/perl 

use strict;
use warnings;
use Getopt::Long;


my $text;
my $name;
my $videoid;
my $videoname;
my @lines;

GetOptions("text=s"  => \$text,
	"name=s"     => \$name,
	"videoid=s"  => \$videoid,
	"videoname=s" => \$videoname
) or die ("Error in command line\n");


sub createEntete 
{
	print <<END
<link href="https://chamilo.univ-grenoble-alpes.fr/web/css/editor.css" media="screen" rel="stylesheet" type="text/css" /> <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>$name</title>
END
}

sub printHref
{
	my $i = 1;
	map {
		print "<p><a href=\"#$i\">$_</a></p>\n";
		$i++;
	}
	@lines;
}
sub printAnchors
{
	my $videoid=shift;
	my $videoname=shift;
	my $i = 1;
	map {
		print "<p><a id=\"$i\" name=\"$i\">$_</a></p>\n";
	print "<p><simsupod><iframe allowfullscreen=\"\" height=\"360\" src=\"https://videos.univ-grenoble-alpes.fr/video/$videoid-$videoname-$i//?is_iframe=true\" style=\"padding: 0; margin: 0; border:0\" width=\"640\"></iframe></simsupod></p>\n";
	$i++;
	$videoid++;
	} @lines;
}

open F,"<", $text;
while (my $line = <F>) {
	chomp $line;
   if ($line =~ /^\s*$/) {
   } else {
	   @lines = (@lines, $line);
   }
}
close F;


createEntete();
printHref();
printAnchors($videoid,$videoname);
