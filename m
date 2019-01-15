Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLJD-0003Gn-H6
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 09:47:00 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH v2 2/2] kexec,
 KEYS: Make use of platform keyring for signature verify
Date: Tue, 15 Jan 2019 17:45:42 +0800
Message-Id: <20190115094542.17129-3-kasong@redhat.com>
In-Reply-To: <20190115094542.17129-1-kasong@redhat.com>
References: <20190115094542.17129-1-kasong@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: jwboyer@fedoraproject.org, Kairui Song <kasong@redhat.com>, ebiggers@google.com, dyoung@redhat.com, nayna@linux.ibm.com, kexec@lists.infradead.org, jmorris@namei.org, zohar@linux.ibm.com, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

With KEXEC_BZIMAGE_VERIFY_SIG enabled, kexec_file_load will need to
verify the kernel image. The image might be signed with third part keys,
and the keys could be stored in firmware, then got loaded into the
.platform keyring. Now we have a symbol .platform_trusted_keyring as the
reference to .platform keyring, this patch makes use if it and allow
kexec_file_load to verify the image against keys in .platform keyring.

This commit adds a VERIFY_USE_PLATFORM_KEYRING similar to previous
VERIFY_USE_SECONDARY_KEYRING indicating that verify_pkcs7_signature
should verify the signature using platform keyring. Also, decrease
the error message log level when verification failed with -ENOKEY,
so that if called tried multiple time with different keyring it
won't generate extra noises.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 15 ++++++++++++---
 certs/system_keyring.c            | 11 ++++++++++-
 include/linux/verification.h      |  3 +++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7d97e432cbbc..a06b04065bb1 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -534,9 +534,18 @@ static int bzImage64_cleanup(void *loader_data)
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	return verify_pefile_signature(kernel, kernel_len,
-				       VERIFY_USE_SECONDARY_KEYRING,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+	int ret;
+	ret = verify_pefile_signature(kernel, kernel_len,
+			VERIFY_USE_SECONDARY_KEYRING,
+			VERIFYING_KEXEC_PE_SIGNATURE);
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+	if (ret == -ENOKEY) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+				VERIFY_USE_PLATFORM_KEYRING,
+				VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+#endif
+	return ret;
 }
 #endif
 
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 4690ef9cda8a..df2a09599bd8 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -239,12 +239,21 @@ int verify_pkcs7_signature(const void *data, size_t len,
 		trusted_keys = secondary_trusted_keys;
 #else
 		trusted_keys = builtin_trusted_keys;
+#endif
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
+		trusted_keys = platform_trusted_keys;
+		if (!trusted_keys) {
+			ret = -ENOKEY;
+			pr_devel("PKCS#7 platform keyring is not available\n");
+			goto error;
+		}
 #endif
 	}
 	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
 	if (ret < 0) {
 		if (ret == -ENOKEY)
-			pr_err("PKCS#7 signature not signed with a trusted key\n");
+			pr_devel("PKCS#7 signature not signed with a trusted key\n");
 		goto error;
 	}
 
diff --git a/include/linux/verification.h b/include/linux/verification.h
index cfa4730d607a..dbd1686e9bc4 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -17,6 +17,9 @@
  * should be used.
  */
 #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+#define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
+#endif
 
 /*
  * The use to which an asymmetric key is being put.
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
