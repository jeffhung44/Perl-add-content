use warnings;
use strict;


my $dir = $ARGV[0];
my $dir_handle;
my $file;
my $file_handle;
my $file_out;
my $file_out_handle;

opendir $dir_handle, $dir or die "can not open dir $dir :$!\n";
foreach $file (readdir $dir_handle){
    open $file_handle,'<',$file or die " can not open $file : $!\n";
    $file_out = "$file.bak";
    open $file_out_handle, '>>',$file_out or die " can not open $file_out :$!\n";
    
    print $file_out_handle "this is the first line!\n";
    while (<$file_handle>){
            print $file_out_handle $_;
    }
    close $file_handle;
    close $file_out_handle;
    
}
    close $dir_handle;

