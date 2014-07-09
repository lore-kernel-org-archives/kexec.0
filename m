Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X4u1E-0003Mo-BQ
 for kexec@lists.infradead.org; Wed, 09 Jul 2014 15:42:52 +0000
Subject: [PATCH06/17] PKCS#7: Verify internal certificate chain
From: David Howells <dhowells@redhat.com>
Date: Wed, 09 Jul 2014 16:16:04 +0100
Message-ID: <20140709151604.23074.4848.stgit@warthog.procyon.org.uk>
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

Verify certificate chain in the X.509 certificates contained within the PKCS#7
message as far as possible.  If any signature that we should be able to verify
fails, we reject the whole lot.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

 crypto/asymmetric_keys/pkcs7_verify.c |   88 +++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+), 1 deletion(-)


diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 745e5c8..51ff36f 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -170,6 +170,91 @@ static int pkcs7_find_key(struct pkcs7_message *pkcs7,
 }
 
 /*
+ * Verify the internal certificate chain as best we can.
+ */
+static int pkcs7_verify_sig_chain(struct pkcs7_message *pkcs7,
+				  struct pkcs7_signed_info *sinfo)
+{
+	struct x509_certificate *x509 = sinfo->signer, *p;
+	int ret;
+
+	kenter("");
+
+	for (p = pkcs7->certs; p; p = p->next)
+		p->seen = false;
+
+	for (;;) {
+		pr_debug("verify %s: %s\n", x509->subject, x509->fingerprint);
+		x509->seen = true;
+		ret = x509_get_sig_params(x509);
+		if (ret < 0)
+			return ret;
+
+		if (x509->issuer)
+			pr_debug("- issuer %s\n", x509->issuer);
+		if (x509->authority)
+			pr_debug("- authkeyid %s\n", x509->authority);
+
+		if (!x509->authority ||
+		    (x509->subject &&
+		     strcmp(x509->subject, x509->issuer) == 0)) {
+			/* If there's no authority certificate specified, then
+			 * the certificate must be self-signed and is the root
+			 * of the chain.  Likewise if the cert is its own
+			 * authority.
+			 */
+			pr_debug("- no auth?\n");
+			if (x509->raw_subject_size != x509->raw_issuer_size ||
+			    memcmp(x509->raw_subject, x509->raw_issuer,
+				   x509->raw_issuer_size) != 0)
+				return 0;
+
+			ret = x509_check_signature(x509->pub, x509);
+			if (ret < 0)
+				return ret;
+			x509->signer = x509;
+			pr_debug("- self-signed\n");
+			return 0;
+		}
+
+		/* Look through the X.509 certificates in the PKCS#7 message's
+		 * list to see if the next one is there.
+		 */
+		pr_debug("- want %s\n", x509->authority);
+		for (p = pkcs7->certs; p; p = p->next) {
+			pr_debug("- cmp [%u] %s\n", p->index, p->fingerprint);
+			if (p->raw_subject_size == x509->raw_issuer_size &&
+			    strcmp(p->fingerprint, x509->authority) == 0 &&
+			    memcmp(p->raw_subject, x509->raw_issuer,
+				   x509->raw_issuer_size) == 0)
+				goto found_issuer;
+		}
+
+		/* We didn't find the root of this chain */
+		pr_debug("- top\n");
+		return 0;
+
+	found_issuer:
+		pr_debug("- issuer %s\n", p->subject);
+		if (p->seen) {
+			pr_warn("Sig %u: X.509 chain contains loop\n",
+				sinfo->index);
+			return 0;
+		}
+		ret = x509_check_signature(p->pub, x509);
+		if (ret < 0)
+			return ret;
+		x509->signer = p;
+		if (x509 == p) {
+			pr_debug("- self-signed\n");
+			return 0;
+		}
+		x509 = p;
+		might_sleep();
+	}
+}
+
+/*
  * Verify one signed information block from a PKCS#7 message.
  */
 static int pkcs7_verify_one(struct pkcs7_message *pkcs7,
@@ -201,7 +286,8 @@ static int pkcs7_verify_one(struct pkcs7_message *pkcs7,
 
 	pr_devel("Verified signature %u\n", sinfo->index);
 
-	return 0;
+	/* Verify the internal certificate chain */
+	return pkcs7_verify_sig_chain(pkcs7, sinfo);
 }
 
 /**


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
