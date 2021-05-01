#!/usr/bin/perl 

use strict;
use warnings;
use Getopt::Long;


my $text="";
my $name="";
my $videoid=0;
my $videoname="";
my @lines;
my $help=0;
my $f;

GetOptions("text=s"  => \$text,
	"name=s"     => \$name,
	"help|?"       => \$help, 
	"videoid=s"  => \$videoid,
	"videoname=s" => \$videoname
) or die ("Error in command line\n");

sub usage {
print <<END
createhtml.pl --name <titre html> 
                --text <fichier texte:une ligne par video> 
                --videoid <premiere video ID> 
                --videoname <nom generique des videos> 
END

}

if ($help) {
	usage();
	exit(1);
}

open (my $FH_O, ">", $name) or die "Can't open $name";

sub createEntete 
{
	print $FH_O <<END
<link href="https://chamilo.univ-grenoble-alpes.fr/web/css/editor.css" media="screen" rel="stylesheet" type="text/css" /> <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>$name</title>
END
}

sub printHref
{
	my $i = 1;
	map {
		print $FH_O "<p><a href=\"#$i\">$_</a></p>\n";
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
		print $FH_O "<p><a id=\"$i\" name=\"$i\">$_</a></p>\n";
		print $FH_O "<p><simsupod><iframe allowfullscreen=\"\" height=\"360\" src=\"https://videos.univ-grenoble-alpes.fr/video/$videoid-$videoname-$i//?is_iframe=true\" style=\"padding: 0; margin: 0; border:0\" width=\"640\"></iframe></simsupod></p>\n";
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
close ($FH_O);
