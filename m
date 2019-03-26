Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8fvA-0002UX-MI
 for kexec@lists.infradead.org; Tue, 26 Mar 2019 06:50:55 +0000
Received: by mail-pl1-f194.google.com with SMTP id y6so1183295pll.13
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2019 23:50:48 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH] include/kcore: Remove left-over instances of
 'kclist_add_remap()'
Date: Tue, 26 Mar 2019 12:20:28 +0530
Message-Id: <1553583028-17804-1-git-send-email-bhsharma@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, bhsharma@redhat.com, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Boris Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com, Dave Anderson <anderson@redhat.com>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org

Commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
removed the sole usage of 'kclist_add_remap()' from
'arch/x86/mm/cpu_entry_area.c', but it did not remove the left-over
definition from the include file.

Fix the same.

Cc: James Morse <james.morse@arm.com>
Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 include/linux/kcore.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index c843f4a9c512..da676cdbd727 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -38,12 +38,6 @@ struct vmcoredd_node {
 
 #ifdef CONFIG_PROC_KCORE
 void __init kclist_add(struct kcore_list *, void *, size_t, int type);
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-	m->vaddr = (unsigned long)vaddr;
-	kclist_add(m, addr, sz, KCORE_REMAP);
-}
 
 extern int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn));
 #else
@@ -51,11 +45,6 @@ static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
 }
-
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-}
 #endif
 
 #endif /* _LINUX_KCORE_H */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
