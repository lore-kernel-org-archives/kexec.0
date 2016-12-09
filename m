Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFGsJ-0001fM-Hr
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 08:49:52 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools] ia64: ehdr is not UNUSED in machine_apply_elf_rel
Date: Fri,  9 Dec 2016 09:49:19 +0100
Message-Id: <1481273359-1600-1-git-send-email-horms@verge.net.au>
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
Cc: Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Anton Blanchard <anton@samba.org>

The ehdr parameter of machine_apply_elf_rel() is used.
This resolves a build regression.

Cc: Anton Blanchard <anton@samba.org>
Cc: Dave Young <dyoung@redhat.com>
Fixes: 4a2ae3a39c64 ("Pass struct mem_sym into machine_apply_elf_rel()")
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/ia64/kexec-elf-rel-ia64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/ia64/kexec-elf-rel-ia64.c b/kexec/arch/ia64/kexec-elf-rel-ia64.c
index f847626b2508..7f7c08cba4b1 100644
--- a/kexec/arch/ia64/kexec-elf-rel-ia64.c
+++ b/kexec/arch/ia64/kexec-elf-rel-ia64.c
@@ -72,7 +72,7 @@ bundle (const uint64_t insn)
         return insn & ~0xfUL;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+void machine_apply_elf_rel(struct mem_ehdr *ehdr,
 	struct mem_sym *UNUSED(sym), unsigned long r_type, void *location,
 	unsigned long address, unsigned long value)
 {
-- 
2.7.0.rc3.207.g0ac5344


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
