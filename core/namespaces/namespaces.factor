! Copyright (C) 2003, 2010 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel vectors sequences hashtables
arrays kernel.private math strings assocs ;
IN: namespaces

<PRIVATE

: namestack* ( -- namestack ) 0 context-object { vector } declare ; inline
: >n ( namespace -- ) namestack* push ;
: ndrop ( -- ) namestack* pop* ;

PRIVATE>

: namespace ( -- namespace ) namestack* last ; inline
: namestack ( -- namestack ) namestack* clone ;
: set-namestack ( namestack -- ) >vector 0 set-context-object ;
: global ( -- g ) 21 special-object { hashtable } declare ; inline
: init-namespaces ( -- ) global 1array set-namestack ;
: get ( variable -- value ) namestack* assoc-stack ; inline
: set ( value variable -- ) namespace set-at ;
: on ( variable -- ) t swap set ; inline
: off ( variable -- ) f swap set ; inline
: get-global ( variable -- value ) global at ; inline
: set-global ( value variable -- ) global set-at ; inline
: change ( variable quot -- ) [ [ get ] keep ] dip dip set ; inline
: change-global ( variable quot -- ) [ global ] dip change-at ; inline
: toggle ( variable -- ) [ not ] change ; inline
: +@ ( n variable -- ) [ 0 or + ] change ; inline
: inc ( variable -- ) 1 swap +@ ; inline
: dec ( variable -- ) -1 swap +@ ; inline
: bind ( ns quot -- ) swap >n call ndrop ; inline
: counter ( variable -- n ) [ 0 or 1 + dup ] change-global ;
: make-assoc ( quot exemplar -- hash ) 20 swap new-assoc [ swap bind ] keep ; inline
: with-scope ( quot -- ) 5 <hashtable> swap bind ; inline
: with-variable ( value key quot -- ) [ associate ] dip bind ; inline
: with-global ( quot -- ) global swap bind ; inline
: initialize ( variable quot -- ) [ unless* ] curry change-global ; inline
