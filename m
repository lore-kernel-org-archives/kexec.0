Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5ma0-0004gw-Ty
 for kexec@lists.infradead.org; Fri, 28 Sep 2018 06:48:55 +0000
Received: by mail-pf1-x443.google.com with SMTP id p12-v6so3645957pfh.2
 for <kexec@lists.infradead.org>; Thu, 27 Sep 2018 23:48:28 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v15 07/16] arm64: add image head flag definitions
Date: Fri, 28 Sep 2018 15:48:32 +0900
Message-Id: <20180928064841.14117-8-takahiro.akashi@linaro.org>
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
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
 arch/arm64/include/asm/boot.h | 15 +++++++++++++++
 arch/arm64/kernel/head.S      |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
index 355e552a9175..0bab7eed3012 100644
--- a/arch/arm64/include/asm/boot.h
+++ b/arch/arm64/include/asm/boot.h
@@ -5,6 +5,21 @@
 
 #include <asm/sizes.h>
 
+#define ARM64_MAGIC		"ARM\x64"
+
+#define HEAD_FLAG_BE_SHIFT		0
+#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
+#define HEAD_FLAG_BE_MASK		0x1
+#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
+
+#define HEAD_FLAG_BE			1
+#define HEAD_FLAG_PAGE_SIZE_4K		1
+#define HEAD_FLAG_PAGE_SIZE_16K		2
+#define HEAD_FLAG_PAGE_SIZE_64K		3
+
+#define head_flag_field(flags, field) \
+		(((flags) >> field##_SHIFT) & field##_MASK)
+
 /*
  * arm64 requires the DTB to be 8 byte aligned and
  * not exceed 2MB in size.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..8cbac6232ed1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -91,7 +91,7 @@ _head:
 	.quad	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
-	.ascii	"ARM\x64"			// Magic number
+	.ascii	ARM64_MAGIC			// Magic number
 #ifdef CONFIG_EFI
 	.long	pe_header - _head		// Offset to the PE header.
 
-- 
2.19.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
