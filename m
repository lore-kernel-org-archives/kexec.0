Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6qMW-0007ic-BL
 for kexec@lists.infradead.org; Thu, 10 Dec 2015 01:49:42 +0000
Subject: [V6 PATCH 3/6] kexec: Fix race between panic() and crash_kexec()
 called directly
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Thu, 10 Dec 2015 10:46:30 +0900
Message-ID: <20151210014630.25437.94161.stgit@softrs>
In-Reply-To: <20151210014624.25437.50028.stgit@softrs>
References: <20151210014624.25437.50028.stgit@softrs>
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
Cc: Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Currently, panic() and crash_kexec() can be called at the same time.
For example (x86 case):

CPU 0:
  oops_end()
    crash_kexec()
      mutex_trylock() // acquired
        nmi_shootdown_cpus() // stop other CPUs

CPU 1:
  panic()
    crash_kexec()
      mutex_trylock() // failed to acquire
    smp_send_stop() // stop other CPUs
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
others by using atomic_t panic_cpu.

V6:
- Use PANIC_CPU_INVALID instead of hard-coded -1
- Add comments about __crash_kexec()

V5:
- Add missing dummy __crash_kexec() for !CONFIG_KEXEC_CORE case
- Replace atomic_xchg() with atomic_set() in crash_kexec() because
  it is used as a release operation and there is no need of memory
  barrier effect.  This change also removes an unused value warning

V4:
- Use new __crash_kexec(), no exclusion check version of crash_kexec(),
  instead of checking if panic_cpu is the current CPU or not

V2:
- Use atomic_cmpxchg() instead of spin_trylock() on panic_lock
  to exclude concurrent accesses
- Don't introduce no-lock version of crash_kexec()

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 include/linux/kexec.h |    2 ++
 kernel/kexec_core.c   |   30 +++++++++++++++++++++++++++++-
 kernel/panic.c        |    4 ++--
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d140b1e..7b68d27 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -237,6 +237,7 @@ extern int kexec_purgatory_get_set_symbol(struct kimage *image,
 					  unsigned int size, bool get_value);
 extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
 					     const char *name);
+extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
@@ -332,6 +333,7 @@ int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
+static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #define kexec_in_progress false
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 11b64a6..c823f30 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -853,7 +853,12 @@ struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 int kexec_load_disabled;
 
-void crash_kexec(struct pt_regs *regs)
+/*
+ * No panic_cpu check version of crash_kexec().  This function is called
+ * only when panic_cpu holds the current CPU number; this is the only CPU
+ * which processes crash_kexec routines.
+ */
+void __crash_kexec(struct pt_regs *regs)
 {
 	/* Take the kexec_mutex here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
@@ -876,6 +881,29 @@ void crash_kexec(struct pt_regs *regs)
 	}
 }
 
+void crash_kexec(struct pt_regs *regs)
+{
+	int old_cpu, this_cpu;
+
+	/*
+	 * Only one CPU is allowed to execute the crash_kexec() code as with
+	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
+	 * may stop each other.  To exclude them, we use panic_cpu here too.
+	 */
+	this_cpu = raw_smp_processor_id();
+	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
+	if (old_cpu == PANIC_CPU_INVALID) {
+		/* This is the 1st CPU which comes here, so go ahead. */
+		__crash_kexec(regs);
+
+		/*
+		 * Reset panic_cpu to allow another panic()/crash_kexec()
+		 * call.
+		 */
+		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
+	}
+}
+
 size_t crash_get_memory_size(void)
 {
 	size_t size = 0;
diff --git a/kernel/panic.c b/kernel/panic.c
index 3d6c3f1..81a0a3d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -138,7 +138,7 @@ void panic(const char *fmt, ...)
 	 * the "crash_kexec_post_notifiers" option to the kernel.
 	 */
 	if (!crash_kexec_post_notifiers)
-		crash_kexec(NULL);
+		__crash_kexec(NULL); /* bypass panic_cpu check */
 
 	/*
 	 * Note smp_send_stop is the usual smp shutdown function, which
@@ -163,7 +163,7 @@ void panic(const char *fmt, ...)
 	 * more unstable, it can increase risks of the kdump failure too.
 	 */
 	if (crash_kexec_post_notifiers)
-		crash_kexec(NULL);
+		__crash_kexec(NULL); /* bypass panic_cpu check */
 
 	bust_spinlocks(0);
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
