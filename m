From: Michal Suchanek <msuchanek@suse.de>
Date: Mon, 10 Jan 2022 14:49:56 +0100
Subject: [PATCH v4 4/6] module: strip the signature marker in the verification
 function.
In-Reply-To: <cover.1641822505.git.msuchanek@suse.de>
References: <cover.1641822505.git.msuchanek@suse.de>
Message-ID: <96d29773b9ef418a71b1d8bbfd0a456a0f996ec6.1641822505.git.msuchanek@suse.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

It is stripped by each caller separately.

Note: this changes the error for kexec_file from EKEYREJECTED to ENODATA
when the signature marker is missing.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v3: - Philipp Rudo <prudo@redhat.com>: Update the commit with note about
      change of raturn value
    - the module_signature.h is now no longer needed for kexec_file
---
 arch/powerpc/kexec/elf_64.c           | 11 -----------
 arch/s390/kernel/machine_kexec_file.c | 11 -----------
 kernel/module.c                       |  7 +------
 kernel/module_signing.c               | 12 ++++++++++--
 4 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index 64cd314cce0d..6dec8151ef73 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -24,7 +24,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/verification.h>
-#include <linux/module_signature.h>
 
 static void *elf64_load(struct kimage *image, char *kernel_buf,
 			unsigned long kernel_len, char *initrd,
@@ -156,16 +155,6 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 #ifdef CONFIG_KEXEC_SIG
 int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
-
-	if (marker_len > kernel_len)
-		return -EKEYREJECTED;
-
-	if (memcmp(kernel + kernel_len - marker_len, MODULE_SIG_STRING,
-		   marker_len))
-		return -EKEYREJECTED;
-	kernel_len -= marker_len;
-
 	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
 					 "kexec_file");
 }
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 345f2eab6e04..c3deccf1da83 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -12,7 +12,6 @@
 #include <linux/elf.h>
 #include <linux/errno.h>
 #include <linux/kexec.h>
-#include <linux/module_signature.h>
 #include <linux/verification.h>
 #include <linux/vmalloc.h>
 #include <asm/boot_data.h>
@@ -28,20 +27,10 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 #ifdef CONFIG_KEXEC_SIG
 int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
-
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
 		return 0;
 
-	if (marker_len > kernel_len)
-		return -EKEYREJECTED;
-
-	if (memcmp(kernel + kernel_len - marker_len, MODULE_SIG_STRING,
-		   marker_len))
-		return -EKEYREJECTED;
-	kernel_len -= marker_len;
-
 	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
 					"kexec_file");
 }
diff --git a/kernel/module.c b/kernel/module.c
index 8481933dfa92..d91ca0f93a40 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2882,7 +2882,6 @@ static inline void kmemleak_load_module(const struct module *mod,
 static int module_sig_check(struct load_info *info, int flags)
 {
 	int err = -ENODATA;
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	const char *reason;
 	const void *mod = info->hdr;
 
@@ -2890,11 +2889,7 @@ static int module_sig_check(struct load_info *info, int flags)
 	 * Require flags == 0, as a module with version information
 	 * removed is no longer the module that was signed
 	 */
-	if (flags == 0 &&
-	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
-		/* We truncate the module to discard the signature */
-		info->len -= markerlen;
+	if (flags == 0) {
 		err = verify_appended_signature(mod, &info->len,
 						VERIFY_USE_SECONDARY_KEYRING, "module");
 		if (!err) {
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 30149969f21f..39a6dd7c6dd2 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -15,8 +15,7 @@
 #include "module-internal.h"
 
 /**
- * verify_appended_signature - Verify the signature on a module with the
- * signature marker stripped.
+ * verify_appended_signature - Verify the signature on a module
  * @data: The data to be verified
  * @len: Size of @data.
  * @trusted_keys: Keyring to use for verification
@@ -25,12 +24,21 @@
 int verify_appended_signature(const void *data, unsigned long *len,
 			      struct key *trusted_keys, const char *what)
 {
+	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len, modlen = *len;
 	int ret;
 
 	pr_devel("==>%s(,%lu)\n", __func__, modlen);
 
+	if (markerlen > modlen)
+		return -ENODATA;
+
+	if (memcmp(data + modlen - markerlen, MODULE_SIG_STRING,
+		   markerlen))
+		return -ENODATA;
+	modlen -= markerlen;
+
 	if (modlen <= sizeof(*ms))
 		return -EBADMSG;
 
-- 
2.31.1


