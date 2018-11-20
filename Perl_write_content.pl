#ARGV[0] Input file DIR;
#ARGV[1] Output file DIR;
<<<<<<< HEAD
#execute perl [program] [Input DIR] 
=======

>>>>>>> parent of 0b6cc9f... Update Perl_write_content.pl

use warnings;
use strict;


my $verbose = 1;        #Log on off
my $dir = $ARGV[0];     #Input files DIR
my $out_dir = ".\/rst"; #Output files DIR
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
<<<<<<< HEAD
my $print_something = "`define RAID_SLOT   'h0
`define RAID_PMP    'h0
`define RAID_MODE   'h0
`define RAID_MCNT   'h1";      #text need to add in the file

=======
>>>>>>> parent of 0b6cc9f... Update Perl_write_content.pl

mkdir($out_dir) unless(-d $out_dir); #create outout files dir;

opendir $dir_handle, $dir or die "can not open dir $dir :$!\n";
opendir $out_dir_handle, $out_dir or die "can not open out_dir $out_dir :$!\n";

foreach $file (readdir $dir_handle){
<<<<<<< HEAD
        # print "there has $file in the file\n";     ######### Check files in the folder;
    
    local $/= undef;
    
    next if($file =~ /^\./);               #process all folder except . 
    next if($file =~ /^\.\.$/);             #process all folder except ..
    open $file_handle,'<',$file or die " can not open $file : $!\n";
    $file_out = "$file";                #Output file name with suffix .new
=======
        print "there has $file in the file\n";
    open $file_handle,'<',$file or die " can not open $file : $!\n";
    $file_out = "$file.new";           #Output file name with suffix .new
>>>>>>> parent of 0b6cc9f... Update Perl_write_content.pl
    open $file_out_handle, '>>', "$out_dir/$file_out" or die " can not open $file_out :$!\n";
    #print $file_out_handle "this is the first line!\n";    #add some text to first line;
    
<<<<<<< HEAD
    my $fullstring = do{local $/;<$file_handle>};       ###### Read Full File into String
    open $file_handle,'<',$file or die "can not open $file :$!\n";
    if ($fullstring =~ m/$print_something/g){
            print "Found same content in: ".$file."\n";
            $fail_cnt++;
            push(@fail_files,$file);
            while(<$file_handle>){
                #print $file_out_handle "print something here\n";
                print $file_out_handle $_;
            }
    }
    else{
            print "there has no same content in: ".$file."\n";
            $success_cnt++;
            push(@success_files,$file);
            
            print $file_out_handle $print_something;
            while(<$file_handle>){
                #print $file_out_handle "it prints something\n";
                print $file_out_handle $_;
            }
            #print $file_out_handle $print_something;
    }
=======
    print $file_out_handle "this is the first line!\n";
    while (<$file_handle>){                 #Do somethining here.
            print $file_out_handle $_;      
    }
    close $file_handle;
>>>>>>> parent of 0b6cc9f... Update Perl_write_content.pl
    close $file_out_handle;
    
}
<<<<<<< HEAD
    #show log
    if ($verbose){
    print "list of succesful files: \n";
    print "@success_files","\n";
    print "list of unprocess files: \n";
    print "@fail_files","\n";
    }
    print "process $success_cnt files\n";
    print "unrocess $fail_cnt files\n";


=======
>>>>>>> parent of 0b6cc9f... Update Perl_write_content.pl
    close $dir_handle;
    close $out_dir_handle;

    system("rm *.v");
    system("cp ./rst/*.v ./");
    system("rm -rf ./rst");
