package tst

import "encoding/asn1"

type Attribute struct {
	Type	AttributeType
	Values	[]AttributeValue	`asn1:"set"`
}
type AttributeType = asn1.ObjectIdentifier
type AttributeValue = interface {
}
type AttributeTypeAndValue struct {
	Type	AttributeType
	Value	AttributeValue
}
type X520name = interface {
}
type X520CommonName = interface {
}
type X520LocalityName = interface {
}
type X520StateOrProvinceName = interface {
}
type X520OrganizationName = interface {
}
type X520OrganizationalUnitName = interface {
}
type X520Title = interface {
}
type X520dnQualifier = string
type X520countryName = string
type X520SerialNumber = string
type X520Pseudonym = interface {
}
type DomainComponent = string
type EmailAddress = string
type Name = RDNSequence
type RDNSequence = []RelativeDistinguishedName
type DistinguishedName = RDNSequence
type (
	RelativeDistinguishedNameSET	[]AttributeTypeAndValue
	RelativeDistinguishedName	= RelativeDistinguishedNameSET
)
type DirectoryString = interface {
}
type Certificate struct {
	TbsCertificate		TBSCertificate
	SignatureAlgorithm	AlgorithmIdentifier
	Signature		asn1.BitString
}
type TBSCertificate struct {
	Version			Version	`asn1:"optional,explicit,tag:0"`
	SerialNumber		CertificateSerialNumber
	Signature		AlgorithmIdentifier
	Issuer			Name
	Validity		Validity
	Subject			Name
	SubjectPublicKeyInfo	SubjectPublicKeyInfo
	IssuerUniqueID		asn1.BitString	`asn1:"optional,tag:1"`
	SubjectUniqueID		asn1.BitString	`asn1:"optional,tag:2"`
	Extensions		Extensions	`asn1:"optional,explicit,tag:3"`
}
type Version = int64

var (
	VersionValV1	Version	= 0
	VersionValV2	Version	= 1
	VersionValV3	Version	= 2
)

type CertificateSerialNumber = int64
type Validity struct {
	NotBefore	Time
	NotAfter	Time
}
type Time = interface {
}
type UniqueIdentifier = asn1.BitString
type SubjectPublicKeyInfo struct {
	Algorithm		AlgorithmIdentifier
	SubjectPublicKey	asn1.BitString
}
type Extensions = []Extension
type Extension struct {
	ExtnID		asn1.ObjectIdentifier
	Critical	bool	`asn1:"optional"`
	ExtnValue	[]byte
}
type CertificateList struct {
	TbsCertList		TBSCertList
	SignatureAlgorithm	AlgorithmIdentifier
	Signature		asn1.BitString
}
type TBSCertList struct {
	Version			Version	`asn1:"optional"`
	Signature		AlgorithmIdentifier
	Issuer			Name
	ThisUpdate		Time
	NextUpdate		Time	`asn1:"optional"`
	RevokedCertificates	[]struct {
		UserCertificate		CertificateSerialNumber
		RevocationDate		Time
		CrlEntryExtensions	Extensions	`asn1:"optional"`
	}	`asn1:"optional"`
	CrlExtensions	Extensions	`asn1:"optional,explicit,tag:0"`
}
type AlgorithmIdentifier struct {
	Algorithm	asn1.ObjectIdentifier
	Parameters	interface {
	}	`asn1:"optional"`
}
type ORAddress struct {
	Built_in_standard_attributes		BuiltInStandardAttributes
	Built_in_domain_defined_attributes	BuiltInDomainDefinedAttributes	`asn1:"optional"`
	Extension_attributes			ExtensionAttributes		`asn1:"optional"`
}
type BuiltInStandardAttributes struct {
	Country_name			CountryName			`asn1:"optional"`
	Administration_domain_name	AdministrationDomainName	`asn1:"optional"`
	Network_address			NetworkAddress			`asn1:"optional,tag:0"`
	Terminal_identifier		TerminalIdentifier		`asn1:"optional,tag:1"`
	Private_domain_name		PrivateDomainName		`asn1:"optional,explicit,tag:2"`
	Organization_name		OrganizationName		`asn1:"optional,tag:3"`
	Numeric_user_identifier		NumericUserIdentifier		`asn1:"optional,tag:4"`
	Personal_name			PersonalName			`asn1:"optional,tag:5"`
	Organizational_unit_names	OrganizationalUnitNames		`asn1:"optional,tag:6"`
}
type CountryName = interface {
}
type AdministrationDomainName = interface {
}
type NetworkAddress = X121Address
type X121Address = string
type TerminalIdentifier = string
type PrivateDomainName = interface {
}
type OrganizationName = string
type NumericUserIdentifier = string
type (
	PersonalNameSET	struct {
		Surname			string	`asn1:"tag:0"`
		Given_name		string	`asn1:"optional,tag:1"`
		Initials		string	`asn1:"optional,tag:2"`
		Generation_qualifier	string	`asn1:"optional,tag:3"`
	}
	PersonalName	= PersonalNameSET
)
type OrganizationalUnitNames = []OrganizationalUnitName
type OrganizationalUnitName = string
type BuiltInDomainDefinedAttributes = []BuiltInDomainDefinedAttribute
type BuiltInDomainDefinedAttribute struct {
	Type	string
	Value	string
}
type (
	ExtensionAttributesSET	[]ExtensionAttribute
	ExtensionAttributes	= ExtensionAttributesSET
)
type ExtensionAttribute struct {
	Extension_attribute_type	int64	`asn1:"tag:0"`
	Extension_attribute_value	interface {
	}	`asn1:"explicit,tag:1"`
}

var ValCommon_name int64 = 1

type CommonName = string

var ValTeletex_common_name int64 = 2

type TeletexCommonName = string

var ValTeletex_organization_name int64 = 3

type TeletexOrganizationName = string

var ValTeletex_personal_name int64 = 4

type (
	TeletexPersonalNameSET	struct {
		Surname			string	`asn1:"tag:0"`
		Given_name		string	`asn1:"optional,tag:1"`
		Initials		string	`asn1:"optional,tag:2"`
		Generation_qualifier	string	`asn1:"optional,tag:3"`
	}
	TeletexPersonalName	= TeletexPersonalNameSET
)

var ValTeletex_organizational_unit_names int64 = 5

type TeletexOrganizationalUnitNames = []TeletexOrganizationalUnitName
type TeletexOrganizationalUnitName = string

var ValPds_name int64 = 7

type PDSName = string

var ValPhysical_delivery_country_name int64 = 8

type PhysicalDeliveryCountryName = interface {
}

var ValPostal_code int64 = 9

type PostalCode = interface {
}

var ValPhysical_delivery_office_name int64 = 10

type PhysicalDeliveryOfficeName = PDSParameter

var ValPhysical_delivery_office_number int64 = 11

type PhysicalDeliveryOfficeNumber = PDSParameter

var ValExtension_OR_address_components int64 = 12

type ExtensionORAddressComponents = PDSParameter

var ValPhysical_delivery_personal_name int64 = 13

type PhysicalDeliveryPersonalName = PDSParameter

var ValPhysical_delivery_organization_name int64 = 14

type PhysicalDeliveryOrganizationName = PDSParameter

var ValExtension_physical_delivery_address_components int64 = 15

type ExtensionPhysicalDeliveryAddressComponents = PDSParameter

var ValUnformatted_postal_address int64 = 16

type (
	UnformattedPostalAddressSET	struct {
		Printable_address	[]string	`asn1:"optional"`
		Teletex_string		string		`asn1:"optional"`
	}
	UnformattedPostalAddress	= UnformattedPostalAddressSET
)

var ValStreet_address int64 = 17

type StreetAddress = PDSParameter

var ValPost_office_box_address int64 = 18

type PostOfficeBoxAddress = PDSParameter

var ValPoste_restante_address int64 = 19

type PosteRestanteAddress = PDSParameter

var ValUnique_postal_name int64 = 20

type UniquePostalName = PDSParameter

var ValLocal_postal_attributes int64 = 21

type LocalPostalAttributes = PDSParameter
type (
	PDSParameterSET	struct {
		Printable_string	string	`asn1:"optional"`
		Teletex_string		string	`asn1:"optional"`
	}
	PDSParameter	= PDSParameterSET
)

var ValExtended_network_address int64 = 22

type ExtendedNetworkAddress = asn1.RawValue
type PresentationAddress struct {
	PSelector	[]byte		`asn1:"optional,explicit,tag:0"`
	SSelector	[]byte		`asn1:"optional,explicit,tag:1"`
	TSelector	[]byte		`asn1:"optional,explicit,tag:2"`
	NAddresses	[][]byte	`asn1:"explicit,tag:3,set"`
}

var ValTerminal_type int64 = 23

type TerminalType = int64

var (
	TerminalTypeValTelex		TerminalType	= 3
	TerminalTypeValTeletex		TerminalType	= 4
	TerminalTypeValG3_facsimile	TerminalType	= 5
	TerminalTypeValG4_facsimile	TerminalType	= 6
	TerminalTypeValIa5_terminal	TerminalType	= 7
	TerminalTypeValVideotex		TerminalType	= 8
)
var ValTeletex_domain_defined_attributes int64 = 6

type TeletexDomainDefinedAttributes = []TeletexDomainDefinedAttribute
type TeletexDomainDefinedAttribute struct {
	Type	string
	Value	string
}

var ValUb_name int64 = 32768
var ValUb_common_name int64 = 64
var ValUb_locality_name int64 = 128
var ValUb_state_name int64 = 128
var ValUb_organization_name int64 = 64
var ValUb_organizational_unit_name int64 = 64
var ValUb_title int64 = 64
var ValUb_serial_number int64 = 64
var ValUb_match int64 = 128
var ValUb_emailaddress_length int64 = 128
var ValUb_common_name_length int64 = 64
var ValUb_country_name_alpha_length int64 = 2
var ValUb_country_name_numeric_length int64 = 3
var ValUb_domain_defined_attributes int64 = 4
var ValUb_domain_defined_attribute_type_length int64 = 8
var ValUb_domain_defined_attribute_value_length int64 = 128
var ValUb_domain_name_length int64 = 16
var ValUb_extension_attributes int64 = 256
var ValUb_e163_4_number_length int64 = 15
var ValUb_e163_4_sub_address_length int64 = 40
var ValUb_generation_qualifier_length int64 = 3
var ValUb_given_name_length int64 = 16
var ValUb_initials_length int64 = 5
var ValUb_integer_options int64 = 256
var ValUb_numeric_user_id_length int64 = 32
var ValUb_organization_name_length int64 = 64
var ValUb_organizational_unit_name_length int64 = 32
var ValUb_organizational_units int64 = 4
var ValUb_pds_name_length int64 = 16
var ValUb_pds_parameter_length int64 = 30
var ValUb_pds_physical_address_lines int64 = 6
var ValUb_postal_code_length int64 = 16
var ValUb_pseudonym int64 = 128
var ValUb_surname_length int64 = 40
var ValUb_terminal_id_length int64 = 24
var ValUb_unformatted_address_length int64 = 180
var ValUb_x121_address_length int64 = 16
