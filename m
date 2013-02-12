Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U5Fve-0004SQ-RQ
 for kexec@lists.infradead.org; Tue, 12 Feb 2013 13:29:48 +0000
Message-ID: <511A43C4.1040204@hitachi.com>
Date: Tue, 12 Feb 2013 22:29:40 +0900
From: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2 v2] kexec: Export PG_hwpoison flag into vmcoreinfo
References: <508FDEF3.8030601@hitachi.com> <20121030143750.GF2290@redhat.com>
 <50913011.2030900@hitachi.com>
 <20130208174944.96a3b50952e45e1219a94819@mxc.nes.nec.co.jp>
 <5119B1E1.4010405@hitachi.com> <8738x1hk7p.fsf@xmission.com>
In-Reply-To: <8738x1hk7p.fsf@xmission.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com, linux-kernel@vger.kernel.org

Hello Andrew,

I proposed following patch set to support hwpoison flag at kdump second kernel.
These patch set includes fixes of both kernel side and makedumpfile side, and
both pathes have been acked by maintainers who are Eric and Kumagai-san.

  [PATCH 0/2 v2] Exclude hwpoison page from vmcore dump
  https://lkml.org/lkml/2012/10/31/805

  [PATCH 1/2 v2] makedumpfile: Add a default action to exclude hwpoison page from vmcore
  https://lkml.org/lkml/2012/10/31/376

  [PATCH 2/2 v2] kexec: Export PG_hwpoison flag into vmcoreinfo
  https://lkml.org/lkml/2012/10/31/359

Could you please push the kernel side patch to export PG_hwpoison flag into 3.9 during
next merge window?



This patch exports a PG_hwpoison into vmcoreinfo when
CONFIG_MEMORY_FAILURE is defined.
"makedumpfile" needs to read information of memory, such as
'mem_section', 'zone', 'pageflags' from vmcore.

We introduce a function into "makedumpfile" to exclude
hwpoison page from vmcore dump.
In order to introduce this function, PG_hwpoison flag have
to export into vmcoreinfo.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
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
