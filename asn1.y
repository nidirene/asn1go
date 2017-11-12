// header
%{
package asn1go

import (
    "fmt"
)
%}
////////////////////////////
//  declarations section
//

// extra SymType fields
%union{
    name         string
    numberRepr   string

    Number       Number
    Real         Real
    TagDefault int
    ExtensionDefault bool
    ModuleIdentifier ModuleIdentifier
    DefinitiveObjIdComponent DefinitiveObjIdComponent
    DefinitiveObjIdComponentList []DefinitiveObjIdComponent
    DefinitiveIdentifier DefinitiveIdentifier
    Type Type
    ObjIdComponents ObjIdComponents
    DefinedValue DefinedValue
    ObjectIdentifierValue ObjectIdentifierValue
    Value Value
    Assignment Assignment
    AssignmentList AssignmentList
    ModuleBody ModuleBody
    ValueReference ValueReference
    TypeReference TypeReference
    Constraint Constraint
    ConstraintSpec ConstraintSpec
    ElementSetSpec ElementSetSpec
    Unions Unions
    Intersections Intersections
    IntersectionElements IntersectionElements
    Exclusions Exclusions
    Elements Elements
    SubtypeConstraint SubtypeConstraint
    RangeEndpoint RangeEndpoint
}

%token WHITESPACE
%token NEWLINE
%token <name> TYPEORMODULEREFERENCE
%token <name> VALUEIDENTIFIER
%token <Number> NUMBER
%token <bstring> BSTRING          // TODO not implemented in lexer
%token <bstring> XMLBSTRING       // TODO not implemented in lexer
%token <hstring> HSTRING          // TODO not implemented in lexer
%token <hstring> XMLHSTRING       // TODO not implemented in lexer
%token <cstring> CSTRING          // TODO not implemented in lexer
%token <cstring> XMLCSTRING       // TODO not implemented in lexer
%token ASSIGNMENT
%token RANGE_SEPARATOR
%token ELLIPSIS
%token LEFT_VERSION_BRACKETS
%token RIGHT_VERSION_BRACKETS
%token XML_END_TAG_START    // TODO not implemented in lexer
%token XML_SINGLE_START_END // TODO not implemented in lexer
%token XML_BOOLEAN_TRUE     // TODO not implemented in lexer
%token XML_BOOLEAN_FALSE    // TODO not implemented in lexer
%token XMLASN1TYPENAME      // TODO not implemented in lexer

// single-symbol tokens
%token OPEN_CURLY  // "{"
%token CLOSE_CURLY  // "}"
%token LESS  // "<"
%token GREATER  // ">"
%token COMMA  // ","
%token DOT  // "."
%token OPEN_ROUND  // "("
%token CLOSE_ROUND  // ")"
%token OPEN_SQUARE  // "["
%token CLOSE_SQUARE  // "]"
%token MINUS  // "-" (HYPEN-MINUS)
%token COLON  // ":"
%token EQUALS  // "="
%token QUOTATION_MARK  // """ (QUOTATION MARK)
%token APOSTROPHE  // "'" (APOSTROPHE)
%token SPACE  // " " (SPACE)  // TODO won't be parsed probably
%token SEMICOLON  // ";"
%token AT  // "@"
%token PIPE  // "|"
%token EXCLAMATION  // "!"
%token CARET  // "^"

// reserved words
%token ABSENT
%token ENCODED
%token INTEGER
%token RELATIVE_OID
%token ABSTRACT_SYNTAX
%token END
%token INTERSECTION
%token SEQUENCE
%token ALL
%token ENUMERATED
%token ISO646String
%token SET
%token APPLICATION
%token EXCEPT
%token MAX
%token SIZE
%token AUTOMATIC
%token EXPLICIT
%token MIN
%token STRING
%token BEGIN
%token EXPORTS
%token MINUS_INFINITY
%token SYNTAX
%token BIT
%token EXTENSIBILITY
%token NULL
%token T61String
%token BMPString
%token EXTERNAL
%token NumericString
%token TAGS
%token BOOLEAN
%token FALSE
%token OBJECT
%token TeletexString
%token BY
%token FROM
%token ObjectDescriptor
%token TRUE
%token CHARACTER
%token GeneralizedTime
%token OCTET
%token TYPE_IDENTIFIER
%token CHOICE
%token GeneralString
%token OF
%token UNION
%token CLASS
%token GraphicString
%token OPTIONAL
%token UNIQUE
%token COMPONENT
%token IA5String
%token PATTERN
%token UNIVERSAL
%token COMPONENTS
%token IDENTIFIER
%token PDV
%token UniversalString
%token CONSTRAINED
%token IMPLICIT
%token PLUS_INFINITY
%token UTCTime
%token CONTAINING
%token IMPLIED
%token PRESENT
%token UTF8String
%token DEFAULT
%token IMPORTS
%token PrintableString
%token VideotexString
%token DEFINITIONS
%token INCLUDES
%token PRIVATE
%token VisibleString
%token EMBEDDED
%token INSTANCE
%token REAL
%token WITH

%type <Real> realnumber
%type <Number> SignedExponent

%type <name> modulereference
%type <TypeReference> typereference
%type <name> identifier
%type <ExtensionDefault> ExtensionDefault
%type <TagDefault> TagDefault
%type <ModuleIdentifier> ModuleIdentifier
%type <DefinitiveObjIdComponent> DefinitiveObjIdComponent
%type <Number> DefinitiveNumberForm
%type <DefinitiveObjIdComponentList> DefinitiveObjIdComponentList
%type <DefinitiveObjIdComponent> DefinitiveNameAndNumberForm
%type <DefinitiveIdentifier> DefinitiveIdentifier
%type <name> NameForm
%type <DefinedValue> DefinedValue
%type <Type> ObjectIdentifierType
%type <Type> IntegerType
%type <Type> BooleanType
%type <Type> BuiltinType
%type <Type> Type
%type <ObjIdComponents> ObjIdComponents
%type <ObjIdComponents> NumberForm
%type <ObjIdComponents> NameAndNumberForm
%type <ObjectIdentifierValue> ObjIdComponentsList
%type <ObjectIdentifierValue> ObjectIdentifierValue
%type <Value> BuiltinValue
%type <Value> Value
%type <Value> IntegerValue
%type <Number> SignedNumber
%type <Assignment> Assignment
%type <Assignment> ValueAssignment
%type <Assignment> TypeAssignment
%type <AssignmentList> AssignmentList
%type <ModuleBody> ModuleBody
%type <ValueReference> valuereference
%type <Type> ConstrainedType
%type <Constraint> Constraint
%type <ConstraintSpec> ConstraintSpec
%type <SubtypeConstraint> SubtypeConstraint
%type <SubtypeConstraint> ElementSetSpecs
%type <SubtypeConstraint> RootElementSetSpec
%type <ElementSetSpec> AdditionalElementSetSpec
%type <ElementSetSpec> ElementSetSpec
%type <Unions> Unions
%type <Unions> UElems
%type <Intersections> Intersections
%type <Intersections> IElems
%type <IntersectionElements> IntersectionElements
%type <Exclusions> Exclusions
%type <Elements> Elements
%type <Elements> Elems
%type <Elements> SingleValue
%type <Elements> ValueRange
%type <Elements> SubtypeElements
%type <RangeEndpoint> LowerEndpoint UpperEndpoint
%type <Value> LowerEndValue UpperEndValue


//
// end declarations
////////////////////////////

%%

////////////////////////////
// grammar/rules section
//

// Code inside the grammar actions may refer to the variable yylex,
// which holds the yyLexer passed to yyParse.

ModuleDefinition :
    ModuleIdentifier
    DEFINITIONS
    TagDefault
    ExtensionDefault
    ASSIGNMENT
    BEGIN
    ModuleBody
    END
    { yylex.(*MyLexer).result = &ModuleDefinition{ModuleIdentifier: $1, TagDefault: $3, ExtensibilityImplied: $4, ModuleBody: $7} }
;

typereference: TYPEORMODULEREFERENCE  { $$ = TypeReference($1) }
;

modulereference: TYPEORMODULEREFERENCE;

valuereference: VALUEIDENTIFIER  {  $$ = ValueReference($1)  }
;

identifier: VALUEIDENTIFIER;

ModuleIdentifier :
                   modulereference
                   DefinitiveIdentifier
                   { $$ = ModuleIdentifier{Reference: $1, DefinitiveIdentifier: $2} }
;

DefinitiveIdentifier : OPEN_CURLY DefinitiveObjIdComponentList CLOSE_CURLY { $$ = DefinitiveIdentifier($2) }
                     | /*empty*/ { $$ = DefinitiveIdentifier(make([]DefinitiveObjIdComponent, 0)) }
;

DefinitiveObjIdComponentList :  DefinitiveObjIdComponent  { $$ = append(make([]DefinitiveObjIdComponent, 0), $1) }
                             | DefinitiveObjIdComponent DefinitiveObjIdComponentList  { $$ = append(append(make([]DefinitiveObjIdComponent, 0), $1), $2...) }
;

DefinitiveObjIdComponent : NameForm  { $$ = DefinitiveObjIdComponent{Name: $1} }
                         | DefinitiveNumberForm  { $$ = DefinitiveObjIdComponent{Id: $1.IntValue()} }
                         | DefinitiveNameAndNumberForm  { $$ = $1 }
;

DefinitiveNumberForm : NUMBER  { $$ = $1 }
;

DefinitiveNameAndNumberForm : identifier OPEN_ROUND DefinitiveNumberForm CLOSE_ROUND
                                { $$ = DefinitiveObjIdComponent{Name: $1, Id: $3.IntValue()}  }
;

TagDefault : EXPLICIT TAGS   { $$ = TAGS_EXPLICIT }
           | IMPLICIT TAGS   { $$ = TAGS_IMPLICIT }
           | AUTOMATIC TAGS  { $$ = TAGS_AUTOMATIC }
           | /*empty*/       { $$ = TAGS_EXPLICIT }
;

ExtensionDefault : EXTENSIBILITY IMPLIED { $$ = true }
                 | /*empty*/             { $$ = false }
;

ModuleBody : Exports Imports AssignmentList  { $$ = ModuleBody{AssignmentList: $3} }
           | /*empty*/  { $$ = ModuleBody{} }
;


Exports : EXPORTS SymbolsExported SEMICOLON
        | EXPORTS ALL SEMICOLON
        | /*empty*/
;

SymbolsExported : SymbolList
                | /*empty*/
;

Imports : IMPORTS SymbolsImported SEMICOLON
        | /*empty*/
;

SymbolsImported : SymbolsFromModuleList
                | /*empty*/
;

SymbolsFromModuleList : SymbolsFromModule
                      | SymbolsFromModuleList SymbolsFromModule
;

SymbolsFromModule : SymbolList FROM GlobalModuleReference
;

GlobalModuleReference : modulereference AssignedIdentifier
;

AssignedIdentifier : "t" "o" "d" "o"
//                     ObjectIdentifierValue
//                   | DefinedValue
//                   | /*empty*/
;

SymbolList : Symbol
           | SymbolList COMMA Symbol
;

Symbol : Reference
//       | ParameterizedReference
;

Reference : modulereference // modulereference
          | valuereference       // valuereference
//          | objectclassreference
//          | objectreference
//          | objectsetreference
;

AssignmentList : Assignment  { $$ = NewAssignmentList($1) }
               | AssignmentList Assignment  { $$ = $1.Append($2) }
;

Assignment : TypeAssignment
           | ValueAssignment
//           | XMLValueAssignment
//           | ValueSetTypeAssignment
//           | ObjectClassAssignment
//           | ObjectAssignment
//           | ObjectSetAssignment
//           | ParameterizedAssignment
;

// 13.3

DefinedValue : "t" "o" "d" "o"  { $$ = DefinedValue{} }
// ExternalValueReference
// | Valuereference
// | ParameterizedValue
//;

// 15.1

TypeAssignment : typereference ASSIGNMENT Type  { $$ = TypeAssignment{$1, $3} }
;

ValueAssignment : valuereference Type ASSIGNMENT Value  { $$ = ValueAssignment{$1, $2, $4} }
;

// 16.1

Type : BuiltinType
//     | ReferencedType
     | ConstrainedType
;

// 16.2

BuiltinType : //BitStringType
            /*|*/ BooleanType
//            | CharacterStringType
//            | ChoiceType
//            | EmbeddedPDVType
//            | EnumeratedType
//            | ExternalType
//            | InstanceOfType
            | IntegerType
//            | NullType
//            | ObjectClassFieldType
            | ObjectIdentifierType
//            | OctetStringType
//            | RealType
//            | RelativeOIDType
//            | SequenceType
//            | SequenceOfType
//            | SetType
//            | SetOfType
//            | TaggedType
;

// 16.7

Value : BuiltinValue
//      | ReferencedValue
//      | ObjectClassFieldValue
;

// 16.8

// TODO
BuiltinValue : // BitStringValue
//             | BooleanValue
//             | CharacterStringValue
//             | ChoiceValue
//             | EmbeddedPDVValue
//             | EnumeratedValue
//             | ExternalValue
//             | InstanceOfValue
             /*|*/ IntegerValue
//             | NullValue
               | ObjectIdentifierValue  { $$ = $1 }
//             | OctetStringValue
//             | RealValue
//             | RelativeOIDValue
//             | SequenceValue
//             | SequenceOfValue
//             | SetValue
//             | SetOfValue
//             | TaggedValue
;

// 17.3

BooleanType : BOOLEAN  { $$ = BooleanType{} }
;

BooleanValue : TRUE | FALSE
;

// 18.1

IntegerType : INTEGER  { $$ = IntegerType{} }
            | INTEGER OPEN_CURLY NamedNumberList CLOSE_CURLY  { $$ = IntegerType{} }    // TODO support NamedNumberList
;

NamedNumberList : NamedNumber
                | NamedNumberList COMMA NamedNumber
;

NamedNumber : identifier OPEN_ROUND SignedNumber CLOSE_ROUND
          | identifier OPEN_ROUND DefinedValue CLOSE_ROUND
;

SignedNumber : NUMBER  { $$ = $1 }
             | MINUS NUMBER  { $$ = $2.UnaryMinus() }
;

// 18.9

IntegerValue : SignedNumber  { $$ = $1 }
             | identifier  { $$ = IdentifiedIntegerValue{Name: $1} }
;

// 20.6

RealValue : NumericRealValue
          | SpecialRealValue
;

NumericRealValue : realnumber
                 | "-" realnumber
//                 | SequenceValue     // Value of the associated sequence type
;

SpecialRealValue : PLUS_INFINITY
                 | MINUS_INFINITY
;

// TODO this seem to be not strict enough (spaces can sneak in into composite value)
realnumber : NUMBER  { $$ = parseRealNumber($1, 0, 0) }
           | NUMBER DOT NUMBER  { $$ = parseRealNumber($1, $3, 0) }
           | NUMBER DOT NUMBER ExponentSymbol SignedExponent  { $$ = parseRealNumber($1, $3, $5) }
           | NUMBER ExponentSymbol SignedExponent  { $$ = parseRealNumber($1, 0, $3) }
;

ExponentSymbol : "e" | "E"
;

SignedExponent : NUMBER
               | MINUS NUMBER  { $$ = Number(-int($2)) }
;

// 31.1

ObjectIdentifierType : OBJECT IDENTIFIER  { $$ = ObjectIdentifierType{} }
;

// 31.3

ObjectIdentifierValue : OPEN_CURLY ObjIdComponentsList CLOSE_CURLY  { $$ = $2 }
                      | OPEN_CURLY DefinedValue ObjIdComponentsList CLOSE_CURLY  { $$ = NewObjectIdentifierValue($2).Append($3...) }
;

ObjIdComponentsList :  ObjIdComponents  { $$ = NewObjectIdentifierValue($1)  }
                    | ObjIdComponents ObjIdComponentsList  { $$ = NewObjectIdentifierValue($1).Append($2...)  }
;

ObjIdComponents : NameForm  { $$ = ObjectIdElement{Name: $1} }
                | NumberForm
                | NameAndNumberForm
                | DefinedValue  { $$ = $1 }
;

NumberForm : NUMBER   { $$ = ObjectIdElement{Id: $1.IntValue()} }
           | DefinedValue  { $$ = $1 }
;

NameAndNumberForm : identifier OPEN_ROUND NumberForm CLOSE_ROUND
    {
        switch v := $3.(type) {
        case DefinedValue:
            $$ = ObjectIdElement{Name: $1, Reference: &v}
        case ObjectIdElement:
            $$ = ObjectIdElement{Name: $1, Id: v.Id}
        default:
            panic(fmt.Sprintf("Expected DefinedValue or ObjectIdElement from NumberForm, got %v", $3))
        }
    }
;

NameForm : identifier
;

// 45.1

ConstrainedType : Type Constraint  { $$ = ConstraintedType{$1, $2} }
//                | TypeWithConstraint
;

// 45.6

Constraint : OPEN_ROUND ConstraintSpec ExceptionSpec CLOSE_ROUND  { $$ = Constraint{ConstraintSpec: $2} }
;

ConstraintSpec : SubtypeConstraint  { $$ = $1 }
//               | GeneralConstraint
;

SubtypeConstraint : ElementSetSpecs
;

// 46.1

ElementSetSpecs : RootElementSetSpec
                | RootElementSetSpec COMMA ELLIPSIS  { $$ = $1 }
                | RootElementSetSpec COMMA ELLIPSIS COMMA AdditionalElementSetSpec  { $$ = append($1, $5) }
;

RootElementSetSpec : ElementSetSpec  { $$ = SubtypeConstraint{$1} }
;

AdditionalElementSetSpec : ElementSetSpec
;

ElementSetSpec : Unions  { $$ = $1 }
               | ALL Exclusions  { $$ = $2 }
;

Unions : Intersections  { $$ = Unions{$1} }
       | UElems UnionMark Intersections    { $$ = append($1, $3) }
;

UElems : Unions
;

Intersections : IntersectionElements { $$ = Intersections{$1} }
              | IElems IntersectionMark IntersectionElements  { $$ = append($1, $3)  }
;

IElems : Intersections
;

IntersectionElements : Elements  { $$ = IntersectionElements{Elements: $1} }
                     | Elems Exclusions  { $$ = IntersectionElements{Elements: $1, Exclusions: $2} }
;

Elems : Elements
;

Exclusions : EXCEPT Elements  { $$ = Exclusions{$2} }
;

UnionMark : PIPE | UNION
;

IntersectionMark : CARET | INTERSECTION
;

Elements : SubtypeElements { $$ = $1 }
//         | ObjectSetElements
         | OPEN_ROUND ElementSetSpec CLOSE_ROUND  { $$ = $2 }
;

SubtypeElements : SingleValue
//                | ContainedSubtype
                | ValueRange
//                | PermittedAlphabet
//                | SizeConstraint
//                | TypeConstraint
//                | InnerTypeConstraints
//                | PatternConstraint
;

// 47.2

SingleValue : Value  { $$ = SingleValue{$1} }
;

// 47.4

ValueRange : LowerEndpoint RANGE_SEPARATOR UpperEndpoint  { $$ = ValueRange{$1, $3} }
;

LowerEndpoint : LowerEndValue  { $$ = RangeEndpoint{Value: $1} }
              | LowerEndValue LESS   { $$ = RangeEndpoint{Value: $1, IsOpen: true} }
;

UpperEndpoint : UpperEndValue  { $$ = RangeEndpoint{Value: $1} }
              | LESS UpperEndValue   { $$ = RangeEndpoint{Value: $2, IsOpen: true} }
;

LowerEndValue : Value
              | MIN  { $$ = nil }
;

UpperEndValue : Value
              | MAX  { $$ = nil }
;

// 49.4

ExceptionSpec : EXCLAMATION ExceptionIdentification
              | /* empty */
;

ExceptionIdentification : SignedNumber
                        | DefinedValue
                        | Type COLON Value
;

///// X.681

// 12.10

// ObjectSetElements ::=
//  Object
//  | DefinedObjectSet
//  | ObjectSetFromObjects
//  | ParameterizedObjectSet

//
// end grammar
////////////////////////////

%%