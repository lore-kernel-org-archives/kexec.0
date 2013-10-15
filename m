Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVxQ4-0005ED-ET
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 05:43:49 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 41F523EE1D8
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:23 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2F38845DEBE
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:23 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1686245DEB7
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:23 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0A3881DB8043
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:23 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id B3A741DB803C
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:22 +0900 (JST)
Subject: [PATCH v2 1/2] x86,
 apic: Add boot_cpu_is_bsp() to check if boot cpu is BSP
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Tue, 15 Oct 2013 14:43:22 +0900
Message-ID: <20131015054322.13666.31465.stgit@localhost6.localdomain6>
In-Reply-To: <20131015054214.13666.11737.stgit@localhost6.localdomain6>
References: <20131015054214.13666.11737.stgit@localhost6.localdomain6>
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
To: hpa@linux.intel.com, ebiederm@xmission.com, vgoyal@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, akpm@linux-foundation.org, fengguang.wu@intel.com, jingbai.ma@hp.com

Kexec can enter the kdump 2nd kernel on AP if crash happens on AP. To
check if boot cpu is BSP, introduce a helper function
boot_cpu_is_bsp().

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 arch/x86/include/asm/mpspec.h |    7 +++++++
 arch/x86/kernel/apic/apic.c   |   16 ++++++++++++++++
 arch/x86/kernel/setup.c       |    2 ++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 626cf70..54d5f98 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -47,11 +47,18 @@ extern int mp_bus_id_to_type[MAX_MP_BUSSES];
 extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 
 extern unsigned int boot_cpu_physical_apicid;
+extern bool boot_cpu_is_bsp;
 extern unsigned int max_physical_apicid;
 extern int mpc_default_type;
 extern unsigned long mp_lapic_addr;
 
 #ifdef CONFIG_X86_LOCAL_APIC
+extern void boot_cpu_is_bsp_init(void);
+#else
+static inline void boot_cpu_is_bsp_init(void) { };
+#endif
+
+#ifdef CONFIG_X86_LOCAL_APIC
 extern int smp_found_config;
 #else
 # define smp_found_config 0
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a7eb82d..62ee365 100644
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
@@ -2589,3 +2595,13 @@ static int __init lapic_insert_resource(void)
  * that is using request_resource
  */
 late_initcall(lapic_insert_resource);
+
+void __init boot_cpu_is_bsp_init(void)
+{
+	if (cpu_has_apic) {
+		u32 l, h;
+
+		rdmsr_safe(MSR_IA32_APICBASE, &l, &h);
+		boot_cpu_is_bsp = (l & MSR_IA32_APICBASE_BSP) ? true : false;
+	}
+}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f0de629..a30bc06 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
 
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
