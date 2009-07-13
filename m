Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MQG6i-0005w8-22
	for kexec@lists.infradead.org; Mon, 13 Jul 2009 07:37:58 +0000
Message-ID: <4A5AB903.6090204@mxs.nes.nec.co.jp>
Date: Mon, 13 Jul 2009 13:33:07 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH-v2] kdump: Enable kdump if 2nd-kernel is loaded.
References: <4A55A4AE.3000206@mxs.nes.nec.co.jp>
	<4A56E069.5040907@jp.fujitsu.com>
In-Reply-To: <4A56E069.5040907@jp.fujitsu.com>
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
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>


Hi,

This patch is a new version by Seto-san's comment.


Changelog since v1:
* Remove the check code other than kexec_crash_image from kexec_should_crash()
  because a kexec cannot crash if there is no image.


This patch enables a kdump if 2nd-kernel is loaded.
(The patch is based on linux-2.6.31-rc2.)

Now, a kdump on oops is enabled if a kernel parameter "oops=panic"
is specified and 2nd-kernel is loaded. I think that a kdump should
be enabled regardless of "oops=panic" if 2nd-kernel is loaded,
because a system administrator loads 2nd-kernel for enabling a kdump.


* Reference
  The discussion about this patch
  http://lists.infradead.org/pipermail/kexec/2009-July/003417.html
  http://lists.infradead.org/pipermail/kexec/2009-July/003433.html


Thanks
Ken'ichi Ohmichi

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Acked-by: Simon Horman <horms@verge.net.au>
---
--- a/kernel/kexec.c	2009-07-08 12:30:26.000000000 +0900
+++ b/kernel/kexec.c	2009-07-13 13:49:03.000000000 +0900
@@ -57,7 +57,7 @@ struct resource crashk_res = {
 
 int kexec_should_crash(struct task_struct *p)
 {
-	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
+	if (kexec_crash_image)
 		return 1;
 	return 0;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
