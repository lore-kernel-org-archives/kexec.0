Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TwHpA-0004UA-Q2
 for kexec@lists.infradead.org; Fri, 18 Jan 2013 19:42:02 +0000
Received: from probook.site
 (dslb-088-065-094-075.pools.arcor-ip.net [88.65.94.75])
 by smtp.strato.de (joses mo48) (RZmta 31.13 DYNA|AUTH)
 with (DHE-RSA-AES256-SHA encrypted) ESMTPA id R07b70p0IJcZic
 for <kexec@lists.infradead.org>; Fri, 18 Jan 2013 20:41:53 +0100 (CET)
Date: Fri, 18 Jan 2013 20:41:50 +0100
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH 1/2] kexec_newkernel_phys and kexec_newkernel_memsz
Message-ID: <20130118194150.GA15372@aepfle.de>
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


This adds sysfs entries /sys/kernel/kexec_newkernel_phys and
/sys/kernel/kexec_newkernel_memsz. Both are supposed to be passed to a
balloon driver.

---
 include/linux/kexec.h |  5 +++++
 kernel/kexec.c        | 24 ++++++++++++++++++++++++
 kernel/ksysfs.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d0b8458..3a317b6 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -203,6 +203,11 @@ int crash_shrink_memory(unsigned long new_size);
 size_t crash_get_memory_size(void);
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 
+unsigned long kexec_newkernel_get_phys(void);
+void kexec_newkernel_set_phys(unsigned long phys);
+unsigned long kexec_newkernel_get_memsz(void);
+void kexec_newkernel_set_memsz(unsigned long memsz);
+
 #else /* !CONFIG_KEXEC */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 5e4bd78..9e421a8 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -38,6 +38,9 @@
 #include <asm/io.h>
 #include <asm/sections.h>
 
+static unsigned long kexec_newkernel_phys;
+static unsigned long kexec_newkernel_memsz;
+
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
 
@@ -62,6 +65,27 @@ int kexec_should_crash(struct task_struct *p)
 	return 0;
 }
 
+unsigned long kexec_newkernel_get_phys(void)
+{
+	return kexec_newkernel_phys;
+}
+
+void kexec_newkernel_set_phys(unsigned long phys)
+{
+	printk("%s: kexec_newkernel_phys %lx -> %lx\n", __func__, kexec_newkernel_phys, phys);
+	kexec_newkernel_phys = phys;
+}
+
+unsigned long kexec_newkernel_get_memsz(void)
+{
+	return kexec_newkernel_memsz;
+}
+
+void kexec_newkernel_set_memsz(unsigned long memsz)
+{
+	printk("%s: kexec_newkernel_mensz %lx -> %lx\n", __func__, kexec_newkernel_memsz, memsz);
+	kexec_newkernel_memsz = memsz;
+}
 /*
  * When kexec transitions to the new kernel there is a one-to-one
  * mapping between physical and virtual addresses.  On processors
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 6ada93c..0660e40 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -121,6 +121,44 @@ static ssize_t kexec_crash_size_store(struct kobject *kobj,
 }
 KERNEL_ATTR_RW(kexec_crash_size);
 
+static ssize_t kexec_newkernel_phys_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%zu\n", kexec_newkernel_get_phys());
+}
+static ssize_t kexec_newkernel_phys_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	unsigned long phys;
+
+	if (strict_strtoul(buf, 0, &phys))
+		return -EINVAL;
+
+	kexec_newkernel_set_phys(phys);
+	return count;
+}
+KERNEL_ATTR_RW(kexec_newkernel_phys);
+
+static ssize_t kexec_newkernel_memsz_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%zu\n", kexec_newkernel_get_memsz());
+}
+static ssize_t kexec_newkernel_memsz_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	unsigned long memsz;
+
+	if (strict_strtoul(buf, 0, &memsz))
+		return -EINVAL;
+
+	kexec_newkernel_set_memsz(memsz);
+	return count;
+}
+KERNEL_ATTR_RW(kexec_newkernel_memsz);
+
 static ssize_t vmcoreinfo_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
 {
@@ -194,6 +232,8 @@ static struct attribute * kernel_attrs[] = {
 	&kexec_loaded_attr.attr,
 	&kexec_crash_loaded_attr.attr,
 	&kexec_crash_size_attr.attr,
+	&kexec_newkernel_phys_attr.attr,
+	&kexec_newkernel_memsz_attr.attr,
 	&vmcoreinfo_attr.attr,
 #endif
 	&rcu_expedited_attr.attr,
-- 
1.8.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
