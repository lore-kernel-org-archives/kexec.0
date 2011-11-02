Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RLXeS-0005Ny-Hy
	for kexec@lists.infradead.org; Wed, 02 Nov 2011 10:02:33 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id pA2A2PX9029184
	for <kexec@lists.infradead.org>; Wed, 2 Nov 2011 10:02:25 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id pA2A2OId2621492
	for <kexec@lists.infradead.org>; Wed, 2 Nov 2011 10:02:24 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain
	[127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id pA2A2NWv020738
	for <kexec@lists.infradead.org>; Wed, 2 Nov 2011 04:02:24 -0600
Message-ID: <1320228143.2776.12.camel@br98xy6r>
Subject: [PATCH] kdump: Add missing RAM resource in crash_shrink_memory()
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 02 Nov 2011 11:02:23 +0100
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

When shrinking crashkernel memory using /sys/kernel/kexec_crash_size for
the newly added memory no RAM resource is created at the moment.

Example:

$ cat /proc/iomem
00000000-bfffffff : System RAM
  00000000-005b7ac3 : Kernel code
  005b7ac4-009743bf : Kernel data
  009bb000-00a85c33 : Kernel bss
c0000000-cfffffff : Crash kernel
d0000000-ffffffff : System RAM

$ echo 0 > /sys/kernel/kexec_crash_size
$ cat /proc/iomem
00000000-bfffffff : System RAM
  00000000-005b7ac3 : Kernel code
  005b7ac4-009743bf : Kernel data
  009bb000-00a85c33 : Kernel bss
                                 <<-- here is System RAM missing
d0000000-ffffffff : System RAM

One result of this bug is that the memory chunk can never be set offline
using memory hotplug. With this patch I insert a new "System RAM" resource
for the released memory. Then the upper example looks like the following:

$ echo 0 > /sys/kernel/kexec_crash_size
$ cat /proc/iomem
00000000-bfffffff : System RAM
  00000000-005b7ac3 : Kernel code
  005b7ac4-009743bf : Kernel data
  009bb000-00a85c33 : Kernel bss
c0000000-cfffffff : System RAM   <<-- new rescoure
d0000000-ffffffff : System RAM

And now I can set chunk c0000000-cfffffff offline.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/kexec.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1132,6 +1132,7 @@ int crash_shrink_memory(unsigned long ne
 {
 	int ret = 0;
 	unsigned long start, end;
+	struct resource *ram_res;
 
 	mutex_lock(&kexec_mutex);
 
@@ -1149,6 +1150,12 @@ int crash_shrink_memory(unsigned long ne
 		goto unlock;
 	}
 
+	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
+	if (!ram_res) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
 	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
 	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
 
@@ -1157,7 +1164,15 @@ int crash_shrink_memory(unsigned long ne
 
 	if ((start == end) && (crashk_res.parent != NULL))
 		release_resource(&crashk_res);
+
+	ram_res->start = end;
+	ram_res->end = crashk_res.end;
+	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
+	ram_res->name = "System RAM";
+
 	crashk_res.end = end - 1;
+
+	insert_resource(&iomem_resource, ram_res);
 	crash_unmap_reserved_pages();
 
 unlock:



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
