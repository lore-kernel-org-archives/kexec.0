Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lZP1l-00DKJC-0W
 for kexec@lists.infradead.org; Thu, 22 Apr 2021 02:25:15 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH v2 2/4] mips: kdump: Capture kernel should be able to see old
 memories
Date: Thu, 22 Apr 2021 10:24:32 +0800
Message-Id: <1619058274-6996-3-git-send-email-tangyouling@loongson.cn>
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

From: Huacai Chen <chenhc@lemote.com>

kexec-tools use mem=X@Y to pass usable memories to capture kernel, but
in commit a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map") all
BIOS passed memories are removed by early_parse_mem(). I think this is
reasonable for a normal kernel but not for a capture kernel, because a
capture kernel should be able to see all old memories, even though it is
not supposed to use them.

Fixes: a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map")
Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
v2:
- Determine whether it is a capture kernel by judging whether there
  is an "elfcorehdr" parameter in the cmdline.

 arch/mips/kernel/setup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 9338520..1bc8a9cc 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -352,8 +352,13 @@ static int __init early_parse_mem(char *p)
 	 */
 	if (usermem == 0) {
 		usermem = 1;
-		memblock_remove(memblock_start_of_DRAM(),
-			memblock_end_of_DRAM() - memblock_start_of_DRAM());
+		/*
+		 * During the kdump operation, the old memory should be
+		 * visible to the capture kernel.
+		 */
+		if (!strstr(boot_command_line, "elfcorehdr"))
+			memblock_remove(memblock_start_of_DRAM(),
+				memblock_end_of_DRAM() - memblock_start_of_DRAM());
 	}
 	start = 0;
 	size = memparse(p, &p);
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
