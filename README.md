# cmsc133
code list for cmsc 133 computer architecture and organization; mips and c language

# Lab 1 Task One: integer_array_sum

Have	a	look	at	the	subroutine	integer_array_sum.	This	routine	should	iterate	through	a	set	of	numbers	
(words,	so	4	bytes	each)	and	add	them	up.	The	result	should	be	returned	to	the	caller.	Remember	that	
this	 is	 a	 subroutine	 (function)	 so	 you	 will	 have	 to	 obey	 the	MIPS	 calling	 convention	 in	 how	 you	 use	
registers!

As	you	can	see,	the	label	DBG	is	put	here.	If	we	use	it	as	a	breakpoint	we	can	run	up	to	this	point	in	the	
program	and	switch	to	stepping.

It's	 important	 to	 write	 good	 comments	 that	 describe	 your	 program.	 A	 common	 mistake	 is	 to	 write	
comments	 that	 do	 not	 add	 anything	 new.	 (E.g.,	 writing	 “i=i+4	 ;	 this	 line	 increments	 i	 by	 4”	 is	 not	
helpful.	Instead	you	should	write	“this	line	increments	the	index	for	the	string	array	to	the	next	letter.)

Your	comments	should	describe	what	your	code	is	doing	in	terms	of	the	problem	you	are	solving.
As	an	example	of	how	such	"good	comments"	may	look	like,	each	line	of	the	subroutine	already	have	
one	comment.	There	are	also	some	labels	defined to	help	you	insert	branches.	Giving	good	names	to	
labels	is	also	important	to	make	your	program	easy	to	understand	(and	debug).

Your	 first	 task	 is	 to	 translate	 each	 comment	 to	 one	 line	 of	 MIPS	 assembly.	 Finish	 the	 subroutine	
integer_array_sum
Make	sure	your	solution	allows	for	different	values	for	ARRAY_SIZE,	especially	the	case	ARRAY_SIZE	=	
0	is	interesting.

Hints

By	a	number,	we	mean	a	32	bit	number	(a	word).	An	array	is	a	sequence	of	such	numbers	stored	in	the	
data	segment.

If	you	look	at	the	top	of	the source	file	string_functions.s	you	will	see	how	ten	numbers	are	stored	in	
the	data	segment	using	the	directive	.word

By	means	of	the	label	FIBONACCI_ARRAY	we	can	refer	to	the	address	of	the	first	number	in	the	array	
later	in	our	code.	(E.g.,	wherever	you	use	FIBONACCI_ARRAY	in	your	code	it	will	be	replaced	with	the	
address	of	that	data.)

Since	 each	 number	 is	 a	 word	 (32	 bit	 long	 or	 4	 bytes),	 each	 number	 is	 four	 bytes	 apart.	 Hence	 the	
second	number	is	stored	at	the	address	given	by	the	following	calculation:	FIBONACCI_ARRAY	+	4.
The	 third	number	is	stored	at	address	FIBONACCI_ARRAY	+	 8. 

Therefore,	since	each	word	is	4	bytes	further	along	than	the	previous	one,	we	can	calculate	the	address of	 the	Nth	number	with	FIBONACCI_ARRAY+n*4. 
To	be	able	 to	sum	all	 the	numbers	in	 the	array	you	will	need	to	write	a	loop	that	loads	each	value	in	thearray	and	adds	them	up	into	a	register.

# Lab 1 Task Two: string_length

For	 this	 task	 you	 will	 write	 a	 subroutine	 that	 takes	 the	memory	 address	 of	 a	 string	 and	 returns	 the	
number	of	characters	in	that	string.

A	string	is	nothing	more	than	an	array	of	bytes	(8	bits,	or	1/4	of	a	word)	where	each	byte	encodes	one	
character using	the	ASCII	encoding.	To	mark	the	end	of	the	string,	the	special	ASCII-value	NULL	(0x00)	
is	used	to	terminate	the	string.

The	length	of	a	string	is	the	number	of	characters	before	the	terminating	NULL.	To	calculate	the	length	
of	 a	 string	 we	 can	 loop	 through	 the	 characters	 and	 keep	 count	 of	 the	 number	 of	 characters	 until	 a	
terminating	NULL	is	found.

Because	each	character	is	one	byte,	we	must	only	increase	the	address	by	1	byte	each	time	in	the	loop.	
Finish	the	subroutine	string_length	and	be	sure	to	include	clear	comments.

# Lab 1 Task Three: string_for_each

This	routine	will	take	the	memory	address	of	a	string	and	the	memory	address	of	another	subroutine.

It	will	the	go	through	every	letter	in	the	string	and	for	each	letter	call	the	subroutine.	We	will	use	this	to	 convert	every	 letter	 in	 the	 to	 upper	 case	 later	 by	 providing	 a	 string	 and	 a	 function	 that	 converts	letters	to	uppercase.
High	level	languages	can	take	a	string	and	print	out	each	character	on	a	separate	line.	

For	example,	the	string	"ABCabc"	would	be	print	out	as:
- Ascii('A')	=	65	(0x41)	
- Ascii('B')	=	66	(0x42)	
- Ascii('C')	=	67	(0x43)	
- Ascii('a')	=	97	(0x61)	
- Ascii('b')	=	98	(0x62)	
- Ascii('c')	=	99	(0x63)

We	would	like	to	have	something	similar	to	this	in	MIPS	assembly.
We	can	achieve	this	by	writing	a	subroutine	string_for_each	taking	the	address	to	a	string	as	the	first	
input	 parameter	 and	 the	 address	 to	 a	 callback	 subroutine	 as	 the	 second	 input	 parameter.	 The	
subroutine	 then	 loops	 through	 all	 characters	 in	 the	 string	 and	 for	 each	 character,	 calls	 the	 callback	
subroutine	with	the	address	of	the	characters	as	input.	In	pseudo	code	it	looks	like	this:

string_for_each(string,	callback)	{	for	each	character	in	string	{

callback(address_of(character))	}

}

Translating	this	to	MIPS	assembly,	the	input	to	the	callback,	the	address	to	a	character	is	put	in	the	$a0	
register.

In	 the	 source	 file	 string_functions.s	 there	 is	 a	 subroutine	 called	 “print_test_string”	 that	 takes	 an	
address	to	a	character	in	memory	and	writes	out	the	ASCII	value	as	shown	above.	(E.g.,	“Ascii(‘A’)	=	65	
(0x41)”	if	we	give	it	the	address	of	the	value	‘A’.)

Your	task	is	to	complete	the	subroutine	string_for_each.	When	you’re	done,	the	main	program	should	
be	 able	 to	 write	 out	 all	 the	 ASCII	 values	 in	 the	 string	 correctly.	 Be	 sure	 to	 test	 with	 various	 strings,	
especially	the	empty	string	"".	You	can	test	with	different	strings	by	either	modifying	the	string	used	by	
the	main	subroutine	or	by	creating	your	own	strings.

# Lab 1 Task Four: to_upper

Here	you	will	write	a	subroutine	that	takes	an	address	to	a	letter,	determines	the	upper	case	version	of	
that	letter,	and	stores	it	back	into	the	same	memory	location.	(E.g.,	it	changes	the	data	in	memory	to	
uppercase.)	 We	 will	 then	 use	 this	 in	 the	 string_for_each	 subroutine	 to convert	 a	 whole	 string	 to	
uppercase.

HINT:	Have	a	look	at	the	ASCII	table	below...	What	is	the	difference	between	a	lower	case	'a'	and	the	
upper	case	'A'?	When	do	you	need	to	change	the	character	and	when	not?	(To	read	the	table,	you	can	
see	that	‘A’	=	0x41	and	‘a’	=	0x61.)

# Lab 1 Task Five: reverse_string

Write	a	subroutine	to	reverse	a	string.	When	given	a	string	such	as	“ABC”	as	input	it	should	produce	
“CBA”	as	the	output.

Write	 a	 new	 subroutine	 called	 “reverse_string” from	 scratch.	 This	 subroutine	 should	 modify	 the	
characters	in	the	original	memory	space	of	the	string	and	not	create	a	new	one.

Hint:	How	can	you	use	the	address	of	the	string	and	the	string_length	subroutine	you	already	wrote	to	
swap	the	first	and	last	letters?	Can	you	then	write	a	loop	that	on	the	next	iteration	swaps	the	2nd	and	
2nd-to-last	letters?	When	would	this	loop	end?	What	about	even-length	and	odd-length	strings?
You	will	need	to	add	new	code	to	“main”	to	print	out	the	results	on	the	console.

# Note:
- Skeleton file of string functions is named string_functions.s
- Compiled subroutines with main and data is named final_string_functions.s
