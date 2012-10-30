Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TTCUe-0005uS-S4
 for kexec@lists.infradead.org; Tue, 30 Oct 2012 14:08:38 +0000
Message-ID: <508FDF60.2080101@hitachi.com>
Date: Tue, 30 Oct 2012 23:08:32 +0900
From: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>
MIME-Version: 1.0
Subject: [RFC][PATCH 2/2] kexec: Export PG_hwpoison flag into vmcoreinfo
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>

This patch exports a PG_hwpoison into vmcoreinfo when
CONFIG_MEMORY_FAILURE is defined.
"makedumpfile" needs to read information of memory, such as
'mem_section', 'zone', 'pageflags' from vmcore.

We introduce a new "-p" option into "makedumpfile" to
exclude hwpoison page from vmcore dump.
In order to introduce this feature, PG_hwpoison flag have
to export into vmcoreinfo.

Signed-off-by: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>
---
 kernel/kexec.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 0668d58..0d5d6bc 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1513,6 +1513,9 @@ static int __init crash_save_vmcoreinfo_init(void)
        VMCOREINFO_NUMBER(PG_lru);
        VMCOREINFO_NUMBER(PG_private);
        VMCOREINFO_NUMBER(PG_swapcache);
+#ifdef CONFIG_MEMORY_FAILURE
+       VMCOREINFO_NUMBER(PG_hwpoison);
+#endif

        arch_crash_save_vmcoreinfo();
        update_vmcoreinfo_note();
--
1.7.10.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
