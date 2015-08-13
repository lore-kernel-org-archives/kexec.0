Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZPoKi-0002TK-Hc
 for kexec@lists.infradead.org; Thu, 13 Aug 2015 08:57:57 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [Patch v3 RESEND] kexec: export KERNEL_IMAGE_SIZE to vmcoreinfo
Date: Thu, 13 Aug 2015 16:57:27 +0800
Message-Id: <1439456247-7968-1-git-send-email-bhe@redhat.com>
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
To: ebiederm@xmission.com, akpm@linux-foundation.org, vgoyal@redhat.com, keescook@chromium.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

In x86_64, since v2.6.26 the KERNEL_IMAGE_SIZE is changed to 512M, and
accordingly the MODULES_VADDR is changed to 0xffffffffa0000000. However,
in v3.12 Kees Cook introduced kaslr to randomise the location of kernel.
And the kernel text mapping addr space is enlarged from 512M to 1G. That
means now KERNEL_IMAGE_SIZE is variable, its value is 512M when kaslr
support is not compiled in and 1G when kaslr support is compiled in.
Accordingly the MODULES_VADDR is changed too to be:

    #define MODULES_VADDR    (__START_KERNEL_map + KERNEL_IMAGE_SIZE)

So when kaslr is compiled in and enabled, the kernel text mapping addr
space and modules vaddr space need be adjusted. Otherwise makedumpfile
will collapse since the addr for some symbols is not correct.

Hence KERNEL_IMAGE_SIZE need be exported to vmcoreinfo and got in
makedumpfile to help calculate MODULES_VADDR.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index a785c10..b813c9c 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -2012,6 +2012,9 @@ static int __init crash_save_vmcoreinfo_init(void)
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
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
