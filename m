From: Michal Suchanek <msuchanek@suse.de>
Date: Fri,  7 Jan 2022 12:53:46 +0100
Subject: [PATCH v3 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
In-Reply-To: <cover.1641555875.git.msuchanek@suse.de>
References: <cover.1641555875.git.msuchanek@suse.de>
Message-ID: <28124ae2019e73fb106084a4c97fccd285eca59e.1641555875.git.msuchanek@suse.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Copy the code from s390x

Both powerpc and s390x use appended signature format (as opposed to EFI
based patforms using PE format).

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v3: - Philipp Rudo <prudo@redhat.com>: Update the comit message with
      explanation why the s390 code is usable on powerpc.
    - Include correct header for mod_check_sig
    - Nayna <nayna@linux.vnet.ibm.com>: Mention additional IMA features
      in kconfig text
---
 arch/powerpc/Kconfig        | 16 ++++++++++++++++
 arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dea74d7717c0..1cde9b6c5987 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -560,6 +560,22 @@ config KEXEC_FILE
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
+config KEXEC_SIG
+	bool "Verify kernel signature during kexec_file_load() syscall"
+	depends on KEXEC_FILE && MODULE_SIG_FORMAT
+	help
+	  This option makes kernel signature verification mandatory for
+	  the kexec_file_load() syscall.
+
+	  In addition to that option, you need to enable signature
+	  verification for the corresponding kernel image type being
+	  loaded in order for this to work.
+
+	  Note: on powerpc IMA_ARCH_POLICY also implements kexec'ed kernel
+	  verification. In addition IMA adds kernel hashes to the measurement
+	  list, extends IMA PCR in the TPM, and implements kernel image
+	  blacklist by hash.
+
 config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index eeb258002d1e..98d1cb5135b4 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -23,6 +23,7 @@
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/module_signature.h>
 
 static void *elf64_load(struct kimage *image, char *kernel_buf,
 			unsigned long kernel_len, char *initrd,
@@ -151,7 +152,42 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	return ret ? ERR_PTR(ret) : NULL;
 }
 
+#ifdef CONFIG_KEXEC_SIG
+int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
+{
+	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
+	struct module_signature *ms;
+	unsigned long sig_len;
+	int ret;
+
+	if (marker_len > kernel_len)
+		return -EKEYREJECTED;
+
+	if (memcmp(kernel + kernel_len - marker_len, MODULE_SIG_STRING,
+		   marker_len))
+		return -EKEYREJECTED;
+	kernel_len -= marker_len;
+
+	ms = (void *)kernel + kernel_len - sizeof(*ms);
+	ret = mod_check_sig(ms, kernel_len, "kexec");
+	if (ret)
+		return ret;
+
+	sig_len = be32_to_cpu(ms->sig_len);
+	kernel_len -= sizeof(*ms) + sig_len;
+
+	return verify_pkcs7_signature(kernel, kernel_len,
+				      kernel + kernel_len, sig_len,
+				      VERIFY_USE_PLATFORM_KEYRING,
+				      VERIFYING_MODULE_SIGNATURE,
+				      NULL, NULL);
+}
+#endif /* CONFIG_KEXEC_SIG */
+
 const struct kexec_file_ops kexec_elf64_ops = {
 	.probe = kexec_elf_probe,
 	.load = elf64_load,
+#ifdef CONFIG_KEXEC_SIG
+	.verify_sig = elf64_verify_sig,
+#endif
 };
-- 
2.31.1


