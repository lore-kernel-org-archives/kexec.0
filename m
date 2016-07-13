Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNJ9D-0004Em-Kb
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 12:20:17 +0000
Subject: [PATCH 1/2] Add a kexec_crash_loaded() function
From: Petr Tesarik <ptesarik@suse.com>
Date: Wed, 13 Jul 2016 14:19:55 +0200
Message-ID: <20160713121955.14969.69080.stgit@hananiah.suse.cz>
In-Reply-To: <20160713121950.14969.78606.stgit@hananiah.suse.cz>
References: <20160713121950.14969.78606.stgit@hananiah.suse.cz>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Juergen Gross <jgross@suse.com>, Josh Triplett <josh@joshtriplett.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>
Cc: "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, "open list:KEXEC" <kexec@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>

Provide a wrapper function to be used by kernel code to check whether
a crash kernel is loaded. It returns the same value that can be seen
in /sys/kernel/kexec_crash_loaded by userspace programs.

I'm exporting the function, because it will be used by Xen, and it is
possible to compile Xen modules separately to enable the use of PV
drivers with unmodified bare-metal kernels.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 include/linux/kexec.h |    2 ++
 kernel/kexec_core.c   |    6 ++++++
 kernel/ksysfs.c       |    2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e8acb2b..d461d02 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -228,6 +228,7 @@ extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
 extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
+int kexec_crash_loaded(void);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 void crash_save_vmcoreinfo(void);
 void arch_crash_save_vmcoreinfo(void);
@@ -324,6 +325,7 @@ struct task_struct;
 static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
+static inline int kexec_crash_loaded(void) { return 0; }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 56b3ed0..a303dce 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -95,6 +95,12 @@ int kexec_should_crash(struct task_struct *p)
 	return 0;
 }
 
+int kexec_crash_loaded(void)
+{
+	return !!kexec_crash_image;
+}
+EXPORT_SYMBOL_GPL(kexec_crash_loaded);
+
 /*
  * When kexec transitions to the new kernel there is a one-to-one
  * mapping between physical and virtual addresses.  On processors
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 152da4a..bf9fc9d 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -101,7 +101,7 @@ KERNEL_ATTR_RO(kexec_loaded);
 static ssize_t kexec_crash_loaded_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", !!kexec_crash_image);
+	return sprintf(buf, "%d\n", kexec_crash_loaded());
 }
 KERNEL_ATTR_RO(kexec_crash_loaded);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
