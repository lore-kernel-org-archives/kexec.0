Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gNAaD-0005hd-PC
 for kexec@lists.infradead.org; Thu, 15 Nov 2018 05:52:58 +0000
Received: by mail-yb1-xb44.google.com with SMTP id i17-v6so7889103ybp.13
 for <kexec@lists.infradead.org>; Wed, 14 Nov 2018 21:52:43 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v16 07/16] arm64: add image head flag definitions
Date: Thu, 15 Nov 2018 14:52:46 +0900
Message-Id: <20181115055254.2812-8-takahiro.akashi@linaro.org>
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: ard.biesheuvel@linaro.org, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, prudo@linux.ibm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

Those image head's flags will be used later by kexec_file loader.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/image.h | 59 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S       |  3 +-
 arch/arm64/kernel/image.h      | 21 +++++++-----
 3 files changed, 74 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/image.h

diff --git a/arch/arm64/include/asm/image.h b/arch/arm64/include/asm/image.h
new file mode 100644
index 000000000000..e2c27a2278e9
--- /dev/null
+++ b/arch/arm64/include/asm/image.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#define ARM64_IMAGE_MAGIC	"ARM\x64"
+
+#define ARM64_IMAGE_FLAG_BE_SHIFT		0
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_SHIFT	(ARM64_IMAGE_FLAG_BE_SHIFT + 1)
+#define ARM64_IMAGE_FLAG_PHYS_BASE_SHIFT \
+					(ARM64_IMAGE_FLAG_PAGE_SIZE_SHIFT + 2)
+#define ARM64_IMAGE_FLAG_BE_MASK		0x1
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_MASK		0x3
+#define ARM64_IMAGE_FLAG_PHYS_BASE_MASK		0x1
+
+#define ARM64_IMAGE_FLAG_LE			0
+#define ARM64_IMAGE_FLAG_BE			1
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_4K		1
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_16K		2
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_64K		3
+#define ARM64_IMAGE_FLAG_PHYS_BASE		1
+
+#ifndef __ASSEMBLY__
+
+#define arm64_image_flag_field(flags, field) \
+				(((flags) >> field##_SHIFT) & field##_MASK)
+
+/*
+ * struct arm64_image_header - arm64 kernel image header
+ * See Documentation/arm64/booting.txt for details
+ *
+ * @code0:		Executable code, or
+ *   @mz_header		  alternatively used for part of MZ header
+ * @code1:		Executable code
+ * @text_offset:	Image load offset
+ * @image_size:		Effective Image size
+ * @flags:		kernel flags
+ * @reserved:		reserved
+ * @magic:		Magic number
+ * @reserved5:		reserved, or
+ *   @pe_header:	  alternatively used for PE COFF offset
+ */
+
+struct arm64_image_header {
+	__le32 code0;
+	__le32 code1;
+	__le64 text_offset;
+	__le64 image_size;
+	__le64 flags;
+	__le64 res2;
+	__le64 res3;
+	__le64 res4;
+	__le32 magic;
+	__le32 res5;
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_IMAGE_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..4d0b78c95c34 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -31,6 +31,7 @@
 #include <asm/cache.h>
 #include <asm/cputype.h>
 #include <asm/elf.h>
+#include <asm/image.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/kvm_arm.h>
 #include <asm/memory.h>
@@ -91,7 +92,7 @@ _head:
 	.quad	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
-	.ascii	"ARM\x64"			// Magic number
+	.ascii	ARM64_IMAGE_MAGIC		// Magic number
 #ifdef CONFIG_EFI
 	.long	pe_header - _head		// Offset to the PE header.
 
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index a820ed07fb80..d843f9cbcd92 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -15,13 +15,15 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef __ASM_IMAGE_H
-#define __ASM_IMAGE_H
+#ifndef __ARM64_KERNEL_IMAGE_H
+#define __ARM64_KERNEL_IMAGE_H
 
 #ifndef LINKER_SCRIPT
 #error This file should only be included in vmlinux.lds.S
 #endif
 
+#include <asm/image.h>
+
 /*
  * There aren't any ELF relocations we can use to endian-swap values known only
  * at link time (e.g. the subtraction of two symbol addresses), so we must get
@@ -47,19 +49,22 @@
 	sym##_lo32 = DATA_LE32((data) & 0xffffffff);		\
 	sym##_hi32 = DATA_LE32((data) >> 32)
 
+#define __HEAD_FLAG(field)	(__HEAD_FLAG_##field << \
+					ARM64_IMAGE_FLAG_##field##_SHIFT)
+
 #ifdef CONFIG_CPU_BIG_ENDIAN
-#define __HEAD_FLAG_BE		1
+#define __HEAD_FLAG_BE		ARM64_IMAGE_FLAG_BE
 #else
-#define __HEAD_FLAG_BE		0
+#define __HEAD_FLAG_BE		ARM64_IMAGE_FLAG_LE
 #endif
 
 #define __HEAD_FLAG_PAGE_SIZE	((PAGE_SHIFT - 10) / 2)
 
 #define __HEAD_FLAG_PHYS_BASE	1
 
-#define __HEAD_FLAGS		((__HEAD_FLAG_BE << 0) |	\
-				 (__HEAD_FLAG_PAGE_SIZE << 1) |	\
-				 (__HEAD_FLAG_PHYS_BASE << 3))
+#define __HEAD_FLAGS		(__HEAD_FLAG(BE)	| \
+				 __HEAD_FLAG(PAGE_SIZE) | \
+				 __HEAD_FLAG(PHYS_BASE))
 
 /*
  * These will output as part of the Image header, which should be little-endian
@@ -119,4 +124,4 @@ __efistub_screen_info		= KALLSYMS_HIDE(screen_info);
 
 #endif
 
-#endif /* __ASM_IMAGE_H */
+#endif /* __ARM64_KERNEL_IMAGE_H */
-- 
2.19.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
