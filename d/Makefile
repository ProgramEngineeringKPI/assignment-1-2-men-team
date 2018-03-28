SRC=main.d
DMDFLAGS=-w -color -O -g
GDCFLAGS=-Wall -Wpedantic -Werror -O3
OFNAME=main

all: dmd

dmd:
	@dmd ${DMDFLAGS} ${SRC} -of=${OFNAME}

gdc:
	@gdc ${GDCFLAGS} ${SRC} -o ${OFNAME}

clean:
	@rm -f ${OFNAME} *.o ${ZIPNAME}
