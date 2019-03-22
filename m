Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx60.baidu.com ([61.135.168.60]
 helo=tc-sys-mailedm04.tc.baidu.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h7AG9-0007Af-0D
 for kexec@lists.infradead.org; Fri, 22 Mar 2019 02:50:22 +0000
From: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] kexec: fix the check in crash_save_cpu
Date: Fri, 22 Mar 2019 10:50:01 +0800
Message-Id: <1553223001-23544-1-git-send-email-lirongqing@baidu.com>
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
To: kexec@lists.infradead.org, ebiederm@xmission.com

crash_notes should be checked with NULL, not its percpu
member, which can not be NULL

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/kexec_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d7140447be75..8c0d6feb76d5 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1067,9 +1067,9 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 	 * squirrelled away.  ELF notes happen to provide
 	 * all of that, so there is no need to invent something new.
 	 */
-	buf = (u32 *)per_cpu_ptr(crash_notes, cpu);
-	if (!buf)
+	if (!crash_notes)
 		return;
+	buf = (u32 *)per_cpu_ptr(crash_notes, cpu);
 	memset(&prstatus, 0, sizeof(prstatus));
 	prstatus.pr_pid = current->pid;
 	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
-- 
2.16.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
