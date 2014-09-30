Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYrZu-0008AT-My
 for kexec@lists.infradead.org; Tue, 30 Sep 2014 07:10:31 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [resend Patch v3 2/2] export the kernel image size KERNEL_IMAGE_SIZE
Date: Tue, 30 Sep 2014 15:08:16 +0800
Message-Id: <1412060896-1902-2-git-send-email-bhe@redhat.com>
In-Reply-To: <1412060896-1902-1-git-send-email-bhe@redhat.com>
References: <1412060896-1902-1-git-send-email-bhe@redhat.com>
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
To: hpa@zytor.com
Cc: whissi@whissi.de, ak@linux.intel.com, keescook@chromium.org, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, tglx@linutronix.de, vgoyal@redhat.com

Now kaslr makes kernel image size changable, not the fixed size 512M.
So KERNEL_IMAGE_SIZE need be exported to VMCOREINFO, otherwise makedumfile
will crash.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 2bee072..bd680d3 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -2003,6 +2003,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 #endif
 	VMCOREINFO_NUMBER(PG_head_mask);
 	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
+#ifdef CONFIG_X86
+       VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
+#endif
 #ifdef CONFIG_HUGETLBFS
 	VMCOREINFO_SYMBOL(free_huge_page);
 #endif
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
