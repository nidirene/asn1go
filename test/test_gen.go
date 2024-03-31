package test

type Octet8 = []byte
type Octet4 = []byte
type Octet16 = []byte
type OctetTo16 = []byte
type Octet32 = []byte
type Octet1 = []byte
type Octet2 = []byte
type VersionType = []byte
type Iccid = []byte
type RemoteOpId = int64

var RemoteOpIdValInstallBoundProfilePackage RemoteOpId = 1

type TransactionId = []byte
type GetEuiccInfo1Request struct {
}
type EUICCInfo1 struct {
	Svn				VersionType		`asn1:"explicit,tag:2"`
	EuiccCiPKIdListForVerification	[]SubjectKeyIdentifier	`asn1:"explicit,tag:9"`
	EuiccCiPKIdListForSigning	[]SubjectKeyIdentifier	`asn1:"explicit,tag:10"`
}
type SubjectKeyIdentifier = []byte
