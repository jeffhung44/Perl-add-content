#ARGV[0] Input file DIR;
#ARGV[1] Output file DIR;


use warnings;
use strict;


my $dir = $ARGV[0];     #Input files DIR
my $out_dir = $ARGV[1]; #Output files DIR
my $dir_handle;
my $out_dir_handle;
my $file;
my $file_handle;
my $file_out;
my $file_out_handle;
my $fail_cnt;
my $success_cnt;
my @fail_files;
my @success_files;

mkdir($out_dir) unless(-d $out_dir); #create outout files dir;

opendir $dir_handle, $dir or die "can not open dir $dir :$!\n";
opendir $out_dir_handle, $out_dir or die "can not open out_dir $out_dir :$!\n";

foreach $file (readdir $dir_handle){
        print "there has $file in the file\n";
    open $file_handle,'<',$file or die " can not open $file : $!\n";
    $file_out = "$file.new";           #Output file name with suffix .new
    open $file_out_handle, '>>', "$out_dir/$file_out" or die " can not open $file_out :$!\n";
    
    print $file_out_handle "this is the first line!\n";
    while (<$file_handle>){                 #Do somethining here.
            print $file_out_handle $_;      
    }
    close $file_handle;
    close $file_out_handle;
    
}
    close $dir_handle;
    close $out_dir_handle;

