use Text::CSV;
use Data::Table;

my $t = get_panel1();
print $t;

sub get_panel1 {
	my $dirdata = 'C:/Users/Julio/Dropbox/current/minidash/public/data/';
	my $filename = 'test.csv';
	my $fscv = $dirdata.$filename;
	
	my $csv = Text::CSV->new ( { binary => 1 } )  
                or die "No puedo usar CSV: ".Text::CSV->error_diag ();
	open my $fh, "<:encoding(utf8)", $fscv or die "$fscv: $!";
	
	my @data;
	while ( my $row = $csv->getline( $fh ) ) {
#		push @rows, $row;
		push @data, [ @$row ];
	}
	$csv->eof or $csv->error_diag();
	close $fh;
	
	my $data = \@data;
	my $header = ["Nombre", "Puntaje", "otra_columna"];	
	
	my $tabla = Data::Table->new($data, $header, 0);
	my $tabla_html= $tabla->html;
    return 'Mejores Puntajes:'.$tabla_html;
}