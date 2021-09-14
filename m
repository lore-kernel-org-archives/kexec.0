Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPzVk-004660-8K
 for kexec@lists.infradead.org; Tue, 14 Sep 2021 03:53:33 +0000
From: Zhaofeng Li <hello@zhaofeng.li>
Subject: [PATCH v2 3/5] multiboot2: Use rel_min and rel_max for buffer
 destinations
Date: Mon, 13 Sep 2021 20:51:40 -0700
Message-Id: <20210914035142.251818-4-hello@zhaofeng.li>
In-Reply-To: <20210914035142.251818-1-hello@zhaofeng.li>
References: <20210914035142.251818-1-hello@zhaofeng.li>
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
 kexec/arch/i386/kexec-mb2-x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
index 6bbe35e..f3c6438 100644
--- a/kexec/arch/i386/kexec-mb2-x86.c
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -582,7 +582,7 @@ int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
 
 			/* Pick the next aligned spot to load it in. Always page align. */
 			addr = add_buffer(info, buf, mod_size, mod_size, getpagesize(),
-					  mhi.rel_tag->min_addr, mhi.rel_tag->max_addr, 1);
+					  rel_min, rel_max, 1);
 
 			/* Add the module command line */
 			sprintf(mod_clp, "%s", mod_command_line);
@@ -602,7 +602,7 @@ int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
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
