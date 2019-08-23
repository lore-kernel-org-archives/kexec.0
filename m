Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i1FZ8-0000JT-9b
 for kexec@lists.infradead.org; Fri, 23 Aug 2019 19:49:44 +0000
From: Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v5 4/7] kexec_elf: remove PURGATORY_STACK_SIZE
Date: Fri, 23 Aug 2019 21:49:16 +0200
Message-Id: <20190823194919.30916-5-svens@stackframe.org>
In-Reply-To: <20190823194919.30916-1-svens@stackframe.org>
References: <20190823194919.30916-1-svens@stackframe.org>
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
To: kexec@lists.infradead.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>, linuxppc-dev@lists.ozlabs.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>

It's not used anywhere so just drop it.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 kernel/kexec_elf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index 137037603117..87935bd5e2ba 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -21,8 +21,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#define PURGATORY_STACK_SIZE	(16 * 1024)
-
 #define elf_addr_to_cpu	elf64_to_cpu
 
 #ifndef Elf_Rel
-- 
2.23.0.rc1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
