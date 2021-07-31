BIN="/data/data/com.termux/files/usr/bin"

DIR="/sdcard/Documents/dailynotes"

msg="mirai-nikki note installed successfully!\ntry execute 'note' or 'n'"

install(){

  echo -n "Install mirai-nikki note now? [Yes/No] "

  read a

  case "$a" in

    y|Y|yes|Yes|YES)

      rm $BIN/{note,n} &>/dev/null

      echo -e "$note" >> $BIN/note;

      chmod +x $BIN/note

      ln -s $BIN/note $BIN/n

      echo -e "\e[92m$msg\e[0m"

    ;;

    *)

      echo bye-bye!

    ;;

  esac
}


uninstall() {

  [ -f $BIN/note ] &&

    {

      echo -ne "Do you really want to uninstall note?
\e[93m(though you have to manually delete note files in $DIR) [Y/N] \e[0m"

      read a

      case "$a" in

        y|Y|yes|Yes|YES)

          rm $BIN/{note,n} &>/dev/null

          echo "uninstalled successfully!"

          ;;

        *)

          echo "action cancelled." 

      esac

    } ||

      echo "mirai-nikki note is not even installed? you baka! sussy baka!"

}

note="#!/data/data/com.termux/files/usr/bin/env bash
DIR=\"/sdcard/Documents/dailynotes/\$(date +'%Y')\";
mkdir -p \$DIR;
today=\$(date +'%d-%m-%Y');
cd \$DIR;
case \"\$1\" in
  -d|--undo)
    [ \$2 ] &&
    for i in \$(seq \$2)
    do
    echo -ne \"undo: \"
    echo -e \"\$(sed -n '\$p' \${today}.txt)\" | tee -a .\${today}.undo
    sed -i '\$d' \${today}.txt
    done || {
    echo -ne \"undo: \" &&
    echo -e \"\$(sed -n '\$p' \${today}.txt)\" | tee -a .\${today}.undo
    sed -i '\$d' \${today}.txt
    }
    ;;
  *)
    [ \$1 ] &&
    echo \"[\$(date +'%r')] \$*\" >> \${today}.txt &&
    echo \"note updated!\" ||
    cat \${today}.txt 2>/dev/null ||
    echo -e \"no notes found today!
    
    you can add some notes for today by passing your note text as argument!
    
    example:
    note I woke up so early! what in a million coincidences!
    note hello world! uhm.. what kind of suffering i'll go through today?\"
    ;;
esac
"

help="
usage:
bash $0 install
bash $0 uninstall
"

case "$1" in
	install)
		install
		;;
	uninstall)
		uninstall
		;;
	*)
		echo -e "$help"
esac
