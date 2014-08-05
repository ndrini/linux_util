#!/bin/bash

echo "
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°° UTILITÀ PESCETTO ARANCIONE °°°°°°°°°°°°°°°°°°°°°°° 
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

finito="n"

while [[ $finito = "n" ]] 
do 

echo "Ecco le operazioni possibili  
R per rimpicciolire una serie di immagini 
P per creare un pdf da più file 
B per backup
C per cercare un file
E per uscire"
read -p "Cosa vuoi fare? " azione


# R = rimpicciolisci
case "$azione" in     

  E)	# cambio solo il valore della variabile finito 
	finito="s"
	#dovrebbe chiudersi in programma
	;;

  R)
     
	echo "
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°° RIMPICCIOLIRE UN GRUPPO DI FILE °°°°°°°°°°°°°°°°°° 
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

# dati di base
modifica_immagini="ok"
# specifico il percorso per tutti i file
percorso=/media/Linux/Rimpicciolisci #percorso=/media/Linux/Rimpicciolisci/rimpicciolisci
store_small=/media/Dati/Photos/2014	#  @ subu@VR46-U:~$ 
store_big=/media/Linux/Photos_extra_archivio/2014 




# funzioni

function ciao(){
    # ciao(ciao) non funziona!! 
    echo "ciao"
}


function copio_ed_archivio_da_Canon(){
    # ciao(ciao) non funziona!! 
    echo "ciao"
    cd /media/2A2A-709E/DCIM/  

    cp --parents `find -name \*.jpg*` /media/Linux/butta/foto_da_Canon_temp/
                posizione='/media/Linux/butta/foto_da_Canon_temp'
    # /media/2A2A-709E/DCIM' #  
}



function copia_da_cell(){
    # nel richiamarla indico a quale  
    # es.
    # copia_da_cell HTC
    # posizione='/media/2C62-3415/DCIM/Camera'

    # uso una funzione a parte nel caso della macchina fotografica Canon, che archivia a modo suo...	

    # vedo da che mezzo devo copiare le foto
    case "$1" in 
        HTC)
            posizione='/media/8434-180C/DCIM/100MEDIA' 
        ;;        

        Sam)
	    posizione='/media/2C62-3415/DCIM/Camera'
	;;
 
        Canon)
	    # uso funzione a parte per copiare i file
            copio_ed_archivio_da_Canon #funzione
            posizione='/media/Linux/butta/foto_da_Canon_temp'

	;;

        *)
        exit 
        # return 1
    esac  

    echo -e "\n\n\nStai copiando i file dalla cartella "
    echo $posizione

    cp $posizione/* /home/subu/Desktop/LINK/Rimpicciolisci


    quanto_pic 	#  function 
    # rimpiccliosco i video  
    video_small
    # determino la data della trasformazione
    data_oggi=`date +%Y%m%d_`	
    echo $data_oggi 
    read -p "Descrizione da mettere nel nome della directory? "  descrizione_cartella
	    
    #   unisco 2 stringhe ## join two $vars ###
            nome_cartella="${data_oggi}${descrizione_cartella}"

    # copio i file
    # piccoli 
    # forse devo creare la directory, prima di poterli copiare!!!
    mkdir $store_small/$nome_cartella	
    cp /home/subu/Desktop/LINK/Rimpicciolisci/* $store_small/$nome_cartella
    rm /home/subu/Desktop/LINK/Rimpicciolisci/*
    # grandi
    mkdir $store_big/$nome_cartella
    cp $posizione/* $store_big/$nome_cartella
    # metto le foto in una carellnia chiamata BK 
    mkdir $posizione/$data_oggi
    cp $posizione/* $posizione/$data_oggi
    echo -e "\n Le foto sono state copiate nella cartellina di Bk del telefono" 
    rm $posizione/*
}


function quanto_pic(){
    #Commands
    echo "Specifica un altra taglia dei file"
    echo "Scegli 't1' per 211x286"
    echo "Scegli 't2' per 422x564"
    echo "Scegli 't3' per 844x1128"
    echo "Scegli 't5' per 1688x2256"
    echo "Scegli 't6' per 2397x3204"
    echo "Scegli 't5' per 3376x4512"
    read -p "Specifica un altra taglia dei file: " taglia

    # applico la scelta fatta
    case "$taglia" in     
        t1)
            mogrify -resize 211x286 $percorso/*.{jpg,JPG}
            echo "Scelta t1. Rimpiccioliti a misura differente da 844x1128"			
	;;

	t2)
	    mogrify -resize 422x564 $percorso/*.{jpg,JPG}	
	    echo "Scelta t2. Rimpiccioliti a misura differente da 844x1128 "	
	;;

	t3)
	    mogrify -resize 844x1128 $percorso/*.{jpg,JPG}	
	    echo "Scelta t2. Rimpiccioliti a misura differente da 844x1128 "	
	;;
		
	t5)
	    mogrify -resize 1688x2256 $percorso/*.{jpg,JPG}	
	    echo "Scelta t5. Rimpiccioliti a misura differente da 844x1128: a 1688 x 2256"	
	;;

	t6)
	    mogrify -resize 2397x3204 $percorso/*.{jpg,JPG}	##  precisamente sono 2396,96×3203,52
	    echo "Scelta t6. Rimpiccioliti a misura differente da 844x1128: a 1688 x 2256"	
	;;

	t7)
            mogrify -resize 3376x4512 $percorso/*.{jpg,JPG}	
	    echo "Scelta t6. Rimpiccioliti a misura differente da 844x1128: a 1688 x 2256"	
	;;


        *)
            echo " Rimpicciolisco i file contenuti nella cartella ", $percorso, " a 844x1128" 
	    echo -e "\n Stai rimpicciolendo le immagini con estensione jpg o JPG che sono nella cartella rimpicciolisci"

	    mogrify -resize 844x1128  $percorso/*.{jpg,JPG}  # metti il percorso 	
	    # prima era 
	    # mogrify -resize 844x1128   /home/subu/Desktop/LINK/rimpicciolisci/*.{jpg,JPG}  # metti il percorso assoluto!!
	;;
    esac ###  concludo "applico la scelta fatta" 
}


function video_small(){
    #Commands
    echo -e "\n Rimpicciolisco un video con avidemux"			
    cd $percorso	       		
    VIDEOCODEC="Xvid"
    AUDIOCODEC="MP3"
    # for FIL in `find . -iname 'percorso/*.mov'` ; do 			
    for FIL in `find . -iname '*.mov'` ; do 
    avidemux --video-codec $VIDEOCODEC --audio-codec $AUDIOCODEC --force-alt-h264 --load "$FIL" --save ${FIL%.*}.s.#avi --quit
    done

    for FIL in `find . -iname '*.avi'` ; do 
    avidemux --video-codec $VIDEOCODEC --audio-codec $AUDIOCODEC --force-alt-h264 --load "$FIL" --save ${FIL%.*}.s.#avi --quit
    done

    for FIL in `find . -iname '*.AVI'` ; do 
    avidemux --video-codec $VIDEOCODEC --audio-codec $AUDIOCODEC --force-alt-h264 --load "$FIL" --save ${FIL%.*}.s.#avi --quit
    done

    # non tratto gli mp4
    # for FIL in `find . -iname '*.mp4'` ; do 
    # avidemux --video-codec $VIDEOCODEC --audio-codec $AUDIOCODEC --force-alt-h264 --load "$FIL" --save ${FIL%.*}.s.#avi --quit
    # done
	
    # cancello i file rimpiccioliti tipo mov
    for canc in `find . -iname '*.mov'` ; do rm $canc; done

    # cancello i file avi originali
    for canc in `find . -iname '*.avi'` ; do rm $canc; done
    for canc in `find . -iname '*.AVI'` ; do rm $canc; done
    # for canc in `find . -iname '*.mp4'` ; do rm $canc; done
 
    # rinomino i file 
    # for lista in `find . -iname '*.s.#avi'` ; do mv $canc ; done
    for files in *.s.#avi; do mv "$files" "${files%.s.#avi}.avi"; done
}

while [[ $modifica_immagini = "ok" ]]
    do

    echo "Va bene rimpicciolirli per archiviazione in formato standard (844x1128)?"
    echo -e "Se sì, schiaccia 'Ok', altrimentri 'Al' (che sta per altro),\n 'Co' per copiare dal desktop le immagini," 
    echo -e "'Sam' per copiare/rimpicciolire/smistare dal cellulare samsung 3404772706," 
    echo -e "'HTC' per copiare/rimpicciolire/smistare dal cellulare HTC ex Susanna," 
    echo -e "'Canon' per copiare/rimpicciolire/smistare da macchina fotografica Canon di Susanna," 
    read -p "'Vi' per un video (anche nested):  " quanto_piccoli
	
	
    if [ $quanto_piccoli == "Co" ] # fine if 36 video 
        then
	    echo "Copio i dati in " $percorso 		
	    cp Desktop/{*.jpg,*.JPG,*.png,*.avi,*.mov,*.AVI} $percorso 
	# nautilus "/home/subu/Desktop/LINK/Rimpicciolisci/rimpicciolisci"
    fi # fine if 36 video 


    # converto (anche se non ce ne sono) png in jpg
    mogrify -format jpg $percorso/*.png  

    if [ $quanto_piccoli == "Vi" ] # if 30 video 
	then
	video_small 
    fi # fine if 30 video 

    if [ $quanto_piccoli == "Al" ]  # if 40 taglia differente 
	then
	#  function 
        quanto_pic

    fi   # fine dell'if 40 taglia differente


                #{{'SaNero'  copio da cellulare 
    if [ $quanto_piccoli == "HTC" ]  # if 40 taglia differente 
        then
            copia_da_cell $quanto_piccoli
    fi


                #{{'SaNero'  copio da cellulare 
    if [ $quanto_piccoli == "Canon" ]  # if 40 taglia differente 
        then
            copia_da_cell $quanto_piccoli
    fi





                #{{'SaNero'  copio da cellulare 
    if [ $quanto_piccoli == "Sam" ]  # if 40 taglia differente 
        then
	    cp /media/2C62-3415/DCIM/Camera/* /home/subu/Desktop/LINK/Rimpicciolisci
            quanto_pic 	#  function 
            # rimpiccliosco i video  
            video_small
            # determino la data della trasformazione
	    data_oggi=`date +%Y%m%d_`	
            echo $data_oggi 
            read -p "Descrizione da mettere nel nome della directory? "  descrizione_cartella
	    
            #   unisco 2 stringhe ## join two $vars ###
            nome_cartella="${data_oggi}${descrizione_cartella}"

	    # copio i file
            # piccoli 
            # forse devo creare la directory, prima di poterli copiare!!!
	    mkdir $store_small/$nome_cartella	
    	    cp /home/subu/Desktop/LINK/Rimpicciolisci/* $store_small/$nome_cartella
            rm /home/subu/Desktop/LINK/Rimpicciolisci/*
            # grandi
	    mkdir $store_big/$nome_cartella
            cp /media/2C62-3415/DCIM/Camera/* $store_big/$nome_cartella
            # metto le foto in una carellnia chiamata BK 
            mkdir /media/2C62-3415/DCIM/Camera/$data_oggi
	    cp /media/2C62-3415/DCIM/Camera/* /media/2C62-3415/DCIM/Camera/$data_oggi
            echo -e "\n Le foto sono state copiate nella cartellina di Bk del telefono" 
            rm /media/2C62-3415/DCIM/Camera/*
	    	            
        fi #
	

	read -p "Vuoi modificare ancora le immagini?  Scegli «ok», se sì. Altro carattere, se no. "  modifica_immagini
	done  ###  concludo il ciclo la scelta generale dell'azione   //  ciclo = 0;

	# apro la cartellina 
 	nautilus $percorso
	;;

# pdftk
  P)
	echo "
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°° UNISCO PIU' PDF °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° 
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
        echo -e 'Ricordati il comando \n pdftk 1.pdf 2.pdf 3.pdf cat output outputfile.pdf  \n 1.pdf = file_da_unire_1.pdf \n Il nome del file unito è outputfile.pdf \n\n'  # scrivere 'echo -e' serve per utilizzare il comando escape (questo \) 

	echo -e "**** Per Ridurre la taglia di un file, invece, usa il comando gs \n gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=output.pdf input.pdf \n"



	echo -e "Cosa vuoi fare: \n unire 3 file --> U3 \n unire # file --> UN \n ruotare file --> RU \n";
	read -p "Inserisci l'opzione scelta: " opz_pdf;

	# faccio quanto chiesto 
	case "$opz_pdf" in     

		  U3)	# cambio solo il valore della variabile finito 
			echo "opzione unire 3 file"
			echo -e '\n Per farlo in automatico \n a. rinomina i 3 file da unire 1.pdf,2.pdf,3.pdf \n b. mettili nel desktop. \n c. clicca un tasto qualcunque \n\n'
			echo -e "Rinomina i file che vuoi unire come 1.pdf 2.pdf 3.pdf ... (nell'ordine in cui vuoi siano uniti e mettili nel Desktop"
        		echo -e "Hai rinominato i file? (clicca qualsiasi carattere e poi invio per continuare) \n \n"
        		echo -e "Sono in numero diverso da 3? Dopo scriverai il numero, quando ti sarà richiesto. \n *************************************** \n " 

			pdftk /home/subu/Desktop/1.pdf /home/subu/Desktop/2.pdf /home/subu/Desktop/3.pdf cat output /home/subu/Desktop/outputfile.pdf  #dovrebbe funzionare...

			;;




		  UN)	# cambio solo il valore della variabile finito 
			echo -e "Funzionato? Non ti serviva e vuoi specificare un altro numero di file? Scrivi quanti sono e premi" 			
			read -p "Quanti sono i file da unire?" numero_file; lista="/home/subu/Desktop/1.pdf"; echo $numero_file;
	# leggo quanti sono i file da unire
	# con un ciclo for creo la stringa di input per il comando pdftk
	# con il numero di termini che mi serve

	
	# provo a cambiare il modo in cui è fatta la lista
	# da lista="$lista ${cont}.pdf" ; done 
	# a lista="$lista,${cont}.pdf" ; done 
			for (( cont=2 ; ${cont} < `expr $numero_file + 1`; cont=`expr $cont + 1` )) ; do  lista="$lista /home/subu/Desktop/${cont}.pdf" ; done 
	

			# for (( cont=1 ; ${cont} < `expr $numero_file + 1`; cont=`expr $cont + 1` )) ; do  lista="$lista ${cont}.pdf" ; done 

			echo $lista
			# chiedo una verifica all'utente che il numero di file sia giusto
			# se non lo è non fa nulla...
       			echo -e "\n Ecco l'elenco dei file che dovrei aver preparato nel mio desktop. \n" 
			read -p "Ok?" nume
			# vecchi comandi di unione
			# pdftk $lista cat output outputfile.pdf	       
			# pdftk /home/subu/Desktop/{$lista} cat output /home/subu/Desktop/outputfile.pdf	       
	
			# per ovviare ad problema se metto direttamente questo	 
			# pdftk /home/subu/Desktop/{$lista} cat output /home/subu/Desktop/outputfile.pdf	       
	 	
			# gianni="/home/subu/Desktop/"$lista" cat output /home/subu/Desktop/outputfile.pdf"
			gianni=" "$lista" cat output /home/subu/Desktop/outputfile.pdf"
	
			pdftk $gianni	       

			;;

		
		RU) # TIpo di rotazione	
			echo 'pdftk nome_file.pdf cat 1-endE output 411R.pdf'
			echo ' Tipo di rotazione: N -270; E -180; S -90; W 0'
			read -p "Che rotazione imprimere?" direzione;
			echo 'pdftk nome_file.pdf cat 1-end$direzione output 411R.pdf'
			;;




	esac ###  concludo la scelta generale dell'azione  case  dei pdf 

	read -p "Hai finito? (s/n)" finito
 	;;



# B = backup 
  B)
	echo "Stai per eseguire un backup"
	

echo "Ecco le opzioni 
a B - Barcelona (nuovo disco) 
a BCN - Barcelona 
a Ca - Catigliano
a Bo - Borgoricco?"

read -p "Dove sei ora?" luogo


		case "$luogo" in      #"BCN" "Ca" "Bo"; do

  		BCN)
        	echo "Stai fecendo il back up con l hard disk della Iomega 1,5 GB perché sei a $luogo = Barcellona"
		# back up a barcellona	
		# probleam con l'uso di && per unire comandi...
		# es. rsync -r -t -v --progress --modify-window=1 /media/Dati/{Burocrazia,lavori_extra_archivio,Documenti,Documenti_extra_archivio,lavori,lavori_extra_archivio,Photos} /media/ver_se/BK-incrementale/ && rsync -r -t -v --progress --modify-window=1 /media/Dati/Condivisa_VB /media/ver_se/BK-incrementale/  && rsync -r -t -v --progress --modify-window=1 /media/Linux/Photos_extra_archivio /media/ver_se/BK-incrementale/
		# scrivo singole righe... 

		rsync -r -t -v --progress --modify-window=1 /media/Dati/{Burocrazia,lavori_extra_archivio,Documenti,Documenti_extra_archivio,lavori,lavori_extra_archivio} /media/IO_Seguro/BK-incrementale/ 
		
		#,Photos   rimetti

		rsync -r -t -v --progress --modify-window=1 /media/Dati/Condivisa_VB /media/IO_Seguro/BK-incrementale/ 
		
		rsync -r -t -v --progress --modify-window=1 /media/Linux/Photos_extra_archivio /media/IO_Seguro/BK-incrementale/
        	;;



  		B)
        	echo "Stai fecendo il back up con l'hard disk della Wertern Digital 1 GB perché sei a $luogo = Barcellona."
		# back up a barcellona	
		rsync -r -t -v --progress --modify-window=1 /media/Dati/{Burocrazia,lavori_extra_archivio,Documenti,Documenti_extra_archivio,lavori,lavori_extra_archivio,Photos} /media/segur/BK-incrementale/ 
		rsync -r -t -v --progress --modify-window=1 /media/Dati/Condivisa_VB /media/segur/BK-incrementale/  
		# faccio il back up delle foto
		# funziona?     
		rsync -r -t -v --progress --modify-window=1 /media/Linux/Photos_extra_archivio /media/segur/BK-incrementale/ 
        	
                #  anche dei software...
		rsync -r -t -v --progress --modify-window=1 /media/Linux/software  /media/adema/
		;;

 		 Ca)
	echo "Stai fecendo il back up con l'hard disk della Verbatin di 1 GB perché sei a $luogo = Cartigliano"
		# back up dei lavori
rsync -r -t -v --progress --modify-window=1 /media/Dati/{Burocrazia,lavori_extra_archivio,Documenti,Documenti_extra_archivio,lavori,lavori_extra_archivio,Photos} /media/ver_se/BK-incrementale/ && rsync -r -t -v --progress --modify-window=1 /media/Dati/Condivisa_VB /media/ver_se/BK-incrementale/  && rsync -r -t -v --progress --modify-window=1 /media/Linux/Photos_extra_archivio /media/ver_se/BK-incrementale/

        	# echo "Stai fecendo il back up con l hard disk della Verbatin di 1 GB perché sei a $luogo"
# rsync -r -t -v --progress --modify-window=1 /media/Dati/{Burocrazia,lavori_extra_archivio,Documenti,Documenti_extra_archivio,lavori,lavori_extra_archivio,Photos,Photos_extra_archivio} /media/seguro/BK-incrementale/ && rsync -r -t -v --progress --modify-window=1 /media/Dati/Condivisa_VB /media/seguro/BK-incrementale/
		

## // rsync -r -t -v --progress --modify-window=1 /media/Dati/Burocrazia /media/ver_se/BK-incrementale/ && rsync -r -t -v --progress --modify-window=1 /media/Dati/Condivisa_VB /media/ver_se/BK-incrementale/ &&  rsync -r -t -v --progress --modify-window=1 /media/Dati/Documenti /media/ver_se/BK-incrementale/ && rsync -r -t -v --progress --modify-window=1 /media/Dati/lavori /media/ver_se/BK-incrementale/ && rsync -r -t -v --progress --modify-window=1 /media/Dati/Photos /media/ver_se/BK-incrementale/
        	
#  anche dei software...
		rsync -r -t -v --progress --modify-window=1 /media/Linux/software  /media/ver_ad/
                ;;
  		
                Bo)
       		echo "Inizia il Back Up a $luogo nell'HD da 1 TB"
		# back up dei lavori
		rsync -r -t -v --progress --modify-window=1 /media/Dati/{Burocrazia,lavori_extra_archivio} /media/seguro/BK-incrementale/ 
		rsync -r -t -v --progress --modify-window=1 /media/Dati/Condivisa_VB /media/seguro/BK-incrementale/ 
		rsync -r -t -v --progress --modify-window=1 /media/Dati/Documenti /media/seguro/BK-incrementale/ 
		rsync -r -t -v --progress --modify-window=1 /media/Dati/lavori /media/seguro/BK-incrementale/ 
		rsync -r -t -v --progress --modify-window=1 /media/Dati/Photos /media/seguro/BK-incrementale/        

		#  anche dei software...
		rsync -r -t -v --progress --modify-window=1 /media/Linux/software  /media/ademas/
         	;;
  		*)
		echo "Scelta non supportata, controlla di aver scritto bene"
		;;
		esac

read -p "Hai finito? (s/n)" finito
 	;;

# C = cerca file 
  C)
     
	echo "
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°° CERCARE UN FILE con contenuto noto °°°°°°°°°°°°°°°°°° 
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

echo "Il comando generale grep ha questa forma"
echo "(se cerchi una stringa all'interno di un file:
	grep -r -i \"some string\" /home/yourusername"



termina_ricerca="no";

while [[ $termina_ricerca = "no" ]] 
do #inizio il ciclo while

# specifico il contenuto ed il percorso
read -p "Qual è il contenuto della stringa? (senza apici)" contenuto_del_file; 
echo $contenuto_del_file;


read -p "In che cartelle cercare? (esempio /home/subu/Desktop/LINK/Documenti/case)     " percorso_della_cartella; 
echo $percorso_della_cartella;

echo -e "\nInizia la ricerca\n";
echo -e "\nSto cercando con questo comando\n grep -r -i" $contenuto_del_file $percorso_della_cartella;


#eseguo la ricerca
echo -e "\nIl risultato della ricerca \nda te richiesta \n";
grep -r -i "$contenuto_del_file" $percorso_della_cartella; 


echo -e "\n\n\nHai trovato quello che cercavi?"

read -p "[no per una nuova ricerca; qualsiasi altro carattere per uscire]" termina_ricerca;

done #termina il ciclo while
	;;


  *)
	echo "Scelta non supportata, controlla di aver scritto bene la tua scelta"
	## qua non metto la domanda  "Hai finito?"
	## perché se ho aperto il programma, qualche cosa la volevo fare di sicuro :D	
	;;
esac ###  concludo la scelta generale dell'azione  case  principale


	read -p "Hai finito? Scrivi (s/n) " finito 	

done  ###  concludo il ciclo la scelta generale dell'azione   //  ciclo = 0;




# log MODIFICHE
# {20130606} aggiornata la posizione di Photos_extra_archivio in B 


