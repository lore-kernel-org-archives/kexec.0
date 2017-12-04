Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eLguk-0000fD-9U
 for kexec@lists.infradead.org; Mon, 04 Dec 2017 02:55:28 +0000
Received: by mail-pf0-x241.google.com with SMTP id a90so7485475pfk.1
 for <kexec@lists.infradead.org>; Sun, 03 Dec 2017 18:55:06 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v7 05/11] arm64: kexec_file: create purgatory
Date: Mon,  4 Dec 2017 11:57:55 +0900
Message-Id: <20171204025801.12161-6-takahiro.akashi@linaro.org>
In-Reply-To: <20171204025801.12161-1-takahiro.akashi@linaro.org>
References: <20171204025801.12161-1-takahiro.akashi@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org, julien.thierry@arm.com
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is a basic purgatory, or a kind of glue code between the two kernels,
for arm64.

Since purgatory is assumed to be relocatable (not executable) object by
kexec generic code, arch_kexec_apply_relocations_add() is required in
general. Arm64's purgatory, however, is a simple asm and all the references
can be resolved as local, no re-linking is needed here.

Please note that even if we don't support digest check at purgatory we
need purgatory_sha_regions and purgatory_sha256_digest as they are
referenced by generic kexec code.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Makefile           |  1 +
 arch/arm64/purgatory/Makefile | 24 +++++++++++++++++++
 arch/arm64/purgatory/entry.S  | 55 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 arch/arm64/purgatory/Makefile
 create mode 100644 arch/arm64/purgatory/entry.S

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b481b4a7c011..0f0742e98c08 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -113,6 +113,7 @@ core-$(CONFIG_XEN) += arch/arm64/xen/
 core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+core-$(CONFIG_KEXEC_FILE) += arch/arm64/purgatory/
 
 # Default target when executing plain make
 boot		:= arch/arm64/boot
diff --git a/arch/arm64/purgatory/Makefile b/arch/arm64/purgatory/Makefile
new file mode 100644
index 000000000000..c2127a2cbd51
--- /dev/null
+++ b/arch/arm64/purgatory/Makefile
@@ -0,0 +1,24 @@
+OBJECT_FILES_NON_STANDARD := y
+
+purgatory-y := entry.o
+
+targets += $(purgatory-y)
+PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
+
+LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined \
+					-nostdlib -z nodefaultlib
+targets += purgatory.ro
+
+$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
+		$(call if_changed,ld)
+
+targets += kexec_purgatory.c
+
+CMD_BIN2C = $(objtree)/scripts/basic/bin2c
+quiet_cmd_bin2c = BIN2C $@
+	cmd_bin2c = $(CMD_BIN2C) kexec_purgatory < $< > $@
+
+$(obj)/kexec_purgatory.c: $(obj)/purgatory.ro FORCE
+	$(call if_changed,bin2c)
+
+obj-${CONFIG_KEXEC_FILE}	+= kexec_purgatory.o
diff --git a/arch/arm64/purgatory/entry.S b/arch/arm64/purgatory/entry.S
new file mode 100644
index 000000000000..fe6e968076db
--- /dev/null
+++ b/arch/arm64/purgatory/entry.S
@@ -0,0 +1,55 @@
+/*
+ * kexec core purgatory
+ */
+#include <linux/linkage.h>
+#include <uapi/linux/kexec.h>
+
+#define SHA256_DIGEST_SIZE	32 /* defined in crypto/sha.h */
+
+.text
+
+ENTRY(purgatory_start)
+	/* Start new image. */
+	ldr	x17, __kernel_entry
+	ldr	x0, __dtb_addr
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+	br	x17
+END(purgatory_start)
+
+/*
+ * data section:
+ * kernel_entry and dtb_addr are global but also labelled as local,
+ * "__xxx:", to avoid unwanted re-linking.
+ *
+ * purgatory_sha_regions and purgatory_sha256_digest are referenced
+ * by kexec generic code and so must exist, but not actually used
+ * here because hash check is not that useful in purgatory.
+ */
+.align 3
+
+.globl kernel_entry
+kernel_entry:
+__kernel_entry:
+	.quad	0
+END(kernel_entry)
+
+.globl dtb_addr
+dtb_addr:
+__dtb_addr:
+	.quad	0
+END(dtb_addr)
+
+.globl purgatory_sha_regions
+purgatory_sha_regions:
+	.rept	KEXEC_SEGMENT_MAX
+	.quad	0
+	.quad	0
+	.endr
+END(purgatory_sha_regions)
+
+.globl purgatory_sha256_digest
+purgatory_sha256_digest:
+        .skip   SHA256_DIGEST_SIZE
+END(purgatory_sha256_digest)
-- 
2.14.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
