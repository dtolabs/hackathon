#!/bin/bash
die () { echo "$*" ; exit 1 ; }

# change basedir to the java-ec2-nodes install directory
basedir=.

JAR="$basedir/ec2-rundeck-node-generator-0.1.jar"
AWSCRED=$basedir/AwsCredentials.properties
MAPPING=$basedir/mapping.properties
TMPDIR=/tmp/ec2-instances.cgi-$$

# read the query params (if any)
for VAR in `echo $QUERY_STRING | tr "&" "\t"`
do
  NAME=$(echo $VAR | tr = " " | awk '{print $1}';);
  VALUE=$(echo $VAR | tr = " " | awk '{ print $2}' | tr + " ");
  declare $NAME="$VALUE";
done

mkdir -p $TMPDIR || { die "failed making temporary work directory" ; }

java -jar $JAR $AWSCRED $MAPPING > $TMPDIR/resources.xml 2>/dev/null
[ $? != 0 ] && { die "AWS request failed" ; }

# parse the xml results for settings
xmlstarlet sel -t -m //setting -v @name -o : -v @settingValue -n $TMPDIR/resources.xml > $TMPDIR/settings.txt
[ $? != 0 ] && { die "XML parsing or query failed" ; }

# generate the json data
echo "[" > $TMPDIR/options.json

while read line
do
    key=$(echo $line | cut -f1 -d:)
    val=$(echo $line | cut -f2 -d:)
    attrib=$(echo ${key##*-})
    node=$(echo ${key%-*})
    localname=${node%%.*}
    case $attrib in
	instanceId)
	    printf "{name: \"%s (%s)\",value:\"%s\"},\n" \
		${val} $localname ${val}
	    ;;	 
    esac
done < $TMPDIR/settings.txt >> $TMPDIR/options.json

echo "]" >> $TMPDIR/options.json

echo Content-type: application/json
echo ""
cat $TMPDIR/options.json

# clean up
rm -r $TMPDIR