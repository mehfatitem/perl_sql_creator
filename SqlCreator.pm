package SqlCreator;

use warnings;
use strict;

sub new {
	my ($class, %args) = @_;
	return bless \%args, $class;
}

#edit table column and values for insert sql 
#editInsertArray(arrayType , array) 
#first parameter type column or value 
#second parameter column or value array 
sub editInsertArray{
	my ($type , @array) = @_;
	my $text = '';
	my $arraySize = scalar @array;
	for(my $i=0;$i<$arraySize;$i++){
		if($type eq  'value'){
			$text .= "'".$array[$i]."'".",";
		}else{
			$text .= $array[$i].',';
		}
	}
	my $length = length $text;
	$text = substr($text,0,$length-1);
	return $text;
}

#create insert sql 
#createInsertSql(table , column , value) 
#first parameter table name 
#second parameter column array 
#third parameter value array
sub createInsertSql{
	my ($self, $table, $column, $value) = @_;
	my $sql = 'INSERT INTO '.$table;
	$sql .= ' (';
	$sql.= editInsertArray('column' , @$column);
	$sql .= ')'; 
	$sql .= ' VALUES (';
	$sql.= editInsertArray('value' , @$value);
	$sql .= ')'; 
	return $sql;
}

#create delete sql 
#createDeleteSql(table , condition) 
#first parameter table name 
#second parameter sql condition
sub createDeleteSql{
	my ($self , $table,$condition) = @_;
	my $sql = '';
	if(length $_[2] > 0){
		$sql = "DELETE FROM ".$table." WHERE ".$condition;
	}else{
		$sql = "DELETE FROM ".$table;
	}
	return $sql;
}

#create update sql 
#createUpdateSql(table , updateArray  , condition) 
#first parameter table name  
#second parameter updateArray which contains column:value
#third parameter sql condition
sub createUpdateSql{
	my ($self , $table , $updateArray , $condition) = @_;
	my $sql = "UPDATE ".$table." SET ";
	my $arraySize = scalar @$updateArray;
	for(my $i=0;$i<$arraySize;$i++){
		my @field = split /:/, @$updateArray[$i];
		$sql .= $field[0]." = '".$field[1]."', "; 
	}
	my $length = length $sql;
	$sql = substr($sql,0,$length-2);
	if(length $condition > 0){
		$sql .= " WHERE ".$condition;
	}
	return $sql;
}

#create select sql 
#createSelectSql(table , column , condition , orderCondition) 
#first parameter table name 
#second parameter column array which is selected 
#third parameter sql condition 
#fourth parameter order condition desc or asc as column name
sub createSelectSql{
	my($self , $table , $column , $condition , $orderCondition ) = @_;
	my $sql = "SELECT ";
	my $arraySize = scalar @$column;
	if($arraySize > 0){
		for(my $i=0;$i<$arraySize;$i++){
			$sql .= @$column[$i].",";
		}
		my $length = length $sql;
		$sql = substr($sql,0,$length-1);
	}else{
		$sql .= "*";
	}
	$sql .= " FROM ".$table;
	if(length $condition > 0){
		$sql .= " WHERE ".$condition;
	}
	if(length $orderCondition > 0){
		$sql .= " ORDER BY ".$orderCondition;
	}
	return $sql;
}
1;
