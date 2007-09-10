Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IUde2-0007RA-1l
	for kexec@lists.infradead.org; Mon, 10 Sep 2007 08:25:21 +0100
Subject: [PATCH 1/3] [-mm patch] Cleanup the coding style according to
	Andrew's comments
In-reply-to: <20070910162305oomichi@mail.jp.nec.com>
Message-Id: <20070910162520oomichi@mail.jp.nec.com>
References: <20070910162305oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 10 Sep 2007 16:25:20 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>


[1/3] Cleanup the coding style according to Andrew's comments:
http://lists.infradead.org/pipermail/kexec/2007-August/000522.html
- vmcoreinfo_append_str() should have suitable __attribute__s so that
  the compiler can check its use.
- vmcoreinfo_max_size should have size_t.
- Use get_seconds() instead of xtime.tv_sec.
- Use init_uts_ns.name.release instead of UTS_RELEASE.


Thanks
Ken'ichi Ohmichi

---
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

---
diff -rpuN a/include/linux/kexec.h b/include/linux/kexec.h
--- a/include/linux/kexec.h	2007-09-10 19:37:59.000000000 +0900
+++ b/include/linux/kexec.h	2007-09-10 23:09:37.000000000 +0900
@@ -123,18 +123,20 @@ int kexec_should_crash(struct task_struc
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 void crash_save_vmcoreinfo(void);
 void arch_crash_save_vmcoreinfo(void);
-void vmcoreinfo_append_str(const char *fmt, ...);
+void vmcoreinfo_append_str(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
 unsigned long paddr_vmcoreinfo_note(void);
 
 #define SYMBOL(name) \
 	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
 #define SIZE(name) \
-	vmcoreinfo_append_str("SIZE(%s)=%d\n", #name, sizeof(struct name))
+	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
+			      (unsigned long)sizeof(struct name))
 #define OFFSET(name, field) \
-	vmcoreinfo_append_str("OFFSET(%s.%s)=%d\n", #name, #field, \
-			      &(((struct name *)0)->field))
+	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
+			      (unsigned long)&(((struct name *)0)->field))
 #define LENGTH(name, value) \
-	vmcoreinfo_append_str("LENGTH(%s)=%d\n", #name, value)
+	vmcoreinfo_append_str("LENGTH(%s)=%lu\n", #name, (unsigned long)value)
 #define CONFIG(name) \
 	vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
 
@@ -177,8 +179,8 @@ extern struct resource crashk_res;
 typedef u32 note_buf_t[KEXEC_NOTE_BYTES/4];
 extern note_buf_t *crash_notes;
 extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
-extern unsigned int vmcoreinfo_size;
-extern unsigned int vmcoreinfo_max_size;
+extern size_t vmcoreinfo_size;
+extern size_t vmcoreinfo_max_size;
 
 
 #else /* !CONFIG_KEXEC */
diff -rpuN a/kernel/kexec.c b/kernel/kexec.c
--- a/kernel/kexec.c	2007-09-10 19:38:00.000000000 +0900
+++ b/kernel/kexec.c	2007-09-10 23:09:58.000000000 +0900
@@ -38,8 +38,8 @@ note_buf_t* crash_notes;
 /* vmcoreinfo stuff */
 unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
 u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
-unsigned int vmcoreinfo_size = 0;
-unsigned int vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
+size_t vmcoreinfo_size;
+size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
 
 /* Location of the reserved area for the crash kernel */
 struct resource crashk_res = {
@@ -1153,7 +1153,7 @@ void crash_save_vmcoreinfo(void)
 	if (!vmcoreinfo_size)
 		return;
 
-	vmcoreinfo_append_str("CRASHTIME=%d", xtime.tv_sec);
+	vmcoreinfo_append_str("CRASHTIME=%ld", get_seconds());
 
 	buf = (u32 *)vmcoreinfo_note;
 
@@ -1195,8 +1195,8 @@ unsigned long __attribute__ ((weak)) pad
 
 static int __init crash_save_vmcoreinfo_init(void)
 {
-	vmcoreinfo_append_str("OSRELEASE=%s\n", UTS_RELEASE);
-	vmcoreinfo_append_str("PAGESIZE=%d\n", PAGE_SIZE);
+	vmcoreinfo_append_str("OSRELEASE=%s\n", init_uts_ns.name.release);
+	vmcoreinfo_append_str("PAGESIZE=%ld\n", PAGE_SIZE);
 
 	SYMBOL(init_uts_ns);
 	SYMBOL(node_online_map);
diff -rpuN a/kernel/ksysfs.c b/kernel/ksysfs.c
--- a/kernel/ksysfs.c	2007-09-10 19:38:00.000000000 +0900
+++ b/kernel/ksysfs.c	2007-09-10 23:09:07.000000000 +0900
@@ -65,7 +65,7 @@ static ssize_t vmcoreinfo_show(struct ks
 {
 	return sprintf(page, "%lx %x\n",
 		       paddr_vmcoreinfo_note(),
-		       vmcoreinfo_max_size);
+		       (unsigned int)vmcoreinfo_max_size);
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
