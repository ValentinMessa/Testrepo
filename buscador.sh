#!/bin/bash
RESULTADOS="resultados.txt"
PAGINAS="paginas.txt"
opcion=1
while [ $opcion != 6 ]; do
echo ""
echo "Las opciones son"
echo "Opcion 1: Agregar pagina"
echo "Opcion 2: Mostrar paginas"
echo "Opcion 3: Buscar palabra y analizar contenido"
echo "Opcion 4: Mostrar resultados de busqueda"
echo "Opcion 5: Limpieza y respaldo"
echo "Opcion 6: Salir"
read -p "Ingrese una opcion: " opcion
echo ""
    if [ "$opcion" -eq 1 ]; then
        read -p "Ingrese la URL de una pagina: " URL
	echo "$URL" >> paginas.txt
	echo "Url guardada en paginas.txt"
    elif [ "$opcion" -eq 2 ]; then
	echo "Las paginas son: "
        cat paginas.txt
    elif [ "$opcion" -eq 3 ]; then


read -p "Ingrese una palabra a buscar: " palabra

if [ -z "$palabra" ]; then
    echo "No se ingresó ninguna palabra."
else
    echo "Buscando la palabra '$palabra' en las páginas"
    while read -r url; do
   if [ -n "$url" ]; then
    contenido=$(curl -s "$url")
    cantidad=$(echo "$contenido" | grep -o -i "$palabra" | wc -l)
    echo "$palabra - $url - $cantidad" >> "$RESULTADOS"
    echo "$url → $cantidad coincidencias"
   fi
    done < "$PAGINAS"
    echo "Resultados guardados en $RESULTADOS"
fi

    elif [ "$opcion" -eq 4 ]; then
        read -p "Ingrese una palabra para ver los resultados: " palabra
	if grep -iq "$palabra" "$RESULTADOS"; then
	grep -i "$palabra" "$RESULTADOS"
	else
	echo "No se encontraron resultados de esa palabra"
	fi	

 
    elif [ "$opcion" -eq 5 ]; then
        fecha=$(date +%Y-%m-%d)
	cp "$RESULTADOS" "resultados_$fecha.txt" && : > "$RESULTADOS"
	cp "$PAGINAS" "paginas_$fecha.txt" && : > "$PAGINAS"
	echo "Copia creada del archivo paginas y resultados"
	echo "Contenido del archivo paginas y resultados eliminado"
    elif [ "$opcion" -eq 6 ]; then
        echo "Saliendo del sistema"
    else
        echo "Opcion invalida intentalo de nuevo"
    fi

done
