Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cg9f9-00019C-Q6
 for kexec@lists.infradead.org; Tue, 21 Feb 2017 12:35:28 +0000
Subject: Re: [PATCH v2] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
References: <1487571037-10821-1-git-send-email-xlpang@redhat.com>
 <20170220110941.vwcm3je3e4kkei6o@pd.tnic>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58AC3481.80000@redhat.com>
Date: Tue, 21 Feb 2017 20:37:21 +0800
MIME-Version: 1.0
In-Reply-To: <20170220110941.vwcm3je3e4kkei6o@pd.tnic>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, Xunlei Pang <xlpang@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On 02/20/2017 at 07:09 PM, Borislav Petkov wrote:
> On Mon, Feb 20, 2017 at 02:10:37PM +0800, Xunlei Pang wrote:
>> @@ -1128,8 +1129,9 @@ void do_machine_check(struct pt_regs *regs, long error_code)
>>  	 */
>>  	int lmce = 1;
>>  
>> -	/* If this CPU is offline, just bail out. */
>> -	if (cpu_is_offline(smp_processor_id())) {
>> +	/* If nmi shootdown happened or this CPU is offline, just bail out. */
>> +	if (cpus_shotdown() ||
> I don't like "cpus_shotdown" - it doesn't hint at all that this is
> special-handling crash/kdump.
>
> And more importantly, I want it to be obvious that we do let the
> crashing CPU into the MCE handler.

Hi Boris,

I made some improvements, what do you think the following one?
If you think it is fine, I can send out v3. Thanks for your time!

---
 arch/x86/include/asm/reboot.h    |  1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 11 +++++++++--
 arch/x86/kernel/reboot.c         |  5 +++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 2cb1cc2..fc62ba8 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -15,6 +15,7 @@ struct machine_ops {
 };
 
 extern struct machine_ops machine_ops;
+extern int crashing_cpu;
 
 void native_machine_crash_shutdown(struct pt_regs *regs);
 void native_machine_shutdown(void);
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8e9725c..7f53145 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -49,6 +49,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/reboot.h>
 
 #include "mce-internal.h"
 
@@ -1128,8 +1129,14 @@ void do_machine_check(struct pt_regs *regs, long error_code)
      */
     int lmce = 1;
 
-    /* If this CPU is offline, just bail out. */
-    if (cpu_is_offline(smp_processor_id())) {
+    /*
+     * Cases to bail out to avoid rendezvous process timeout:
+     * 1)If crashing_cpu was set, e.g. entering kdump,
+     *   we need to skip cpus remaining in 1st kernel.
+     * 2)If this CPU is offline.
+     */
+    if (crashing_cpu != -1 ||
+        cpu_is_offline(smp_processor_id())) {
         u64 mcgstatus;
 
         mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index e244c19..92ecf4b 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -749,10 +749,11 @@ void machine_crash_shutdown(struct pt_regs *regs)
 #endif
 
 
+/* This keeps a track of which one is crashing cpu. */
+int crashing_cpu = -1;
+
 #if defined(CONFIG_SMP)
 
-/* This keeps a track of which one is crashing cpu. */
-static int crashing_cpu;
 static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
-- 
1.8.3.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
