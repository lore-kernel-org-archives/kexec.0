Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IXrlj-0002HN-MN
	for kexec@lists.infradead.org; Wed, 19 Sep 2007 01:06:40 -0400
Subject: [IA64] Kexec: Remove vector from ia64_machine_kexec()
Date: Wed, 19 Sep 2007 14:02:20 +0900
From: Simon Horman <horms@verge.net.au>
Message-Id: <20070919050626.8A0024F811@tabatha.lab.ultramonkey.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc: Nan hai Zou <nanhai.zou@intel.com>, Tony Luck <tony.luck@intel.com>, Eric Biederman <ebiederm@xmission.com>, Alex Williamson <alex.williamson@hp.com>

The use of vector in ia64_machine_kexec() seems spurios,
and removing it simplifies the code slightly.

As suggested by Alex Williamson <alex.williamson@hp.com>

Cc: Alex Williamson <alex.williamson@hp.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/arch/ia64/kernel/machine_kexec.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/machine_kexec.c	2007-09-19 13:43:42.000000000 +0900
+++ linux-2.6/arch/ia64/kernel/machine_kexec.c	2007-09-19 13:44:11.000000000 +0900
@@ -79,7 +79,6 @@ static void ia64_machine_kexec(struct un
 	relocate_new_kernel_t rnk;
 	void *pal_addr = efi_get_pal_addr();
 	unsigned long code_addr = (unsigned long)page_address(image->control_code_page);
-	unsigned long vector;
 	int ii;
 
 	BUG_ON(!image);
@@ -107,11 +106,8 @@ static void ia64_machine_kexec(struct un
 	/* unmask TPR and clear any pending interrupts */
 	ia64_setreg(_IA64_REG_CR_TPR, 0);
 	ia64_srlz_d();
-	vector = ia64_get_ivr();
-	while (vector != IA64_SPURIOUS_INT_VECTOR) {
+	while (ia64_get_ivr() != IA64_SPURIOUS_INT_VECTOR)
 		ia64_eoi();
-		vector = ia64_get_ivr();
-	}
 	platform_kernel_launch_event();
 	rnk = (relocate_new_kernel_t)&code_addr;
 	(*rnk)(image->head, image->start, ia64_boot_param,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
