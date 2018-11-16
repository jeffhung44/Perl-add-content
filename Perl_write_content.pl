#ARGV[0] Input file DIR;
#ARGV[1] Output file DIR;
#execute perl [program] [Input DIR] [Output DIR]

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
my $fail_cnt = 0;
my $success_cnt = 0;
my @fail_files;
my @success_files;
my $print_somethins = "file for test";      #text need to add in the file


mkdir($out_dir) unless(-d $out_dir); #create outout files dir;

opendir $dir_handle, $dir or die "can not open dir $dir :$!\n";
opendir $out_dir_handle, $out_dir or die "can not open out_dir $out_dir :$!\n";

foreach $file (readdir $dir_handle){
        # print "there has $file in the file\n";     ######### Check files in the folder;
    
    next if($file =~ /^\.$/);               #process all folder except . 
    next if($file =~ /^\.\.$/);             #process all folder except ..

    open $file_handle,'<',$file or die " can not open $file : $!\n";
    $file_out = "$file.new";                #Output file name with suffix .new
    open $file_out_handle, '>>', "$out_dir/$file_out" or die " can not open $file_out :$!\n";
    
    print $file_out_handle "this is the first line!\n";    #add some text to first line;
    while (<$file_handle>){
    #############Do somethining here.
    if(/$print_somethins/){
        print "there has content $print_somethins in $file\n";
        $fail_cnt++;
        push(@fail_files,$file);
        last;
    }
    else{
        print $file_out_handle $print_somethins."  ****add this new line to the file which is not have the same text***"."\n";
        $success_cnt++;
        push(@success_files,$file);
        last;
    }
    #  print $file_out_handle $_;      #clone same text before [num]
    #       last if $.==2;                  #print [something] at line [nmu]
            
    }
    print $file_out_handle "It can add the line in the middle\n";   #print [something]

    while(<$file_handle>){
            print $file_out_handle $_;      #print left text
    }
    
    print $file_out_handle "It can add the line in the bottom\n";
    #$success_cnt++;
    #push(@success_files,$file);
    close $file_handle;
    close $file_out_handle;
}
    #show log
    print "list of succesful files: \n";
    print "@success_files","\n";
    print "success $success_cnt files\n";
    print "list of unprocess files: \n";
    print "@fail_files","\n";
    print "fail $fail_cnt files\n";


    close $dir_handle;
    close $out_dir_handle;

