Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ewKic-0003r2-1e
 for kexec@lists.infradead.org; Thu, 15 Mar 2018 04:42:27 +0000
Received: by mail-pf0-x244.google.com with SMTP id f80so2395408pfa.8
 for <kexec@lists.infradead.org>; Wed, 14 Mar 2018 21:42:11 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv5 2/3] powerpc,
 cpu: handling the special case when boot_cpuid greater than nr_cpus
Date: Thu, 15 Mar 2018 12:41:51 +0800
Message-Id: <1521088912-31742-3-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
References: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: cascardo@canonical.com, gpiccoli@linux.vnet.ibm.com, benh@kernel.crashing.org, kexec@lists.infradead.org, paulus@ozlabs.org, mpe@ellerman.id.au

For kexec -p, after boot_cpuid is mapping into the range of [0,
threads_per_core), then if nr_cpus is small, we will have the bitmap
[0,..., nr_cpus, ..., boot_cpuid, ...). This patch chooses cpus inside
the range of [boot_cpuid - nr_cpus +1, ..., boot_cpuid] to be online.

With this patch and the next, on a P9 machine with thread_per_core=4,
and set nr_cpus=2 for the crash kernel.
After
    taskset -c 11 sh -c "echo c > /proc/sysrq-trigger"
Then
    kdump:/sys/devices/system/cpu# cat possible
    2-3
    kdump:/sys/devices/system/cpu# cat present
    2-3
    kdump:/sys/devices/system/cpu# cat online
    2-3

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 arch/powerpc/kernel/setup-common.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index a683ed1..f3aaf9f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -468,6 +468,7 @@ void __init smp_setup_cpu_maps(void)
 	int online_num = 0;
 	int next_cpu = boot_dn_nthreads;
 	bool btdn_handled = false;
+	int first_threadid = 0;
 
 	DBG("smp_setup_cpu_maps()\n");
 
@@ -497,7 +498,12 @@ void __init smp_setup_cpu_maps(void)
 
 		if (boot_cpuid < nthreads &&
 			be32_to_cpu(intserv[boot_cpuid]) == boot_cpuhwid) {
-			cpu = 0;
+			/* choose a bunch of continous threads */
+			if (boot_cpuid > nr_cpu_ids - 1) {
+				first_threadid = boot_cpuid - nr_cpu_ids + 1;
+			}
+			/* keep the mapping of logical and thread */
+			cpu = first_threadid;
 			btdn_handled = true;
 		} else if ( !btdn_handled &&
 				nr_cpu_ids - online_num <= boot_dn_nthreads)
@@ -509,7 +515,8 @@ void __init smp_setup_cpu_maps(void)
 		}
 
 
-		for (j = 0; j < nthreads && online_num < nr_cpu_ids; j++) {
+		for (j = first_threadid;
+			j < nthreads && online_num < nr_cpu_ids; j++) {
 			bool avail;
 
 			DBG("    thread %d -> cpu %d (hard id %d)\n",
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
