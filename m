Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XCr5G-0002EA-CI
 for kexec@lists.infradead.org; Thu, 31 Jul 2014 14:12:04 +0000
Subject: [PATCH] PKCS#7: issuer and subject are mandatory fields in the ASN.1
From: David Howells <dhowells@redhat.com>
Date: Thu, 31 Jul 2014 15:11:03 +0100
Message-ID: <20140731141103.16348.91901.stgit@warthog.procyon.org.uk>
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
To: dan.carpenter@oracle.com
Cc: keyrings@linux-nfs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, vgoyal@redhat.com

issuer and subject are mandatory fields in the ASN.1 and so their existence
needn't be tested for.  They are guaranteed to end up with an empty string if
the name material has nothing we can use (see x509_fabricate_name()).

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 51ff36f3a913..c62cf8006e1f 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -190,14 +190,12 @@ static int pkcs7_verify_sig_chain(struct pkcs7_message *pkcs7,
 		if (ret < 0)
 			return ret;
 
-		if (x509->issuer)
-			pr_debug("- issuer %s\n", x509->issuer);
+		pr_debug("- issuer %s\n", x509->issuer);
 		if (x509->authority)
 			pr_debug("- authkeyid %s\n", x509->authority);
 
 		if (!x509->authority ||
-		    (x509->subject &&
-		     strcmp(x509->subject, x509->issuer) == 0)) {
+		    strcmp(x509->subject, x509->issuer) == 0) {
 			/* If there's no authority certificate specified, then
 			 * the certificate must be self-signed and is the root
 			 * of the chain.  Likewise if the cert is its own


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
