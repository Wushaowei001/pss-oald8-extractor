#!/usr/bin/perl

#
# �e�X�N���v�g�� PAR ���̂��߂Ɉꌳ�I�ɌĂяo��
#

use Getopt::Long;

MAIN: {
    #
    # �R�}���h�s����͂���
    #
    my $call_type = '';
    GetOptions('calltype=s' => \$call_type, 'workdir=s' => \$work_directory);
    
    if ($call_type eq '') {
        print "usage: fpwcaller.pl -calltype gaiji|halfchar|split...\n";
        die "\n";
    }
    
    print "call type: [${call_type}]\n";
    
    if ($call_type eq 'split_psssound') {
        require 'split_psssound.pl';
    } elsif ($call_type eq 'psstool') {
        require 'psstool.pl';
    } else {
        print "unknown call type..";
    }
}

1;
