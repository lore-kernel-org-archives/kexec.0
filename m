Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZIBox-0005BK-Gh
 for kexec@lists.infradead.org; Thu, 23 Jul 2015 08:25:40 +0000
Received: by wicgb10 with SMTP id gb10so131806683wic.1
 for <kexec@lists.infradead.org>; Thu, 23 Jul 2015 01:25:17 -0700 (PDT)
Date: Thu, 23 Jul 2015 10:25:14 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 0/3] x86: Fix panic vs. NMI issues
Message-ID: <20150723082514.GC9386@dhcp22.suse.cz>
References: <20150722021421.5155.74460.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150722021421.5155.74460.stgit@softrs>
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
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hi,

On Wed 22-07-15 11:14:21, Hidehiro Kawai wrote:
> When an HA cluster software or administrator detects non-response
> of a host, they issue an NMI to the host to completely stop current
> works and take a crash dump.  If the kernel has already panicked
> or is capturing a crash dump at that time, further NMI can cause
> a crash dump failure.
> 
> To solve this issue, this patch set does two things:
> 
> - Don't panic on NMI if the kernel has already panicked
> - Introduce "noextnmi" boot option which masks external NMI at the
>   boot time (supported only for x86)

I am currently debugging the same issue for our customer. Curiously
enough the issue happens on a Hitachi HW.
I haven't posted my patch for an upstream review yet because I still
do not have a feedback but I believe your solution is unnecessarily
too complex. Unless I am missing something the following should be enough,
no?
---
From ba6ef85d26113e720a630ea22b08efef5b70210f Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.cz>
Date: Fri, 17 Jul 2015 15:17:08 +0200
Subject: [PATCH] kexec: Never return from crash_kexec when kexex is in
 progress

We had a report when kdump kernel hasn't booted after unknown NMI has
been delivered and unknown_nmi_panic is enabled. The NMI is triggered
by HW and it is delivered to all CPUs at the same time. The machine has
hundreds of CPUs and the most plausible theory is that one CPU really
manages to kick the kexec but it cannot shut down all the CPUs because
they are processing NMI and so cannot process an IPI. Another CPU then
manages to call smp_send_stop from a concurrent panic and this stops the
kexec CPU which has managed to switch to the new kernel and doesn't run
in the NMI mode anymore.

Fix this by making crash_kexec to never return if there is a kexec in
progress. This can be done easily by relying on the fact that
kexec_mutex will never be released for an ongoing kexec so we just have
to loop over the try lock. The only tricky part is that
kexec_crash_image might be not loaded when we have to return. The check
has to be done under the lock. Extract the trylock and check into
try_crash_kexec and make it return true only if crash kexec is disabled.

Signed-off-by: Michal Hocko <mhocko@suse.cz>
---
 kernel/kexec.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index a785c1015e25..d61b1478167d 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1470,7 +1470,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 #endif /* CONFIG_KEXEC_FILE */
 
-void crash_kexec(struct pt_regs *regs)
+static bool try_crash_kexec(struct pt_regs *regs)
 {
 	/* Take the kexec_mutex here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
@@ -1490,7 +1490,20 @@ void crash_kexec(struct pt_regs *regs)
 			machine_kexec(kexec_crash_image);
 		}
 		mutex_unlock(&kexec_mutex);
+		return true;
 	}
+	return false;
+}
+
+void crash_kexec(struct pt_regs *regs)
+{
+	/*
+	 * Never return from this function if a kexec is in progress
+	 * already because next steps might interfere with it.
+	 * try_crash_kexec will never succeed in such a case.
+	 */
+	while (!try_crash_kexec(regs))
+		cpu_relax();
 }
 
 size_t crash_get_memory_size(void)
-- 
2.1.4

-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
