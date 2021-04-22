Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lZP1S-00DKHu-0Z
 for kexec@lists.infradead.org; Thu, 22 Apr 2021 02:24:55 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH v2 1/4] MIPS: Fix cmdline "mem=" parameter parsing
Date: Thu, 22 Apr 2021 10:24:31 +0800
Message-Id: <1619058274-6996-2-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1619058274-6996-1-git-send-email-tangyouling@loongson.cn>
References: <1619058274-6996-1-git-send-email-tangyouling@loongson.cn>
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
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Baoquan He <bhe@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jinyang He <hejinyang@loongson.cn>, kexec@lists.infradead.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org

This problem may only occur on NUMA platforms. When machine start with the
"mem=" parameter on Loongson64, it cannot boot. When parsing the "mem="
parameter, first remove all RAM, and then add memory through memblock_add(),
which causes the newly added memory to be located on MAX_NUMNODES.

The solution is to add the current "mem=" parameter range to the memory area
of the corresponding node, instead of adding all of it to the MAX_NUMNODES
node area. Get the node number corresponding to the "mem=" parameter range
through pa_to_nid(), and then add it to the corresponding node through
memblock_add_node().

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
v2:
 - Include the mmzone.h header file, to solve the "error: implicit
   declaration of function'pa_to_nid'" compilation error.

 arch/mips/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 279be01..9338520 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -37,6 +37,7 @@
 #include <asm/cdmm.h>
 #include <asm/cpu.h>
 #include <asm/debug.h>
+#include <asm/mmzone.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp-ops.h>
@@ -359,7 +360,7 @@ static int __init early_parse_mem(char *p)
 	if (*p == '@')
 		start = memparse(p + 1, &p);
 
-	memblock_add(start, size);
+	memblock_add_node(start, size, pa_to_nid(start));
 
 	return 0;
 }
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
