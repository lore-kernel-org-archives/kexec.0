Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TwHrR-00051c-KT
 for kexec@lists.infradead.org; Fri, 18 Jan 2013 19:44:22 +0000
Received: from probook.site
 (dslb-088-065-094-075.pools.arcor-ip.net [88.65.94.75])
 by smtp.strato.de (jorabe mo44) (RZmta 31.13 DYNA|AUTH)
 with (DHE-RSA-AES256-SHA encrypted) ESMTPA id j05e60p0IJMOs8
 for <kexec@lists.infradead.org>; Fri, 18 Jan 2013 20:44:20 +0100 (CET)
Date: Fri, 18 Jan 2013 20:44:17 +0100
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH 2/2] register_balloon_populate_range
Message-ID: <20130118194416.GB15372@aepfle.de>
References: <20130118163809.GA23530@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130118163809.GA23530@aepfle.de>
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
To: kexec@lists.infradead.org

This patch adds a hook for a balloon driver to populate segments before
the actual kexec.

---
 include/linux/kexec.h |  2 ++
 kernel/kexec.c        | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 3a317b6..b46f9c6 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -207,11 +207,13 @@ unsigned long kexec_newkernel_get_phys(void);
 void kexec_newkernel_set_phys(unsigned long phys);
 unsigned long kexec_newkernel_get_memsz(void);
 void kexec_newkernel_set_memsz(unsigned long memsz);
+void register_balloon_populate_range(void (*fn)(unsigned long pfn, unsigned long num));
 
 #else /* !CONFIG_KEXEC */
 struct pt_regs;
 struct task_struct;
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
+static inline void register_balloon_populate_range(void (*fn)(unsigned long pfn, unsigned long num)) { }
 #endif /* CONFIG_KEXEC */
 #endif /* LINUX_KEXEC_H */
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 9e421a8..22a3881 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -32,6 +32,7 @@
 #include <linux/vmalloc.h>
 #include <linux/swap.h>
 #include <linux/syscore_ops.h>
+#include <linux/export.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -86,6 +87,41 @@ void kexec_newkernel_set_memsz(unsigned long memsz)
 	printk("%s: kexec_newkernel_mensz %lx -> %lx\n", __func__, kexec_newkernel_memsz, memsz);
 	kexec_newkernel_memsz = memsz;
 }
+
+static void (*balloon_populate_range)(unsigned long pfn, unsigned long num);
+
+void register_balloon_populate_range(void (*fn)(unsigned long pfn, unsigned long num))
+{
+	if (!balloon_populate_range)
+		balloon_populate_range = fn;
+}
+EXPORT_SYMBOL_GPL(register_balloon_populate_range);
+
+static void populate_range(unsigned long mem, size_t memsz)
+{
+	unsigned long pfn, num;
+
+
+
+	pfn = PFN_DOWN(mem);
+	num = PFN_UP(memsz);
+	if (pfn && num)
+		balloon_populate_range(pfn, num);
+}
+
+static void kimage_populate_ranges(struct kimage *image)
+{
+	unsigned long i;
+
+	if (!balloon_populate_range)
+		return;
+
+	for (i = 0; i < image->nr_segments; i++)
+		populate_range(image->segment[i].mem, image->segment[i].memsz);
+
+	populate_range(kexec_newkernel_phys, kexec_newkernel_memsz);
+}
+
 /*
  * When kexec transitions to the new kernel there is a one-to-one
  * mapping between physical and virtual addresses.  On processors
@@ -1598,6 +1634,8 @@ int kernel_kexec(void)
 		machine_shutdown();
 	}
 
+	kimage_populate_ranges(kexec_image);
+
 	machine_kexec(kexec_image);
 
 #ifdef CONFIG_KEXEC_JUMP
-- 
1.8.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
