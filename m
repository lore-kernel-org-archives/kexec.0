Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VYdSz-0005a8-A8
 for kexec@lists.infradead.org; Tue, 22 Oct 2013 15:01:55 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E8BDC3EE0C2
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:33 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C776745DE63
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:33 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8FAEA45DE5C
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:33 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6ABC41DB8045
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:33 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1076E1DB8052
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:33 +0900 (JST)
Subject: [PATCH v4 2/3] x86, apic: Add disable_cpu_apicid kernel parameter
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Wed, 23 Oct 2013 00:01:29 +0900
Message-ID: <20131022150129.24240.4607.stgit@localhost6.localdomain6>
In-Reply-To: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
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

This design is more flexible than disabling BSP in kernel boot time
automatically in that in kernel boot time we have no choice but
referring to ACPI/MP table to obtain initial APIC ID for BSP, meaning
that the method is not applicable to the systems without such BIOS
tables.

This is designed based on the assumption that users get initial APIC
ID of the BSP in still healthy state and so BSP is uniquely kept in
CPU0; so through this kernel parameter, only one initial APIC ID can
be specified.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 arch/x86/kernel/apic/apic.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a7eb82d..8cc4180 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -74,6 +74,13 @@ unsigned int max_physical_apicid;
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
@@ -2113,6 +2120,19 @@ void generic_processor_info(int apicid, int version)
 	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
 				phys_cpu_present_map);
 
+	if (disabled_cpu_apicid != BAD_APICID &&
+	    disabled_cpu_apicid != boot_cpu_physical_apicid &&
+	    disabled_cpu_apicid == apicid) {
+		int thiscpu = num_processors + disabled_cpus;
+
+		pr_warning("ACPI: Disable specified CPU."
+			   " Processor %d/0x%x ignored.\n",
+			   thiscpu, apicid);
+
+		disabled_cpus++;
+		return;
+	}
+
 	/*
 	 * If boot cpu has not been detected yet, then only allow upto
 	 * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
@@ -2589,3 +2609,12 @@ static int __init lapic_insert_resource(void)
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
