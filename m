Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5] helo=mailhub.stusta.mhn.de)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IUTLD-0006Zw-V9
	for kexec@lists.infradead.org; Sun, 09 Sep 2007 16:25:14 -0400
Date: Sun, 9 Sep 2007 22:25:16 +0200
From: Adrian Bunk <bunk@kernel.org>
Subject: [-mm patch] kernel/kexec.c: make code static
Message-ID: <20070909202516.GQ3563@stusta.de>
References: <20070831215822.26e1432b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070831215822.26e1432b.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Dan Aloni <da-x@monatomic.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Aug 31, 2007 at 09:58:22PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.23-rc3-mm1:
>...
> +add-vmcoreinfo.patch
>...
>  misc
>...

This patch makes the following needlessly global code static:
- vmcoreinfo_data[]
- vmcoreinfo_size
- vmcoreinfo_append_str()

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/linux/kexec.h |   14 -----------
 kernel/kexec.c        |   52 +++++++++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 34 deletions(-)

e6dbb01497c12aa69b47914da4db1cfd23e9813e 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 99f2d6f..7cce357 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -123,21 +123,8 @@ int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 void crash_save_vmcoreinfo(void);
 void arch_crash_save_vmcoreinfo(void);
-void vmcoreinfo_append_str(const char *fmt, ...);
 unsigned long paddr_vmcoreinfo_note(void);
 
-#define SYMBOL(name) \
-	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
-#define SIZE(name) \
-	vmcoreinfo_append_str("SIZE(%s)=%d\n", #name, sizeof(struct name))
-#define OFFSET(name, field) \
-	vmcoreinfo_append_str("OFFSET(%s.%s)=%d\n", #name, #field, \
-			      &(((struct name *)0)->field))
-#define LENGTH(name, value) \
-	vmcoreinfo_append_str("LENGTH(%s)=%d\n", #name, value)
-#define CONFIG(name) \
-	vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
-
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
@@ -177,7 +164,6 @@ extern struct resource crashk_res;
 typedef u32 note_buf_t[KEXEC_NOTE_BYTES/4];
 extern note_buf_t *crash_notes;
 extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
-extern unsigned int vmcoreinfo_size;
 extern unsigned int vmcoreinfo_max_size;
 
 
diff --git a/kernel/kexec.c b/kernel/kexec.c
index af2c035..c84a387 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -36,9 +36,9 @@
 note_buf_t* crash_notes;
 
 /* vmcoreinfo stuff */
-unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
+static unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
 u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
-unsigned int vmcoreinfo_size = 0;
+static unsigned int vmcoreinfo_size = 0;
 unsigned int vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
 
 /* Location of the reserved area for the crash kernel */
@@ -49,6 +49,36 @@ struct resource crashk_res = {
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
 };
 
+#define SYMBOL(name) \
+	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
+#define SIZE(name) \
+	vmcoreinfo_append_str("SIZE(%s)=%d\n", #name, sizeof(struct name))
+#define OFFSET(name, field) \
+	vmcoreinfo_append_str("OFFSET(%s.%s)=%d\n", #name, #field, \
+			      &(((struct name *)0)->field))
+#define LENGTH(name, value) \
+	vmcoreinfo_append_str("LENGTH(%s)=%d\n", #name, value)
+#define CONFIG(name) \
+	vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
+
+static void vmcoreinfo_append_str(const char *fmt, ...)
+{
+	va_list args;
+	char buf[0x50];
+	int r;
+
+	va_start(args, fmt);
+	r = vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+	if (r + vmcoreinfo_size > vmcoreinfo_max_size)
+		r = vmcoreinfo_max_size - vmcoreinfo_size;
+
+	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
+
+	vmcoreinfo_size += r;
+}
+
 int kexec_should_crash(struct task_struct *p)
 {
 	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
@@ -1163,24 +1193,6 @@ void crash_save_vmcoreinfo(void)
 	final_note(buf);
 }
 
-void vmcoreinfo_append_str(const char *fmt, ...)
-{
-	va_list args;
-	char buf[0x50];
-	int r;
-
-	va_start(args, fmt);
-	r = vsnprintf(buf, sizeof(buf), fmt, args);
-	va_end(args);
-
-	if (r + vmcoreinfo_size > vmcoreinfo_max_size)
-		r = vmcoreinfo_max_size - vmcoreinfo_size;
-
-	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
-
-	vmcoreinfo_size += r;
-}
-
 /*
  * provide an empty default implementation here -- architecture
  * code may override this


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
