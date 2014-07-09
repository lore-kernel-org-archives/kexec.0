Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X4tc1-0000MH-JG
 for kexec@lists.infradead.org; Wed, 09 Jul 2014 15:16:50 +0000
Subject: [PATCH09/17] KEYS: X.509: Fix a spelling mistake
From: David Howells <dhowells@redhat.com>
Date: Wed, 09 Jul 2014 16:16:23 +0100
Message-ID: <20140709151623.23074.80430.stgit@warthog.procyon.org.uk>
In-Reply-To: <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
References: <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
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

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---

 crypto/asymmetric_keys/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index b6df198..14cac28 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -33,7 +33,7 @@ config X509_CERTIFICATE_PARSER
 	select ASN1
 	select OID_REGISTRY
 	help
-	  This option procides support for parsing X.509 format blobs for key
+	  This option provides support for parsing X.509 format blobs for key
 	  data and provides the ability to instantiate a crypto key from a
 	  public key packet found inside the certificate.
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
