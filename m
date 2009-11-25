Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NDHkv-00053H-Iv
	for kexec@lists.infradead.org; Wed, 25 Nov 2009 13:18:06 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp01.in.ibm.com (8.14.3/8.13.1) with ESMTP id nAPDHuJR022749
	for <kexec@lists.infradead.org>; Wed, 25 Nov 2009 18:47:56 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAPDHuVM3567792
	for <kexec@lists.infradead.org>; Wed, 25 Nov 2009 18:47:56 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAPDHtHX006069
	for <kexec@lists.infradead.org>; Wed, 25 Nov 2009 18:47:56 +0530
Date: Wed, 25 Nov 2009 18:47:47 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: [PATCH] Reserve memory for kdump kernel within RMO region
Message-ID: <20091125131747.GA28857@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: mohan@in.ibm.com
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
To: benh@kernel.crashing.org, ppcdev <linuxppc-dev@ozlabs.org>
Cc: michael@ellerman.id.au, kexec@lists.infradead.org

Reserve memory for kdump kernel within RMO region

When the kernel size exceeds 32MB(observed with some distros), memory
for kdump kernel can not be reserved as kdump kernel base is assumed to
be 32MB always. When the kernel has CONFIG_RELOCATABLE option enabled,
provide the feature to reserve the memory for kdump kernel anywhere in
the RMO region.

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 arch/powerpc/kernel/machine_kexec.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index baf1af0..99b2f9f 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -140,10 +140,29 @@ void __init reserve_crashkernel(void)
 
 	/* The crash region must not overlap the current kernel */
 	if (overlaps_crashkernel(__pa(_stext), _end - _stext)) {
+#ifdef CONFIG_RELOCATABLE
+		do {
+			/* Align kdump kernel to 16MB (size of large page) */
+			crashk_res.start = ALIGN(crashk_res.start +
+						(16 * 1024 * 1024), 0x1000000);
+			if (crashk_res.start + (_stext - _end) > lmb.rmo_size) {
+				printk(KERN_WARNING
+					"Not enough memory for crash kernel\n");
+				crashk_res.start = crashk_res.end = 0;
+				return;
+			}
+		} while (overlaps_crashkernel(__pa(_stext), _end - _stext));
+
+		crashk_res.end = crashk_res.start + crash_size - 1;
+		printk(KERN_INFO
+			"crash kernel memory overlaps with kernel memory\n"
+			"Moving it to %lx\n", (unsigned long)crashk_res.start);
+#else
 		printk(KERN_WARNING
 			"Crash kernel can not overlap current kernel\n");
 		crashk_res.start = crashk_res.end = 0;
 		return;
+#endif
 	}
 
 	/* Crash kernel trumps memory limit */
-- 
1.5.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
