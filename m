Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X4tbA-00077D-RB
 for kexec@lists.infradead.org; Wed, 09 Jul 2014 15:15:59 +0000
Subject: [PATCH 00/17] KEYS: PKCS#7 and PE file signature checking for kexec
From: David Howells <dhowells@redhat.com>
Date: Wed, 09 Jul 2014 16:15:25 +0100
Message-ID: <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: keyrings@linux-nfs.org
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org


Here's a set of patches that implements signature checking on PKCS#7 message
and PE files in the kernel.

The intention is to use the PE file signature checker to validate binaries
passed to kexec().  This signature in a PE file involves a PKCS#7 message.  The
code attempts to follow the certificate chain back to a ring of public keys
in the kernel.

The PKCS#7 patches provide the following facility:

 (1) Parse an ASN.1 PKCS#7 message and pick out useful bits such as the data
     content and the X.509 certificates used to sign it and all the data
     signatures.

 (2) Verify all the data signatures against the set of X.509 certificates
     available in the message.

 (3) Follow the certificate chains and verify that:

     (a) for every self-signed X.509 certificate, check that it validly signed
     	 itself, and:

     (b) for every non-self-signed certificate, if we have a 'parent'
     	 certificate, the former is validly signed by the latter.

 (4) Look for intersections between the certificate chains and the trusted
     keyring, if any intersections are found, verify that the trusted
     certificates signed the intersection point in the chain.

 (5) For testing purposes, a key type can be made available that will take a
     PKCS#7 message, check that the message is trustworthy, and if so, add its
     data content into the key.

The commits can be found on this branch also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-modsign.git/log/?h=pkcs7

and are tagged with:

	keys-pkcs7-20140708

The PE file patches provide the following facility:

 (1) Extract the signature from the PE file.  This is a PKCS#7 message
     containing, as its data, a hash of the signed parts of the file.

 (2) Digest the signed parts of the file.

 (3) Compare the digest with the one from the PKCS#7 message.

 (4) Verify that the PKCS#7 message intersects with the keys in the keyring.

The commits can be found on this branch also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-modsign.git/log/?h=pefile

and are tagged with:

	keys-pefile-20140709

David
---
David Howells (16):
      X.509: Add bits needed for PKCS#7
      X.509: Export certificate parse and free functions
      PKCS#7: Implement a parser [RFC 2315]
      PKCS#7: Digest the data in a signed-data message
      PKCS#7: Find the right key in the PKCS#7 key list and verify the signature
      PKCS#7: Verify internal certificate chain
      PKCS#7: Find intersection between PKCS#7 message and known, trusted keys
      PKCS#7: Provide a key type for testing PKCS#7
      KEYS: X.509: Fix a spelling mistake
      Provide PE binary definitions
      pefile: Parse a PE binary to find a key and a signature contained therein
      pefile: Strip the wrapper off of the cert data block
      pefile: Parse the presumed PKCS#7 content of the certificate blob
      pefile: Parse the "Microsoft individual code signing" data blob
      pefile: Digest the PE binary and compare to the PKCS#7 data
      pefile: Validate PKCS#7 trust chain

Vivek Goyal (1):
      pefile: Handle pesign using the wrong OID


 crypto/asymmetric_keys/Kconfig            |   33 ++
 crypto/asymmetric_keys/Makefile           |   37 ++
 crypto/asymmetric_keys/mscode.asn1        |   28 ++
 crypto/asymmetric_keys/mscode_parser.c    |  126 ++++++++
 crypto/asymmetric_keys/pkcs7.asn1         |  127 ++++++++
 crypto/asymmetric_keys/pkcs7_key_type.c   |   97 ++++++
 crypto/asymmetric_keys/pkcs7_parser.c     |  396 +++++++++++++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.h     |   61 ++++
 crypto/asymmetric_keys/pkcs7_trust.c      |  219 ++++++++++++++
 crypto/asymmetric_keys/pkcs7_verify.c     |  323 ++++++++++++++++++++
 crypto/asymmetric_keys/verify_pefile.c    |  457 +++++++++++++++++++++++++++++
 crypto/asymmetric_keys/verify_pefile.h    |   42 +++
 crypto/asymmetric_keys/x509.asn1          |    2 
 crypto/asymmetric_keys/x509_cert_parser.c |   20 +
 crypto/asymmetric_keys/x509_parser.h      |   13 +
 include/crypto/pkcs7.h                    |   36 ++
 include/linux/oid_registry.h              |    8 -
 include/linux/pe.h                        |  448 ++++++++++++++++++++++++++++
 include/linux/verify_pefile.h             |   18 +
 19 files changed, 2487 insertions(+), 4 deletions(-)
 create mode 100644 crypto/asymmetric_keys/mscode.asn1
 create mode 100644 crypto/asymmetric_keys/mscode_parser.c
 create mode 100644 crypto/asymmetric_keys/pkcs7.asn1
 create mode 100644 crypto/asymmetric_keys/pkcs7_key_type.c
 create mode 100644 crypto/asymmetric_keys/pkcs7_parser.c
 create mode 100644 crypto/asymmetric_keys/pkcs7_parser.h
 create mode 100644 crypto/asymmetric_keys/pkcs7_trust.c
 create mode 100644 crypto/asymmetric_keys/pkcs7_verify.c
 create mode 100644 crypto/asymmetric_keys/verify_pefile.c
 create mode 100644 crypto/asymmetric_keys/verify_pefile.h
 create mode 100644 include/crypto/pkcs7.h
 create mode 100644 include/linux/pe.h
 create mode 100644 include/linux/verify_pefile.h


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
