Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZJahK-0000Qm-Qy
 for kexec@lists.infradead.org; Mon, 27 Jul 2015 05:11:38 +0000
Subject: [V2 PATCH 2/3] kexec: Fix race between panic() and crash_kexec()
 called directly
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Mon, 27 Jul 2015 10:58:50 +0900
Message-ID: <20150727015850.4928.15194.stgit@softrs>
In-Reply-To: <20150727015850.4928.87717.stgit@softrs>
References: <20150727015850.4928.87717.stgit@softrs>
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
Cc: linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

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
others by using atomic_t panicking_cpu.

V2:
- Use atomic_cmpxchg() instead of spin_trylock() on panic_lock
  to exclude concurrent accesses
- Don't introduce no-lock version of crash_kexec()

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/kexec.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index a785c10..ca40a19 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1472,6 +1472,18 @@ void __weak crash_unmap_reserved_pages(void)
 
 void crash_kexec(struct pt_regs *regs)
 {
+	int old_cpu, this_cpu;
+
+	/*
+	 * `old_cpu == -1' means we are the first comer and crash_kexec()
+	 * was called without entering panic().
+	 * `old_cpu == this_cpu' means crash_kexec() was called from panic().
+	 */
+	this_cpu = raw_smp_processor_id();
+	old_cpu = atomic_cmpxchg(&panicking_cpu, -1, this_cpu);
+	if (old_cpu != -1 && old_cpu != this_cpu)
+		return;
+
 	/* Take the kexec_mutex here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
 	 * we are using after a panic on a different cpu.
@@ -1491,6 +1503,14 @@ void crash_kexec(struct pt_regs *regs)
 		}
 		mutex_unlock(&kexec_mutex);
 	}
+
+	/*
+	 * If we came here from panic(), we have to keep panicking_cpu
+	 * to prevent other cpus from entering panic().  Otherwise,
+	 * resetting it so that other cpus can enter panic()/crash_kexec().
+	 */
+	if (old_cpu == this_cpu)
+		atomic_set(&panicking_cpu, -1);
 }
 
 size_t crash_get_memory_size(void)



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
