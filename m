Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHTM5-000745-U1
 for kexec@lists.infradead.org; Mon, 18 Mar 2013 06:15:36 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 111123EE0BB
 for <kexec@lists.infradead.org>; Mon, 18 Mar 2013 15:15:27 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id EAA6545DE55
 for <kexec@lists.infradead.org>; Mon, 18 Mar 2013 15:15:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D02B045DE50
 for <kexec@lists.infradead.org>; Mon, 18 Mar 2013 15:15:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id BF25A1DB8038
 for <kexec@lists.infradead.org>; Mon, 18 Mar 2013 15:15:26 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 57E521DB803F
 for <kexec@lists.infradead.org>; Mon, 18 Mar 2013 15:15:26 +0900 (JST)
Date: Mon, 18 Mar 2013 15:14:11 +0900 (JST)
Message-Id: <20130318.151411.239980862.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] x86, apic: Add unset_bsp parameter to unset BSP flag at
 boot time
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
To: ebiederm@xmission.com, vgoyal@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

This is the 2nd step to make multiple CPUs runnable on the kdump 2nd
kernel. The 1st step is:

  [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
  http://lists.infradead.org/pipermail/kexec/2012-October/006905.html

where I'm trying to disable BSP CPU if the boot CPU on the 2nd kernel
doesn't have MSR's BSP flag set. The problem is that there's no
gurantee that all the firmware puts the entry for BSP in the first
position.

Instead, this patch unsets BSP flag in the 1st kernel's boot
time. This logic is suggested by Eric Biederman. The unsetting is done
if unset_bsp kernel option is specified.

However, this is still an experimental patch. The unsetting BSP can
affect some kernel component, module or firmware that expect BSP flag
to be kept set throughtout runtime. In other words, the purpose of
this patch is to reveal whether there's actually such components in
these layers.

Note also that apart from the dependency to BSP flag of such
components, on inconsistent system state, it's already impossible to
treat this issue perfectly within kernel logic only since the issue
depends on processor, entity outside of the kernel.

For example, imagine the case where some buffer overrun happens and it
rewrites some bytes in the middle of machine_kexec() into rdmsr
instruction... This means that any CPUs including AP can have BSP flag
set at runtime.

In conclusion, we need to use multiple CPUs at the cost of loosing
some kind of the bugs kdump framework can cover now.

Test:

- Build on top of 3.9-rc3, x86_64.
- I used FUJITSU PRIMERGY RX600 S6. it looks working file for some
  hours.

Review points I expect:

- How to find components that depend on BSP flag? What kind of kernel
  operations are expecting BSP flag to be kept set?

- How to reach point for comprimise of this issue?

  I think there's no method to work well on every environment. So
  setting kernel parameter on each specific environemnt seems
  preferable.

From abf3c7525dd31bae77435c652037d5b65c645b2f Mon Sep 17 00:00:00 2001
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Fri, 15 Mar 2013 16:28:01 +0900
Subject: [PATCH] x86, apic: Add unset_bsp parameter to unset BSP flag at boot
 time

On crash dump, multiple CPUs are useful for CPU-bound processing like
compression and even for IO-bound processing like disk IO to make
improvement of IO-multiplication proportional to the number of disks.

However, we cannot wakeup the 2nd and later cpus in the kdump 2nd
kernel now if crash happens on AP. If crash happens on AP, kexec
enters the 2nd kernel with the AP, and there BSP in the 1st kernel is
expected to be haling in the 1st kernel or possibly in any fatal
system error state.

To wake up CPUs, we use the method called INIT-INIT-SIPI. But, INIT to
the CPU with BSP flag set causes it to jump into BIOS init code. A
typical visible behaviour is system hang or immediate system reset,
depending on the BIOS init code.

AP can be initiated by INIT even in a fatal state: MP spec explains
that processor-specific INIT can be used to recover AP from a fatal
system error. On the other hand, there's no method for the CPU with
BSP flag set to recover.

This patch add unset_bsp kernel parameter and if it's specified, BSP
flag of boot CPU is unset, expecting all the CPUS to keep BSP unset
throught runtime.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 arch/x86/include/asm/apic.h |    3 +++
 arch/x86/kernel/apic/apic.c |   25 +++++++++++++++++++++++++
 arch/x86/kernel/setup.c     |    2 ++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3388034..b9cd9a9 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -262,6 +262,8 @@ static inline int apic_is_clustered_box(void)
 
 extern int setup_APIC_eilvt(u8 lvt_off, u8 vector, u8 msg_type, u8 mask);
 
+extern void do_unset_bsp_flag(void);
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
@@ -269,6 +271,7 @@ static inline void init_apic_mappings(void) { }
 static inline void disable_local_APIC(void) { }
 # define setup_boot_APIC_clock x86_init_noop
 # define setup_secondary_APIC_clock x86_init_noop
+static inline void unset_bsp_flag(void) { }
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 904611b..a34bd75 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2544,3 +2544,28 @@ static int __init lapic_insert_resource(void)
  * that is using request_resource
  */
 late_initcall(lapic_insert_resource);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+static int unset_bsp_flag __initdata;
+
+void __init do_unset_bsp_flag(void)
+{
+	if (!unset_bsp_flag)
+		return;
+
+	if (cpu_has_apic) {
+		u32 l, h;
+
+		rdmsr_safe(MSR_IA32_APICBASE, &l, &h);
+		l &= ~MSR_IA32_APICBASE_BSP;
+		wrmsr_safe(MSR_IA32_APICBASE, l, h);
+	}
+}
+
+static int __init parse_unset_bsp(char *arg)
+{
+	unset_bsp_flag = 1;
+	return 0;
+}
+early_param("unset_bsp", parse_unset_bsp);
+#endif
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 90d8cc9..62a5f2e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1165,6 +1165,8 @@ void __init setup_arch(char **cmdline_p)
 	if (x86_io_apic_ops.init)
 		x86_io_apic_ops.init();
 
+	do_unset_bsp_flag();
+
 	kvm_guest_init();
 
 	e820_reserve_resources();
-- 
1.7.7.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
