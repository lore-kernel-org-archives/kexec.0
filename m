Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZHobE-0006Xw-EJ
 for kexec@lists.infradead.org; Wed, 22 Jul 2015 07:37:59 +0000
Subject: [PATCH 2/3] kexec: Fix race between panic() and crash_kexec()
 directly called
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Wed, 22 Jul 2015 11:14:21 +0900
Message-ID: <20150722021421.5155.99671.stgit@softrs>
In-Reply-To: <20150722021421.5155.74460.stgit@softrs>
References: <20150722021421.5155.74460.stgit@softrs>
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
To: Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

Currently, panic() and crash_kexec() can be called at the same time.
For example (x86 case):

CPU 0:
  oops_end()
    crash_kexec()
      mutex_trylock() // acquired
        nmi_shootdown_cpus() // stop other cpus

CPU 1:
  panic()
    crash_kexec()
      mutex_trylock() // failed to acquire
    smp_send_stop() // stop other cpus
    infinite loop

If CPU 1 calls smp_send_stop() before nmi_shootdown_cpus(), kdump
fails.

In another case:

CPU 0:
  oops_end()
    crash_kexec()
      mutex_trylock() // acquired
        <NMI>
        io_check_error()
          panic()
            crash_kexec()
              mutex_trylock() // failed to acquire
            infinite loop

Clearly, this is an undesirable result.

To fix this problem, this patch changes crash_kexec() to exclude
others by using panic_lock.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/kexec.h |    2 ++
 kernel/kexec.c        |   12 +++++++++++-
 kernel/panic.c        |    4 ++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e804306..bd6e477 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -238,6 +238,7 @@ extern int kexec_purgatory_get_set_symbol(struct kimage *image,
 extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
 					     const char *name);
 extern void crash_kexec(struct pt_regs *);
+extern void __crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 void crash_save_vmcoreinfo(void);
@@ -322,6 +323,7 @@ int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 struct pt_regs;
 struct task_struct;
 static inline void crash_kexec(struct pt_regs *regs) { }
+static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */
 
diff --git a/kernel/kexec.c b/kernel/kexec.c
index a785c10..fcdd825 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1470,7 +1470,7 @@ void __weak crash_unmap_reserved_pages(void)
 
 #endif /* CONFIG_KEXEC_FILE */
 
-void crash_kexec(struct pt_regs *regs)
+void __crash_kexec(struct pt_regs *regs)
 {
 	/* Take the kexec_mutex here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
@@ -1493,6 +1493,16 @@ void crash_kexec(struct pt_regs *regs)
 	}
 }
 
+void crash_kexec(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	if (spin_trylock_irqsave(&panic_lock, flags)) {
+		__crash_kexec(regs);
+		spin_unlock_irqrestore(&panic_lock, flags);
+	}
+}
+
 size_t crash_get_memory_size(void)
 {
 	size_t size = 0;
diff --git a/kernel/panic.c b/kernel/panic.c
index 3c8338b..ce5c8ab 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -135,7 +135,7 @@ void __panic(char *msg)
 	 * the "crash_kexec_post_notifiers" option to the kernel.
 	 */
 	if (!crash_kexec_post_notifiers)
-		crash_kexec(NULL);
+		__crash_kexec(NULL);
 
 	/*
 	 * Note smp_send_stop is the usual smp shutdown function, which
@@ -160,7 +160,7 @@ void __panic(char *msg)
 	 * more unstable, it can increase risks of the kdump failure too.
 	 */
 	if (crash_kexec_post_notifiers)
-		crash_kexec(NULL);
+		__crash_kexec(NULL);
 
 	bust_spinlocks(0);
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
