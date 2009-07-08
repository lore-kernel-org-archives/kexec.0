Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MOP1P-0002Q0-Lo
	for kexec@lists.infradead.org; Wed, 08 Jul 2009 04:44:50 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n684ibIf004675
	for <kexec@lists.infradead.org>; Wed, 8 Jul 2009 13:44:37 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id n684ibr03033 for kexec@lists.infradead.org;
	Wed, 8 Jul 2009 13:44:37 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id n684haQE015716
	for <kexec@lists.infradead.org>; Wed, 8 Jul 2009 13:44:36 +0900 (JST)
Message-ID: <4A5422E3.1030600@mxs.nes.nec.co.jp>
Date: Wed, 08 Jul 2009 13:38:59 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH] Enable kdump if 2nd-kernel is loaded.
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
To: kexec-ml <kexec@lists.infradead.org>


Hi,

This patch enables a kdump if 2nd-kernel is loaded.
(The patch is based on linux-2.6.31-rc2.)

Now, a kdump is enabled if a kernel parameter "oops=panic" is specified and
2nd-kernel is loaded. I think that a kdump should be enabled regardless of
"oops=panic" if 2nd-kernel is loaded, because a system administrator loads
2nd-kernel for enabling a kdump.


Thanks
Ken'ichi Ohmichi

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
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
