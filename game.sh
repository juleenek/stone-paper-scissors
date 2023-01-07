#!/bin/bash

######################################################
# name          : game.sh
# description   : Prosta gra "Kamień, papier, nożyce"
######################################################

USER_SCORE=0
COMPUTER_SCORE=0

choice_ask() {

    echo " "
    echo "  Wybierz swój ruch:"
    echo " "
    echo "  1. Kamień"
    echo "  2. Papier"
    echo "  3. Nozyce"
    echo " "
    read USER_CHOICE

}

validate_choice() {

    re='^[1-3]$'
    while ! [[ $USER_CHOICE =~ $re ]]; do
        echo "  Źle wprowadzone dane, wybierz jeszcze raz!"
        choice_ask
    done

}

number_to_string() {

    [ "$1" == "1" ] && printf "Kamień"
    [ "$1" == "2" ] && printf "Papier"
    [ "$1" == "3" ] && printf "Nożyce"

}

user_won() {

    echo
    echo "  Wygrana! Gratulacje!"
    echo
    USER_SCORE=$(($USER_SCORE + 1))

}

computer_won() {

    echo
    echo "  Komputer wygrał!"
    echo
    COMPUTER_SCORE=$((COMPUTER_SCORE + 1))

}

round() {

    local USER=$1
    local COMPUTER=$2
    
    [ "$COMPUTER" == "$USER" ] && echo "  Mamy remis!" && return
    
    if [ "$COMPUTER" == "Kamień" ]; then
        [ "$USER" == "Papier" ] && user_won || computer_won
    fi
    
    if [ "$COMPUTER" == "Papier" ]; then
        [ "$USER" == "Nożyce" ] && user_won || computer_won
    fi
    
    if [ "$COMPUTER" == "Nożyce" ]; then
        [ "$USER" == "Kamień" ] && user_won || computer_won
    fi
    
}

game_board() {
    echo " "
    echo " "
    echo "  ::::::::::::::::::::::::::::::"
    echo "          WYNIK KOŃCOWY         "
    echo "  ::::::::::::::::::::::::::::::"
    echo "          Twój wynik: $USER_SCORE "
    echo "       Wynik komputera: $COMPUTER_SCORE "
    echo "  ::::::::::::::::::::::::::::::"
    echo " "
    
    if [ $USER_SCORE -lt $COMPUTER_SCORE ]; then
        echo "        Wygrał komputer!"
    else
        echo "  Wygrana jest twoja! Gratulacje!"
    fi
}

while [ $(($USER_SCORE + $COMPUTER_SCORE)) -lt 3 ]; do

    choice_ask
    validate_choice
    COMPUTER_CHOICE=$(($RANDOM % 3 + 1))
    
    USER="$(number_to_string $USER_CHOICE)"
    COMPUTER="$(number_to_string $COMPUTER_CHOICE)"
    
    echo " "
    echo "  ============================"
    echo "    Twój wybór to: ${USER}"
    echo "    Wybór komputera to: ${COMPUTER}"
    echo "  ============================"
    echo " "
    
    round $USER $COMPUTER
done

game_board
