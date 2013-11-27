Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlURE-00065I-C2
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 02:01:14 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 724653EE164
 for <kexec@lists.infradead.org>; Wed, 27 Nov 2013 11:00:49 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6016245DE68
 for <kexec@lists.infradead.org>; Wed, 27 Nov 2013 11:00:49 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 418B945DE66
 for <kexec@lists.infradead.org>; Wed, 27 Nov 2013 11:00:49 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2E9EF1DB8032
 for <kexec@lists.infradead.org>; Wed, 27 Nov 2013 11:00:49 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id CFB3A1DB803B
 for <kexec@lists.infradead.org>; Wed, 27 Nov 2013 11:00:48 +0900 (JST)
Subject: [PATCH v7 1/2] x86, apic: Add disable_cpu_apicid kernel parameter
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Wed, 27 Nov 2013 11:00:48 +0900
Message-ID: <20131127020048.1493.43123.stgit@localhost6.localdomain6>
In-Reply-To: <20131127020006.1493.86091.stgit@localhost6.localdomain6>
References: <20131127020006.1493.86091.stgit@localhost6.localdomain6>
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

boot_cpu_physical_apicid is designed to have the apicid returned by
read_apic_id(). However, on some platforms, it is temporarilly
modified by the apicid reported as BSP through MP table. This function
is called with the modified boot_cpu_physical_apicid.

On the platforms, boot_cpu_physical_apicid is always forced to be the
apicid of the BSP. Then, disabled_cpu_apicid kernel parameter doesn't
work well for apicids for APs.

Here we leave improvement of handling boot_cpu_physical_apicid as
another work for now since the temporary modification is done on
differnet platforms and tests on each platform are required. As a
workaround, we directly update boot_cpu_physical_apicid by
read_apic_id().

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 arch/x86/kernel/apic/apic.c |   49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d278736..a94f618 100644
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
@@ -2111,9 +2118,42 @@ void disconnect_bsp_APIC(int virt_wire_setup)
 int generic_processor_info(int apicid, int version)
 {
 	int cpu, max = nr_cpu_ids;
+	/*
+	 * boot_cpu_physical_apicid is designed to have the apicid
+	 * returned by read_apic_id(). However, on some platforms, it
+	 * is temporarilly modified by the apicid reported as BSP
+	 * through MP table. Concretely:
+	 *
+	 * - arch/x86/kernel/mpparse.c: MP_processor_info()
+	 * - arch/x86/mm/amdtopology.c: amd_numa_init()
+	 * - arch/x86/platform/visws/visws_quirks.c: MP_processor_info()
+	 *
+	 * This function is executed with the modified
+	 * boot_cpu_physical_apicid. So, disabled_cpu_apicid kernel
+	 * parameter doesn't work.
+	 *
+	 * Since fixing handling of boot_cpu_physical_apicid requires
+	 * another discussion and tests on each platform, we leave it
+	 * for now and here we use read_apic_id() directly by updating
+	 * global scope of boot_cpu_physical_id with the local one.
+	 */
+	unsigned int boot_cpu_physical_apicid = read_apic_id();
 	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
 				phys_cpu_present_map);
 
+	if (disabled_cpu_apicid != BAD_APICID &&
+	    disabled_cpu_apicid != boot_cpu_physical_apicid &&
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
 	/*
 	 * If boot cpu has not been detected yet, then only allow upto
 	 * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
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
