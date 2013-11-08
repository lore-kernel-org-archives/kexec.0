Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Venls-0006nT-6F
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 15:14:53 +0000
Date: Fri, 8 Nov 2013 10:14:16 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86: make reboot task only run on the appropriate
 processor
Message-ID: <20131108151416.GA13068@redhat.com>
References: <1383642967-12595-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383642967-12595-1-git-send-email-bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: Robin Holt <robinmholt@gmail.com>, mwhitehe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Robin Holt <robinmholt@linux.com>, davej@fedoraproject.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, rmk+kernel@arm.linux.org.uk, tglx@linutronix.de, akpm@linux-foundation.org, chaowang@redhat.com

On Tue, Nov 05, 2013 at 05:16:07PM +0800, Baoquan He wrote:
> Currently system always reboot after below message when execute "kexec -e".
> 
> [    0.572119] smpboot: Booting Node   0, Processors  #   1 OK
> 
> In commit 1b3a5d02ee070c8f9943333b9b6370f486601e0f, reboot= handling was
> moved to kerne/reboot.c. However, the code to migrate current thread to
> reboot cpu was removed. That cause this incorrect kexec behavior.
> 
> Now add that code block back.
> 
> Reported-by: Matthew Whitehead <mwhitehe@redhat.com>
> Reported-by: Dave Young <dyoung@redhat.com>
> Tested-by: WANG Chao <chaowang@redhat.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Hi Bao,

This patch fixes the issue for me too. I noticed that we have generic
function migrate_to_reboot_cpu() to achieve what we want and rest of
the reboot paths are using it. So how about using that function. I 
wrote the new patch below. It works for me. Can you please give it
a try.

Thanks
Vivek

kexec: migrate to reboot cpu

Commit 1b3a5d02ee070c8f9943333b9b6370f486601e0f moved reboot= handling to
generic code. In the process it also removed the code in
native_machine_shutdown() which are moving reboot process to reboot_cpu/cpu0.

I guess that thought must have been that all reboot paths are calling
migrate_to_reboot_cpu(), so we don't need this special handling. But
kexec reboot path (kernel_kexec()) is not calling migrate_to_reboot_cpu()
so above change broke kexec. Now reboot can happen on non-boot cpu and when
INIT is sent in second kerneo to bring up BP, it brings down the machine.

So start calling migrate_to_reboot_cpu() in kexec reboot path to avoid
this problem.

Reported-by: Matthew Whitehead <mwhitehe@redhat.com>
Reported-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 include/linux/reboot.h |    1 +
 kernel/kexec.c         |    1 +
 kernel/reboot.c        |    2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/reboot.c
===================================================================
--- linux-2.6.orig/kernel/reboot.c	2013-10-16 00:30:50.000000000 -0400
+++ linux-2.6/kernel/reboot.c	2013-11-08 21:31:03.379064848 -0500
@@ -104,7 +104,7 @@ int unregister_reboot_notifier(struct no
 }
 EXPORT_SYMBOL(unregister_reboot_notifier);
 
-static void migrate_to_reboot_cpu(void)
+void migrate_to_reboot_cpu(void)
 {
 	/* The boot cpu is always logical cpu 0 */
 	int cpu = reboot_cpu;
Index: linux-2.6/include/linux/reboot.h
===================================================================
--- linux-2.6.orig/include/linux/reboot.h	2013-11-08 21:33:27.000000000 -0500
+++ linux-2.6/include/linux/reboot.h	2013-11-08 21:34:29.778073522 -0500
@@ -43,6 +43,7 @@ extern int unregister_reboot_notifier(st
  * Architecture-specific implementations of sys_reboot commands.
  */
 
+extern void migrate_to_reboot_cpu(void);
 extern void machine_restart(char *cmd);
 extern void machine_halt(void);
 extern void machine_power_off(void);
Index: linux-2.6/kernel/kexec.c
===================================================================
--- linux-2.6.orig/kernel/kexec.c	2013-10-16 00:30:50.000000000 -0400
+++ linux-2.6/kernel/kexec.c	2013-11-08 21:34:02.492072375 -0500
@@ -1676,6 +1676,7 @@ int kernel_kexec(void)
 #endif
 	{
 		kernel_restart_prepare(NULL);
+		migrate_to_reboot_cpu();
 		printk(KERN_EMERG "Starting new kernel\n");
 		machine_shutdown();
 	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
