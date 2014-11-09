#!/opt/local/bin/perl

my %q ;
my $file = $ARGV[0];  # 'queryCount.txt';
open FILE, $file ;

foreach $line ( <FILE> ) {

  ($val, $query) = ($line =~ /^(\d+)\s+(.*)$/);

  $query =~ s/(\d+)/D/g;

  $q{$query} = $q{$query} + $val ;
}

foreach $key (keys %q ) {
  print $q{$key}, "\t$key\n";
}

__END__
#!/opt/local/bin/perl
#
#my %q ;
#open FILE, $file ;
#
##@file = <FILE>;
#foreach $line ( <FILE> ) {
#
#  ($val, $query) = ($line =~ /^(\d+)\s+(.*)$/);
#
#    $query =~ s/(\d+)/D/g;
#
#      $q{$query} = $q{$query} + $val ;
#      }
#
#      foreach $key (keys %q ) {
#        print $q{$key}, "\t$key\n";
#        }
#
