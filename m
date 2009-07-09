Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MOoeU-0005wZ-NO
	for kexec@lists.infradead.org; Thu, 09 Jul 2009 08:06:53 +0000
Message-ID: <4A55A4AE.3000206@mxs.nes.nec.co.jp>
Date: Thu, 09 Jul 2009 17:05:02 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH] kdump: Enable kdump if 2nd-kernel is loaded.
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: kexec-ml <kexec@lists.infradead.org>


Hi,

This patch enables a kdump if 2nd-kernel is loaded.
(The patch is based on linux-2.6.31-rc2.)

Now, a kdump is enabled if a kernel parameter "oops=panic" is specified and
2nd-kernel is loaded. I think that a kdump should be enabled regardless of
"oops=panic" if 2nd-kernel is loaded, because a system administrator loads
2nd-kernel for enabling a kdump.

* Reference
  The discussion about this patch
  http://lists.infradead.org/pipermail/kexec/2009-July/003417.html


Thanks
Ken'ichi Ohmichi

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Acked-by: Simon Horman <horms@verge.net.au>
---
--- a/kernel/kexec.c	2009-07-08 12:30:26.000000000 +0900
+++ b/kernel/kexec.c	2009-07-08 12:38:08.000000000 +0900
@@ -57,6 +57,8 @@ struct resource crashk_res = {
 
 int kexec_should_crash(struct task_struct *p)
 {
+	if (kexec_crash_image)
+		return 1;
 	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
 		return 1;
 	return 0;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
