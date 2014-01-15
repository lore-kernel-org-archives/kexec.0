Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3KEA-0004IB-Vy
 for kexec@lists.infradead.org; Wed, 15 Jan 2014 06:45:28 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A68C23EE1D0
 for <kexec@lists.infradead.org>; Wed, 15 Jan 2014 15:44:59 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 96CF045DE4D
 for <kexec@lists.infradead.org>; Wed, 15 Jan 2014 15:44:59 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7E7C045DE4C
 for <kexec@lists.infradead.org>; Wed, 15 Jan 2014 15:44:59 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 71E5AE08001
 for <kexec@lists.infradead.org>; Wed, 15 Jan 2014 15:44:59 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 14F451DB803F
 for <kexec@lists.infradead.org>; Wed, 15 Jan 2014 15:44:59 +0900 (JST)
Subject: [RESEND PATCH v10] x86, apic, kexec,
 Documentation: Add disable_cpu_apicid kernel parameter
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Wed, 15 Jan 2014 15:44:58 +0900
Message-ID: <20140115064458.1545.38775.stgit@localhost6.localdomain6>
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
To: hpa@linux.intel.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, fengguang.wu@intel.com, jingbai.ma@hp.com

Add disable_cpu_apicid kernel parameter. To use this kernel parameter,
specify an initial APIC ID of the corresponding CPU you want to
disable.

This is mostly used for the kdump 2nd kernel to disable BSP to wake up
multiple CPUs without causing system reset or hang due to sending INIT
from AP to BSP.

Kdump users first figure out initial APIC ID of the BSP, CPU0 in the
1st kernel, for example from /proc/cpuinfo and then set up this kernel
parameter for the 2nd kernel using the obtained APIC ID.

However, doing this procedure at each boot time manually is awkward,
which should be automatically done by user-land service scripts, for
example, kexec-tools on fedora/RHEL distributions.

This design is more flexible than disabling BSP in kernel boot time
automatically in that in kernel boot time we have no choice but
referring to ACPI/MP table to obtain initial APIC ID for BSP, meaning
that the method is not applicable to the systems without such BIOS
tables.

One assumption behind this design is that users get initial APIC ID of
the BSP in still healthy state and so BSP is uniquely kept in
CPU0. Thus, through the kernel parameter, only one initial APIC ID can
be specified.

In a comparison with disabled_cpu_apicid, we use read_apic_id(), not
boot_cpu_physical_apicid, because on some platforms, the variable is
modified to the apicid reported as BSP through MP table and this
function is executed with the temporarily modified
boot_cpu_physical_apicid. As a result, disabled_cpu_apicid kernel
parameter doesn't work well for apicids of APs.

Fixing the wrong handling of boot_cpu_physical_apicid requires some
reviews and tests beyond some platforms and it could take some
time. The fix here is a kind of workaround to focus on the main topic
of this patch.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 Documentation/kernel-parameters.txt |    9 ++++++
 arch/x86/kernel/apic/apic.c         |   49 +++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 50680a5..4e5528c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -774,6 +774,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	disable=	[IPV6]
 			See Documentation/networking/ipv6.txt.
 
+	disable_cpu_apicid= [X86,APIC,SMP]
+			Format: <int>
+			The number of initial APIC ID for the
+			corresponding CPU to be disabled at boot,
+			mostly used for the kdump 2nd kernel to
+			disable BSP to wake up multiple CPUs without
+			causing system reset or hang due to sending
+			INIT from AP to BSP.
+
 	disable_ddw     [PPC/PSERIES]
 			Disable Dynamic DMA Window support. Use this if
 			to workaround buggy firmware.
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d278736..6c0b7d5 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -75,6 +75,13 @@ unsigned int max_physical_apicid;
 physid_mask_t phys_cpu_present_map;
 
 /*
+ * Processor to be disabled specified by kernel parameter
+ * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
+ * avoid undefined behaviour caused by sending INIT from AP to BSP.
+ */
+unsigned int disabled_cpu_apicid = BAD_APICID;
+
+/*
  * Map cpu index to physical APIC ID
  */
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
@@ -2115,6 +2122,39 @@ int generic_processor_info(int apicid, int version)
 				phys_cpu_present_map);
 
 	/*
+	 * boot_cpu_physical_apicid is designed to have the apicid
+	 * returned by read_apic_id(), i.e, the apicid of the
+	 * currently booting-up processor. However, on some platforms,
+	 * it is temporarilly modified by the apicid reported as BSP
+	 * through MP table. Concretely:
+	 *
+	 * - arch/x86/kernel/mpparse.c: MP_processor_info()
+	 * - arch/x86/mm/amdtopology.c: amd_numa_init()
+	 * - arch/x86/platform/visws/visws_quirks.c: MP_processor_info()
+	 *
+	 * This function is executed with the modified
+	 * boot_cpu_physical_apicid. So, disabled_cpu_apicid kernel
+	 * parameter doesn't work to disable APs on kdump 2nd kernel.
+	 *
+	 * Since fixing handling of boot_cpu_physical_apicid requires
+	 * another discussion and tests on each platform, we leave it
+	 * for now and here we use read_apic_id() directly in this
+	 * function, generic_processor_info().
+	 */
+	if (disabled_cpu_apicid != BAD_APICID &&
+	    disabled_cpu_apicid != read_apic_id() &&
+	    disabled_cpu_apicid == apicid) {
+		int thiscpu = num_processors + disabled_cpus;
+
+		pr_warning("ACPI: Disabling requested cpu."
+			   " Processor %d/0x%x ignored.\n",
+			   thiscpu, apicid);
+
+		disabled_cpus++;
+		return -ENODEV;
+	}
+
+	/*
 	 * If boot cpu has not been detected yet, then only allow upto
 	 * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
 	 */
@@ -2592,3 +2632,12 @@ static int __init lapic_insert_resource(void)
  * that is using request_resource
  */
 late_initcall(lapic_insert_resource);
+
+static int __init apic_set_disabled_cpu_apicid(char *arg)
+{
+	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
+		return -EINVAL;
+
+	return 0;
+}
+early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
