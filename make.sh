#!/bin/sh


olddir=`pwd`
current_dir=$(cd "$(dirname "${0}")"; pwd)
cd $current_dir
echo "enter ${current_dir}"

EBINDIR="./ebin"
DB_DIR="./dbfile/"
PROTO_DIR=$current_dir/../../../common/proto
INC_DIR=$current_dir/../include/
PKT_DIR=$current_dir/../src/packet_handle/protocol/
SERVER_TAR=x3server.tar.gz

echo
echo "svn up $current_dir/../"
svn up $current_dir/../

echo
echo svn up $PROTO_DIR
svn up $PROTO_DIR


chmod +x *.sh
chmod +x run
chmod +x stop
chmod +x erl_make

MAKE_MSG_CMD="erl -s proto_gen_code start -beam $EBINDIR $PKT_DIR $INC_DIR -debug -proto $PROTO_DIR/login.proto"

echo
echo "$MAKE_MSG_CMD"
$MAKE_MSG_CMD


if [ ! -d "$DB_DIR" ]; then
        mkdir "$DB_DIR"
fi

if [ ! -d "$EBINDIR" ]; then
        mkdir "$EBINDIR"
fi

echo 
if [ $1 ]
	then
		echo "cp Emakefile.win Emakefile"
		cp Emakefile.win Emakefile
	else
		echo "cp Emakefile.linux Emakefile"
		cp Emakefile.linux Emakefile
fi

echo "escript make_ets_validate_hrl.erl"
escript make_ets_validate_hrl.erl
echo "escript ets_vali_gen_code"
escript ets_vali_gen_code
echo "erl -pa $EBINDIR -s mmake all -outver $EBINDIR 3"
erl -pa $EBINDIR -s mmake all -outver $EBINDIR 3

OS_NAME=`uname`

C_HEADER_DIR=$current_dir/../c_src/find_path
C_SRC_DIR=$current_dir/../c_src/find_path
ERL_ROOT=/Chunbai/app/erlang/lib/erlang/usr/include
LDFLAGS="-L/usr/local/lib -L/Chunbai/app/erlang/lib/erlang/lib/erl_interface-3.7.6/lib"
echo 
case $OS_NAME in
	Linux) CMDLINE="gcc -fPIC -shared -o $EBINDIR/find_path64.so $C_SRC_DIR/*.c  $LDFLAGS  -I $ERL_ROOT -I $C_HEADER_DIR" ;;
	Darwin) CMDLINE="gcc -undefined dynamic_lookup -dynamiclib -fPIC -sheard -o $EBINDIR/find_path64.so $C_SRC_DIR/*.c  $LDFLAGS  -I $ERL_ROOT -I $C_HEADER_DIR";;
	*) CMDLINE="";;
esac

echo $CMDLINE
$CMDLINE

if [ -f "$SERVER_TAR" ]; then
   rm -rf $SERVER_TAR
fi

cd ../../

if [ -f "$SERVER_TAR" ]; then
   rm -rf $SERVER_TAR
fi

if [ -f "$EBIN_DIR/erl_crash.dump" ]; then
   rm -rf "$EBIN_DIR/erl_crash.dump"
fi

if [ -f "$current_dir/erl_crash.dump" ]; then
   rm -rf "$current_dir/erl_crash.dump"
fi
case $OS_NAME in
	Linux) TAR_CMD="tar czf ${SERVER_TAR} game_server  --exclude=.svn --exclude=src --exclude=c_src --exclude=include --exclude=back_ebin";;
	Darwin) TAR_CMD="tar czf ${SERVER_TAR} game_server";;
	*) TAR_CMD="" ;;
esac

echo 
echo "$TAR_CMD"
$TAR_CMD

echo 
echo "mv ${SERVER_TAR} $current_dir/"
mv ${SERVER_TAR} $current_dir/

cd $olddir
echo 
echo "leave ${current_dir}"
