Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKuYq-0004fV-CB
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 02:31:13 +0000
Received: by mail-pl1-x641.google.com with SMTP id y6so6031988plt.9
 for <kexec@lists.infradead.org>; Tue, 22 Sep 2020 19:31:10 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/3] MIPS: Crash kernel should be able to see old memories
Date: Wed, 23 Sep 2020 10:30:55 +0800
Message-Id: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
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
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: Huacai Chen <chenhuacai@gmail.com>, kexec@lists.infradead.org, linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>

Kexec-tools use mem=X@Y to pass usable memories to crash kernel, but in
commit a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map") all
BIOS passed memories are removed by early_parse_mem(). I think this is
reasonable for a normal kernel but not for a crash kernel, because a
crash kernel should be able to see all old memories, even though it is
not supposed to use them.

Fixes: a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4c04a86..e2804a2 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -392,8 +392,10 @@ static int __init early_parse_mem(char *p)
 	 */
 	if (usermem == 0) {
 		usermem = 1;
+#ifndef CONFIG_CRASH_DUMP
 		memblock_remove(memblock_start_of_DRAM(),
 			memblock_end_of_DRAM() - memblock_start_of_DRAM());
+#endif
 	}
 	start = 0;
 	size = memparse(p, &p);
-- 
2.7.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
