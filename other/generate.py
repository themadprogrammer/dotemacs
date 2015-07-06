#!/usr/bin/python
import sys
import clang.cindex as ci
import re
import argparse
import os
def createCppParameters( cursor ):
    params = []
    for c in cursor.get_children():
        params.append( c.type.spelling + " " + c.spelling)
    print ", ".join(params),
    
def createCppInitializers( class_cursor, cursor ):
    params = []
    fields = []
    output = []
    for c in class_cursor.get_children():
        if c.kind == ci.CursorKind.FIELD_DECL:
            fields.append(c.spelling )
    for c in cursor.get_children():
        params.append( c.spelling )
    for f in fields:
        match=re.match("m_(.*)",f)
        if match:
            look=match.group(1)
            if look in params:
                 output.append( f+"("+look+")" )
            else:
                output.append( f+"()" )
        else:
            output.append( f+"()" )
    print ", ".join( output ),

def createCppClass( cursor, name ):
    for c in cursor.get_children():
        if ( c.kind.is_declaration() ):
            if ( c.kind == ci.CursorKind.CONSTRUCTOR ):
                print "%s::%s(" % (name, name ),
                createCppParameters( c )
                print ")\n   : ",
                createCppInitializers( cursor, c )
                print "\n{\n}\n"
            if ( c.kind == ci.CursorKind.CXX_METHOD ):
                print '%s %s::%s(' % ( c.result_type.spelling , name, c.spelling  ),
                createCppParameters( c )
                print " )\n{\n}\n"
            if ( c.kind == ci.CursorKind.DESTRUCTOR ):
                print "%s::~%s()\n{\n}\n" % (name, name )

                
def createCppIter( cursor, file ):
    for c in cursor.get_children():
        if ( c.location.file.name == file ):
            if ( c.kind.is_declaration() ):
                if ( c.kind == ci.CursorKind.CLASS_DECL ):
                    if not re.match("Interface", c.spelling):
                        createCppClass( c, c.spelling)
                if ( c.kind == ci.CursorKind.NAMESPACE ):
                    print "namespace %s\n{\n" % ( c.spelling )
                    createCppIter(c, file)
                    print "} // namespace %s" % ( c.spelling )

def createCpp( cursor, file ):
    print "#include <%s>\n" % ( os.path.basename(file) )
    createCppIter(cursor, file )    
                    
def createTestIter( cursor, file):
    for c in cursor.get_children():
        if ( c.location.file.name == file ):
            if ( c.kind.is_declaration() ):
                if ( c.kind == ci.CursorKind.NAMESPACE ):
                    print "namespace %s\n{\n" % ( c.spelling )
                    createTestIter(c, file)
                    print "} // namespace %s" % ( c.spelling )

def createTest( cursor, file ):
    print "#include <%s>" % ( os.path.basename(file) )
    print "\n#include <gtest.h>\n#include <gmock.h>\n"
    createTestIter(cursor, file )

def main():
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('file', help='header file to process')
    parser.add_argument('--cpp', dest='cpp', action='store_true', default=False, help='generate cpp file')
    parser.add_argument('--test', dest='test', action='store_true', default=False, help='generate test file')
    args = parser.parse_args()
    file=args.file
    index = ci.Index.create()
    tu = index.parse(file, args=[ "-x", "c++" ] )
    cursor=tu.cursor
    if args.cpp:
        createCpp( cursor, file)
    if args.test:
        createTest( cursor, file)
    
if __name__ == "__main__":
    main()
