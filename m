Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEyWe-0005TR-GI
 for kexec@lists.infradead.org; Thu, 29 Aug 2013 09:28:25 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A1BC73EE0C1
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:28:00 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 94B5745DE54
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:28:00 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 78F6D45DE55
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:28:00 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6C1671DB8047
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:28:00 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 18897E08001
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:28:00 +0900 (JST)
Subject: [PATCH 1/2] x86,
 apic: Add boot_cpu_is_bsp() to check if boot cpu is BSP
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Thu, 29 Aug 2013 18:27:58 +0900
Message-ID: <20130829092758.5476.90694.stgit@localhost6.localdomain6>
In-Reply-To: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: ebiederm@xmission.com, vgoyal@redhat.com
Cc: akpm@linux-foundation.org, hpa@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jingbai.ma@hp.com

Kexec can enter the kdump 2nd kernel on AP if crash happens on AP. To
check if boot cpu is BSP, introduce a helper function
boot_cpu_is_bsp().

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 arch/x86/include/asm/mpspec.h |    3 +++
 arch/x86/kernel/apic/apic.c   |   14 ++++++++++++++
 arch/x86/kernel/setup.c       |    2 ++
 3 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 626cf70..a8a4338 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -47,10 +47,13 @@ extern int mp_bus_id_to_type[MAX_MP_BUSSES];
 extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 
 extern unsigned int boot_cpu_physical_apicid;
+extern bool boot_cpu_is_bsp;
 extern unsigned int max_physical_apicid;
 extern int mpc_default_type;
 extern unsigned long mp_lapic_addr;
 
+extern void boot_cpu_is_bsp_init(void);
+
 #ifdef CONFIG_X86_LOCAL_APIC
 extern int smp_found_config;
 #else
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index eca89c5..66cab35 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -64,6 +64,12 @@ unsigned disabled_cpus;
 unsigned int boot_cpu_physical_apicid = -1U;
 
 /*
+ * Indicates whether the processor that is doing the boot up, is BSP
+ * processor or not.
+ */
+bool boot_cpu_is_bsp;
+
+/*
  * The highest APIC ID seen during enumeration.
  */
 unsigned int max_physical_apicid;
@@ -2589,3 +2595,11 @@ static int __init lapic_insert_resource(void)
  * that is using request_resource
  */
 late_initcall(lapic_insert_resource);
+
+void boot_cpu_is_bsp_init(void)
+{
+	u32 l, h;
+
+	rdmsr(MSR_IA32_APICBASE, l, h);
+	boot_cpu_is_bsp = (l & MSR_IA32_APICBASE_BSP) ? true : false;
+}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f8ec578..f47f716 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1169,6 +1169,8 @@ void __init setup_arch(char **cmdline_p)
 
 	early_quirks();
 
+	boot_cpu_is_bsp_init();
+
 	/*
 	 * Read APIC and some other early information from ACPI tables.
 	 */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
