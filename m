Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OLtO9-00065m-9t
	for kexec@lists.infradead.org; Tue, 08 Jun 2010 07:38:22 +0000
Message-ID: <4C0DF36A.3080401@ozlabs.org>
Date: Tue, 08 Jun 2010 17:38:18 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
Subject: [PATCH] kexec, ppc64:  Wait for online/possible CPUs only.
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org

kexec_perpare_cpus_wait() iterates i through NR_CPUS to check
paca[i].kexec_state of each to make sure they have quiesced.
However now we have dynamic PACA allocation, paca[NR_CPUS] is not necessarily
valid and we overrun the array;  spurious "cpu is not possible, ignoring"
errors result.  This patch iterates for_each_online_cpu so stays
within the bounds of paca[] -- and every CPU is now 'possible'.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 arch/powerpc/kernel/machine_kexec_64.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 26f9900..ed31a29 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -182,28 +182,12 @@ static void kexec_prepare_cpus_wait(int wait_state)
 
 	my_cpu = get_cpu();
 	/* Make sure each CPU has atleast made it to the state we need */
-	for (i=0; i < NR_CPUS; i++) {
+	for_each_online_cpu(i) {
 		if (i == my_cpu)
 			continue;
 
 		while (paca[i].kexec_state < wait_state) {
 			barrier();
-			if (!cpu_possible(i)) {
-				printk("kexec: cpu %d hw_cpu_id %d is not"
-						" possible, ignoring\n",
-						i, paca[i].hw_cpu_id);
-				break;
-			}
-			if (!cpu_online(i)) {
-				/* Fixme: this can be spinning in
-				 * pSeries_secondary_wait with a paca
-				 * waiting for it to go online.
-				 */
-				printk("kexec: cpu %d hw_cpu_id %d is not"
-						" online, ignoring\n",
-						i, paca[i].hw_cpu_id);
-				break;
-			}
 			if (i != notified) {
 				printk( "kexec: waiting for cpu %d (physical"
 						" %d) to enter %i state\n",
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
