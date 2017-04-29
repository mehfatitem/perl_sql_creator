use warnings;
use strict;

use SqlCreator;

#create SqlCreator object
my $object = SqlCreator->new;

#create array for sql
my @column = ('name','surname' , 'age');
my @emptyArray = ();
my @value = ('Mehmet', 'Temizce' , 28);
my @updateArray = ('name:Mehmed Fatih' , 'surname:Temiz' , 'age:28');

#create sql string
my $insertSql = $object->createInsertSql('person' , \@column , \@value);
my $deleteSql = $object->createDeleteSql('person' , 'id=5');
my $updateSql = $object->createUpdateSql('person' ,  \@updateArray , 'id=5');
my $selectSql = $object->createSelectSql('person' ,  \@emptyArray , '' , 'id DESC');

#print sql string
print $insertSql;
print "\n";
print $deleteSql;
print "\n";
print $updateSql;
print "\n";
print $selectSql;
print "\n";