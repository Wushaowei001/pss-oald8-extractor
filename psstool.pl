#!/usr/bin/perl

use strict;

use Win32::Registry;
use File::Copy;


#
# P-Study System �̃C���X�g�[����擾
#
my $reg = $HKEY_CURRENT_USER;
my $key = "Software\\Halts Presents\\PSS7\\settings\\1";
my $item;
$reg->Open($key, $item)
  or die "P-Study System�̃C���X�g�[���悪�s���ł�(1)�B���݃��O�C�����Ă��郆�[�U�� P-Study System ���C���X�g�[������Ă��邱�Ƃ��m�F���Ă�������";

my $type;
my $wavvoice_folder;
$item->QueryValueEx("wav-voice-folder", $type, $wavvoice_folder)
  or die "P-Study System�̃C���X�g�[���悪�s���ł�(2)";
# "C:\Documents and Settings\xxx\My Documents\P-Study System\wavvoice"

print "P-Study System wavvoice �t�H���_: [${wavvoice_folder}]\n";

#
# �R�s�[
#

# �R�s�[��p�X����
my $dest_path = $wavvoice_folder . "\\OALD8";

if (-d $dest_path) {
  print "$dest_path �����ɑ��݂��܂�\n";
} else {
  mkdir $dest_path or die "$dest_path ���쐬���邱�Ƃ��ł��܂���B : $!";
  print "$dest_path ���쐬���܂���\n"
}

my @dirs = ("sound-uk", "sound-us");
foreach my $dir (@dirs) {
  print "��${dir} �̃R�s�[\n";

  copy "${dir}_tag.txt", $dest_path;

  my $dest_dir = "${dest_path}\\${dir}";
  if (!-d $dest_dir) {
    mkdir $dest_dir or die "$dest_dir ���쐬���邱�Ƃ��ł��܂���B : $!";
  }

  my @files = glob "${dir}\\*.wav";
  my $count = $#files +1;
  for (my $i=0; $i<$count; $i++) {
    my $file = $files[$i];
    
    my $n = $i+1;
    if ($n % 10 == 0 || $n==$count) {
        my $mini_name = substr($file, 0, 35);
        printf("%-78s\r", "[$n/$count:$mini_name]");
    }
    
    if (!-e "$dest_path\\$file") {
      copy $file, $dest_dir;
    }
  }
  printf("%-78s\r", "");
  print "\n";
}

print "�y�R�s�[�����z\n";
