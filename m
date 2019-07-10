Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1hl85L-0004hD-OO
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 08:36:21 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] x86: Include kexec-mb2-x86.c and multiboot2.h in distribution
Date: Wed, 10 Jul 2019 10:36:01 +0200
Message-Id: <20190710083601.2040-1-horms@verge.net.au>
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, Varad Gautam <vrd@amazon.de>, Amit Shah <aams@amazon.de>, David Woodhouse <dwmw@amazon.co.uk>

Fixes: 22a2ed55132e ("x86: Support multiboot2 images")
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 include/Makefile         | 1 +
 kexec/arch/i386/Makefile | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

 I intend to apply this patch for inclusion in v2.0.20-rc1
 the release of which I am currently preparing.

diff --git a/include/Makefile b/include/Makefile
index c26b503fbe36..621ce9f903d6 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -5,6 +5,7 @@ dist += include/Makefile		\
 	include/x86/x86-linux.h		\
 	include/x86/mb_info.h		\
 	include/x86/mb_header.h		\
+	include/x86/multiboot2.h	\
 	include/elf.h			\
 	include/image.h			\
 	include/unused.h		\
diff --git a/kexec/arch/i386/Makefile b/kexec/arch/i386/Makefile
index d52a2f541448..105cefd60695 100644
--- a/kexec/arch/i386/Makefile
+++ b/kexec/arch/i386/Makefile
@@ -13,6 +13,8 @@ i386_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
 i386_KEXEC_SRCS += kexec/arch/i386/crashdump-x86.c
 
 dist += kexec/arch/i386/Makefile $(i386_KEXEC_SRCS)			\
-	kexec/arch/i386/kexec-x86.h kexec/arch/i386/crashdump-x86.h	\
+	kexec/arch/i386/crashdump-x86.h					\
+	kexec/arch/i386/kexec-mb2-x86.c					\
+	kexec/arch/i386/kexec-x86.h					\
 	kexec/arch/i386/x86-linux-setup.h				\
 	kexec/arch/i386/include/arch/options.h
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
