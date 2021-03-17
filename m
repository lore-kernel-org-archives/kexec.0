Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lMN7b-002Mfh-Vr
 for kexec@lists.infradead.org; Wed, 17 Mar 2021 03:45:27 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH] kexec-tools: mips: Fix the increased mem parameter size
Date: Wed, 17 Mar 2021 11:45:14 +0800
Message-Id: <1615952714-18683-1-git-send-email-tangyouling@loongson.cn>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, tangyouling@loongson.cn

The added "mem=size@start" parameter actually corresponds to
"crashkernel=YM@XM", but 1 byte is missing when calculating
the size, so 1 byte should be added.

For example, when using crashkernel=108M@64M (110592K@65536K):
Without this patch:
	the mem parameter added is: mem=110591K@65536K

With this patch:
	the mem parameter added is: mem=110592K@65536K

Fixes: 0eac64052636 ("kexec: mips: Fix mem parameters")

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/arch/mips/crashdump-mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 56b8fe8..aa09c83 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -401,7 +401,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	 * kernel's available memory
 	 */
 	cmdline_add_mem(mod_cmdline, crash_reserved_mem.start,
-		crash_reserved_mem.end - crash_reserved_mem.start);
+		crash_reserved_mem.end - crash_reserved_mem.start + 1);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 
 	dbgprintf("CRASH MEMORY RANGES:\n");
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
