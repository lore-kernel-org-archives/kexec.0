Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOt5m-00EAkk-19
 for kexec@lists.infradead.org; Sat, 11 Sep 2021 02:50:11 +0000
From: Zhaofeng Li <hello@zhaofeng.li>
Subject: [PATCH 2/3] multiboot2: Use rel_min and rel_max for mbi destination
Date: Fri, 10 Sep 2021 19:48:59 -0700
Message-Id: <20210911024900.1899877-3-hello@zhaofeng.li>
In-Reply-To: <20210911024900.1899877-1-hello@zhaofeng.li>
References: <20210911024900.1899877-1-hello@zhaofeng.li>
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
Cc: Zhaofeng Li <hello@zhaofeng.li>, Simon Horman <horms@verge.net.au>

This would segfault if mhi.rel_tag didn't exist.

Signed-off-by: Zhaofeng Li <hello@zhaofeng.li>
---
 kexec/arch/i386/kexec-mb2-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
index c10c0ef..49fcc2d 100644
--- a/kexec/arch/i386/kexec-mb2-x86.c
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -600,7 +600,7 @@ int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
 		return -1;
 
 	addr = add_buffer(info, mbi_buf, mbi_bytes, mbi_bytes, 4,
-			  mhi.rel_tag->min_addr, mhi.rel_tag->max_addr, 1);
+			  rel_min, rel_max, 1);
 
 	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
 	regs.eax = MULTIBOOT2_BOOTLOADER_MAGIC;
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
