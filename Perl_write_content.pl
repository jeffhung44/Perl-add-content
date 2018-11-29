#ARGV[0] Input file DIR;
#ARGV[1] Output file DIR;
#execute perl program Input DIR "Content line 1" "Line 2" "and so far"
#perl perl_write_content.pl ./ "white to first line" "white second line"

use warnings;
use strict;

my $backup = 1;         #The process files in the new folder new
my $verbose = 1;        #Log on off
my $chk_content=0;
my $log_file="perl.log";
my $log_fh;
my $dir = $ARGV[0];     #Input files DIR
my $out_dir = ".\/new"; #Output files DIR
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
my @print_something = @ARGV;      #text need to add in the file
my @print_something_tmp;


for(my $i=1;$i<@print_something;$i=$i+1){
        print $ARGV[$i]."\n";
        $print_something_tmp[$i-1] =$ARGV[$i];
}
my $fullstring2 =join("\n",@print_something_tmp);

#foreach (@print_something){
#    print $_."\n";
#}

mkdir($out_dir) unless(-d $out_dir); #create outout files dir;

opendir $dir_handle, $dir or die "can not open dir $dir :$!\n";
opendir $out_dir_handle, $out_dir or die "can not open out_dir $out_dir:$!\n";

foreach $file (readdir $dir_handle){
        # print "there has $file in the file\n";     ######### Check files in the folder;
    
        #local $/= undef;
    
    next if($file =~ /^\./);               #process all folder except . 
    next if($file =~ /^\.\.$/);             #process all folder except ..
    next if($file =~/new/);
    open $file_handle,'<',"$dir/$file" or die " can not open $file : $!\n";
    $file_out = "$file";                #Output file name with suffix .new
    open $file_out_handle, '>', "$out_dir/$file_out" or die " can not open $file_out :$!\n";
    #print $file_out_handle "this is the first line!\n";    #add some text to first line;
    
    my $fullstring = do{local $/;<$file_handle>};       ###### Read Full File into String
    if($chk_content){
        print"=====================================\n";
        print $fullstring2."\n";
        print"=====================================\n";
    }
    open $file_handle,'<',"$dir/$file" or die "can not open $file :$!\n";
    

    if ($fullstring =~ m/$fullstring2/){
            print "Find same content in: ".$file."\n";
            $fail_cnt++;
            push(@fail_files,$file);
            while(<$file_handle>){
                #print $file_out_handle "print something here\n";
                print $file_out_handle $_;
            }
    }
    else{
            print "No same content in: ".$file."\n";
            $success_cnt++;
            push(@success_files,$file);
            
            for(my $j=1;$j<@print_something;$j=$j+1){
                print $file_out_handle $ARGV[$j]."\n";
            }

            #print $file_out_handle @print_something."\n";
            while(<$file_handle>){
                #print $file_out_handle "it prints something\n";
                print $file_out_handle $_;
            }
            #print $file_out_handle $print_something;
    }
    close $file_out_handle;
}


    open $log_fh, '>', "$log_file" or die " can not open $log_file :$!\n";

    #show log
    if ($verbose){
    print "List of process files: \n";
    print $log_fh "List of process files: \n";
    print"=====================================\n";
    print $log_fh "Totaly ".$success_cnt." files\n";
    print "@success_files"."\n";
    print $log_fh "@success_files"."\n";
    print"=====================================\n";
    print "list of unprocess files: \n";
    print"=====================================\n";
    print $log_fh "List of unprocess files: \n";
    print $log_fh "Totaly ".$fail_cnt." files\n";
    print "@fail_files"."\n";
    print $log_fh "@fail_files"."\n";
    print"=====================================\n";
    }
    print "process $success_cnt files\n";
    print "unrocess ".$fail_cnt."files\n";

    close $log_fh;
    close $dir_handle;
    close $out_dir_handle;
    
    
    if (!$backup){
    system("rm $dir/*.v");
    system("cp $dir/new/*.v $dir");
    system("rm -rf $dir/new");
    }
