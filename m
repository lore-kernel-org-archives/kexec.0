Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2RlB-0006e3-0c
 for kexec@lists.infradead.org; Tue, 27 Aug 2019 03:03:06 +0000
Received: by mail-pg1-x541.google.com with SMTP id d1so11779433pgp.4
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 20:03:04 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv2 2/4] x86/apic: record capped cpu in generic_processor_info()
Date: Tue, 27 Aug 2019 11:02:21 +0800
Message-Id: <1566874943-4449-3-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Daniel Drake <drake@endlessm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Qian Cai <cai@lca.pw>, Dave Young <dyoung@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Eric Biederman <ebiederm@xmission.com>

No matter the cpu is capped by nr_cpus option, recording the mapping
between all cpus' id and apic id

Later this mapping will be used by BSP to sent SIPI to bring capped cpu to
stable state

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
---
 arch/x86/include/asm/smp.h   |  2 ++
 arch/x86/kernel/apic/apic.c  | 21 +++++++++++++++------
 arch/x86/kernel/cpu/common.c |  4 ++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e1356a3..5f63399 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -196,5 +196,7 @@ extern void nmi_selftest(void);
 #define nmi_selftest() do { } while (0)
 #endif
 
+extern struct cpumask *cpu_capped_mask;
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_SMP_H */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f4f603a..6a57bad3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2296,9 +2296,10 @@ static int allocate_logical_cpuid(int apicid)
 
 int generic_processor_info(int apicid, int version)
 {
-	int cpu, max = nr_cpu_ids;
+	int thiscpu, cpu, max = nr_cpu_ids;
 	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
 				phys_cpu_present_map);
+	bool capped = false;
 
 	/*
 	 * boot_cpu_physical_apicid is designed to have the apicid
@@ -2322,7 +2323,7 @@ int generic_processor_info(int apicid, int version)
 	if (disabled_cpu_apicid != BAD_APICID &&
 	    disabled_cpu_apicid != read_apic_id() &&
 	    disabled_cpu_apicid == apicid) {
-		int thiscpu = num_processors + disabled_cpus;
+		thiscpu = num_processors + disabled_cpus;
 
 		pr_warning("APIC: Disabling requested cpu."
 			   " Processor %d/0x%x ignored.\n",
@@ -2338,7 +2339,7 @@ int generic_processor_info(int apicid, int version)
 	 */
 	if (!boot_cpu_detected && num_processors >= nr_cpu_ids - 1 &&
 	    apicid != boot_cpu_physical_apicid) {
-		int thiscpu = max + disabled_cpus - 1;
+		thiscpu = max + disabled_cpus - 1;
 
 		pr_warning(
 			"APIC: NR_CPUS/possible_cpus limit of %i almost"
@@ -2346,20 +2347,28 @@ int generic_processor_info(int apicid, int version)
 			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
 
 		disabled_cpus++;
-		return -EINVAL;
+		capped = true;
 	}
 
 	if (num_processors >= nr_cpu_ids) {
-		int thiscpu = max + disabled_cpus;
+		thiscpu = max + disabled_cpus;
 
 		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
 			   "reached. Processor %d/0x%x ignored.\n",
 			   max, thiscpu, apicid);
 
 		disabled_cpus++;
-		return -EINVAL;
+		capped = true;
 	}
 
+	if (capped) {
+		/* record the mapping between capped cpu and apicid */
+		if (thiscpu < NR_CPUS && cpu_capped_mask != NULL) {
+			cpuid_to_apicid[thiscpu] = apicid;
+			cpumask_set_cpu(thiscpu, cpu_capped_mask);
+		}
+		return -EINVAL;
+	}
 	if (apicid == boot_cpu_physical_apicid) {
 		/*
 		 * x86_bios_cpu_apicid is required to have processors listed
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1147217..b95721e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -66,6 +66,9 @@ u32 elf_hwcap2 __read_mostly;
 cpumask_var_t cpu_initialized_mask;
 cpumask_var_t cpu_callout_mask;
 cpumask_var_t cpu_callin_mask;
+/* size of NR_CPUS is required. */
+static struct cpumask __cpu_capped_mask __initdata;
+struct cpumask *cpu_capped_mask;
 
 /* representing cpus for which sibling maps can be computed */
 cpumask_var_t cpu_sibling_setup_mask;
@@ -84,6 +87,7 @@ void __init setup_cpu_local_masks(void)
 	alloc_bootmem_cpumask_var(&cpu_callin_mask);
 	alloc_bootmem_cpumask_var(&cpu_callout_mask);
 	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
+	cpu_capped_mask = &__cpu_capped_mask;
 }
 
 static void default_init(struct cpuinfo_x86 *c)
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
