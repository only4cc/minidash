#
# Mini Dashboard
#
package minidash;
use Dancer2;
use Data::Table;
use Text::CSV;


get '/' => sub {
    my $panel1 = get_panel1();
    my $panel2 = get_panel2();
    my $panel3 = get_panel3();
    my $panel4 = get_panel4();
    my $panel5 = get_panel5();
    my $panel6 = get_panel6();

    template 'index', { 'panel1'=>$panel1,
                        'panel2'=>$panel2,
                        'panel3'=>$panel3,
                        'panel4'=>$panel4,
                        'panel5'=>$panel5,
                        'panel6'=>$panel6,
                      };
};

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
	$tabla_html =~ s/data_table/table-condensed/;
    return 'Mejores Puntajes:'.$tabla_html;
}

sub get_panel2 {
    return int(rand(1000));
}

sub get_panel3 {
    return int(rand(1000));
}

sub get_panel4 {
    return int(rand(1000));
}

sub get_panel5 {
    return int(rand(1000));
}
sub get_panel6 {
  my $max = 100;
# Despues cargar desde un archivo ... 
  my @v = (int(rand($max)), int(rand($max)), int(rand($max)), 
  		   int(rand($max)), int(rand($max)), int(rand($max)) );
 
  my $chart = '<div class="chart">';
  foreach my $v ( @v ) {
	$chart .= "<div style=\"width: ".($v*10)."px\;\">".$v."</div>";
  }
  $chart .= ' </div>';
  return $chart;
}


true;
