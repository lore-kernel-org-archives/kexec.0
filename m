Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqJ5t-008R0J-OU
 for kexec@lists.infradead.org; Thu, 25 Nov 2021 18:03:42 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v2 5/6] module: Use key_being_used_for for log messages in
 verify_appended_signature
Date: Thu, 25 Nov 2021 19:02:43 +0100
Message-Id: <e454eb4f2f8dfe611b5da480a87519e5ad95a640.1637862358.git.msuchanek@suse.de>
In-Reply-To: <cover.1637862358.git.msuchanek@suse.de>
References: <cover.1637862358.git.msuchanek@suse.de>
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
To: keyrings@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>, kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, Paul Mackerras <paulus@samba.org>, Hari Bathini <hbathini@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Frank van der Linden <fllinden@amazon.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Sven Schnelle <svens@linux.ibm.com>, Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Add value for kexec appended signature and pass in key_being_used_for
enum rather than a string to verify_appended_signature to produce log
messages about the signature.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kexec/elf_64.c              |  2 +-
 arch/s390/kernel/machine_kexec_file.c    |  2 +-
 crypto/asymmetric_keys/asymmetric_type.c |  1 +
 include/linux/verification.h             |  3 ++-
 kernel/module.c                          |  3 ++-
 kernel/module_signing.c                  | 11 ++++++-----
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index 63634c95265d..3aa5269f6e0f 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -158,7 +158,7 @@ int elf64_verify_sig(const char *kernel, unsigned long length)
 	size_t kernel_len = length;
 
 	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
-					"kexec_file");
+					 VERIFYING_KEXEC_APPENDED_SIGNATURE);
 }
 #endif /* CONFIG_KEXEC_SIG */
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index c4632c1a1b59..316d082c9d99 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -33,7 +33,7 @@ int s390_verify_sig(const char *kernel, unsigned long length)
 		return 0;
 
 	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
-					"kexec_file");
+					VERIFYING_KEXEC_APPENDED_SIGNATURE);
 }
 #endif /* CONFIG_KEXEC_SIG */
 
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index ad8af3d70ac0..6fd20eec3882 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -25,6 +25,7 @@ const char *const key_being_used_for[NR__KEY_BEING_USED_FOR] = {
 	[VERIFYING_KEXEC_PE_SIGNATURE]		= "kexec PE sig",
 	[VERIFYING_KEY_SIGNATURE]		= "key sig",
 	[VERIFYING_KEY_SELF_SIGNATURE]		= "key self sig",
+	[VERIFYING_KEXEC_APPENDED_SIGNATURE]	= "kexec appended sig",
 	[VERIFYING_UNSPECIFIED_SIGNATURE]	= "unspec sig",
 };
 EXPORT_SYMBOL_GPL(key_being_used_for);
diff --git a/include/linux/verification.h b/include/linux/verification.h
index c1cf0582012a..23748feb9e03 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -26,6 +26,7 @@ enum key_being_used_for {
 	VERIFYING_KEXEC_PE_SIGNATURE,
 	VERIFYING_KEY_SIGNATURE,
 	VERIFYING_KEY_SELF_SIGNATURE,
+	VERIFYING_KEXEC_APPENDED_SIGNATURE,
 	VERIFYING_UNSPECIFIED_SIGNATURE,
 	NR__KEY_BEING_USED_FOR
 };
@@ -61,7 +62,7 @@ extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
 #endif
 
 int verify_appended_signature(const void *data, size_t *len, struct key *trusted_keys,
-			      const char *what);
+			      enum key_being_used_for purpose);
 
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 #endif /* _LINUX_VERIFY_PEFILE_H */
diff --git a/kernel/module.c b/kernel/module.c
index d91ca0f93a40..0a359dc6b690 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2891,7 +2891,8 @@ static int module_sig_check(struct load_info *info, int flags)
 	 */
 	if (flags == 0) {
 		err = verify_appended_signature(mod, &info->len,
-						VERIFY_USE_SECONDARY_KEYRING, "module");
+						VERIFY_USE_SECONDARY_KEYRING,
+						VERIFYING_MODULE_SIGNATURE);
 		if (!err) {
 			info->sig_ok = true;
 			return 0;
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 4c28cb55275f..cef72a6f6b5d 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -19,17 +19,18 @@
  * @data: The data to be verified
  * @len: Size of @data.
  * @trusted_keys: Keyring to use for verification
- * @what: Informational string for log messages
+ * @purpose: The use to which the key is being put
  */
 int verify_appended_signature(const void *data, size_t *len,
-			      struct key *trusted_keys, const char *what)
+			      struct key *trusted_keys,
+			      enum key_being_used_for purpose)
 {
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature ms;
 	size_t sig_len, modlen = *len;
 	int ret;
 
-	pr_devel("==>%s(,%zu)\n", __func__, modlen);
+	pr_devel("==>%s %s(,%zu)\n", __func__, key_being_used_for[purpose], modlen);
 
 	if (markerlen > modlen)
 		return -ENODATA;
@@ -44,7 +45,7 @@ int verify_appended_signature(const void *data, size_t *len,
 
 	memcpy(&ms, data + (modlen - sizeof(ms)), sizeof(ms));
 
-	ret = mod_check_sig(&ms, modlen, what);
+	ret = mod_check_sig(&ms, modlen, key_being_used_for[purpose]);
 	if (ret)
 		return ret;
 
@@ -54,6 +55,6 @@ int verify_appended_signature(const void *data, size_t *len,
 
 	return verify_pkcs7_signature(data, modlen, data + modlen, sig_len,
 				      trusted_keys,
-				      VERIFYING_MODULE_SIGNATURE,
+				      purpose,
 				      NULL, NULL);
 }
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
