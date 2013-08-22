/******************************************************************************

    Although it compiled fine without it, Gavin Norman has suggested that
    to be properly valid D code the first non-comment line must be a module
    declaration... so here you go my anal friend! :)

******************************************************************************/

module challenge;

/******************************************************************************

    Here goes my struct check out the name reference homies...

******************************************************************************/

struct DShirt
{
    int I;
    uint am;
    long keeping;
    ulong it;
    bool bitches;
}

/******************************************************************************

    Define outer class (poor as fuck, it ain't got nothign but an inner class)

******************************************************************************/

class Outer
{

    /**************************************************************************

        Define the inner class (this foo got some shit though!)

    **************************************************************************/
    
    class Inner
    {

        /**********************************************************************

            Define a bunch of class properties to show I know how to use
            those later in the class methods; a bit of abstraction if you will.

        **********************************************************************/

        char[] words = "Let's use a struct to convey a message:\n";
        char[] props = "On the topic of my ";
        char[] types = "And now for those types:";
        char[] structName;

        /**********************************************************************

            Define the helper functions, I won't document them separately
            since they are pretty damn obvious, plus I don't even have time
            to actually be coding in D in the first place so this whole shit
            ist verrueckt!

        **********************************************************************/

        char[] formatProp( char[] myProperty )
        {
            int start               = structName.length + 3;
            char[] myFormattedProp  = myProperty[start..myProperty.length];
            myFormattedProp         = " " ~ myFormattedProp;

            return myFormattedProp;
        }

        char[] formatType( char[] myType )
        {
            char[] myFormattedType = " (" ~ myType ~ ")";

            return myFormattedType;
        }

        char[] printMyWords( T )()
        {
            static assert( is( T == struct ) );

            structName  = T.stringof;
            props       ~= structName ~ ":";

            foreach( index, value; typeof( T.tupleof ) )
            {
                props ~= formatProp( T.tupleof[index].stringof );
                types ~= formatType( value.stringof );
            }

            words ~= props ~ "!\n" ~ types;

            return words;
        }
    }
}

/******************************************************************************

    Define my 'compile time function evaluation' to allow instantialization
    of the outer and inner classes during compile time...

    @David: you are such a turd for this requirement!

******************************************************************************/

char[] cfte()
{
    Outer myOuter           = new Outer;
    myOuter.Inner myInner   = myOuter.new myOuter.Inner;
    
    return myInner.printMyWords!( DShirt );
}

/******************************************************************************

    Define this wack ass 'main' function to make the compiler happy...

******************************************************************************/

void main() {}

/******************************************************************************

    And, last but not least, my call to pragma for the compile time
    'msg' output...

******************************************************************************/

pragma( msg, cfte() );
