#!/bin/bash

# Ce script est un analyseur lexical qui prend en entrée un fichier source

# https://baptiste-wicht.developpez.com/tutoriels/java/mots-reserves/
keywords=( "abstract" "assert" "boolean" "break" "byte" "case" "catch" "char" "class" "const" "continue" "default" "do" "double" "else" "extends" "false" "final" "finally" "float" "for" "goto" "if" "implements" "import" "instanceof" "int" "interface" "long" "native" "new" "null" "package" "private" "protected" "public" "return" "short" "static" "strictfp" "super" "switch" "synchronized" "this" "throw" "throws" "transient" "true" "try" "void" "volatile" "while" )
types=( "boolean" "byte" "char" "double" "float" "int" "long" "short" "void" )
operators=( "+" "-" "*" "/" "=" "==" "!=" "<" "<=" ">" ">=" "&&" "||" "!" )
separators=( "(" ")" "{" "}" ";" "," )

# Fonction qui vérifie si une chaine est présente dans un tableau
function isInArray {
    local array=$1[@]
    local word=$2
    for element in "${!array}"; do
        if [[ $element == $word ]]; then
            return 0
        fi
    done
    return 1
}

while read line
do
    line=$(echo $line | sed 's/;/ ;/g')
    # on découpe la ligne en mots
    for word in $line
    do
      if isInArray keywords $word; then
        echo "$word : mot clé"
      elif isInArray types $word; then
        echo "$word : type"
      elif isInArray operators $word; then
        echo "$word : opérateur"
      elif isInArray separators $word; then
        echo "$word : séparateur"
      elif [[ $word =~ ^[0-9]+$ ]]; then
          echo "$word : entier"
      else
          echo "$word : identificateur"
      fi
    done
done < $1