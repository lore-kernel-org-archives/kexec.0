Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hq2a7-0006Yb-He
	for kexec@lists.infradead.org; Mon, 21 May 2007 03:45:28 -0400
Subject: Re: [PATCH] [makedumpfile] Fix missing last node
In-reply-to: <20070518105012.GF16227@suse.de>
Message-Id: <20070521164518oomichi@mail.jp.nec.com>
References: <20070518105012.GF16227@suse.de>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 21 May 2007 16:45:18 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org


Hi Bernhard,

Thank you for your patches and your cooperation.

2007/05/18 12:50:12 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>This patch fixes a typo which results in duplication of the first node (and the
>last node was missing then).

I think the cause of this problem is the other typo.
Does the attached patch fix it ?

Please apply the attached patch with the following makedumpfile:

makedumpfile-1.1.3
 + 2007/05/11 by Ken'ichi, 01-vaddr_to_offset_ia64.patch 
 + 2007/05/11 by Ken'ichi, 02-ia64-discontigmem.patch
 + 2007/05/16 by Bernhard, [Re: Implement memory regions on IA64] patch


Thanks
Ken'ichi Ohmichi

diff -puN makedumpfile.org/makedumpfile.c makedumpfile/makedumpfile.c
--- makedumpfile.org/makedumpfile.c	2007-05-21 20:54:04.000000000 +0900
+++ makedumpfile/makedumpfile.c	2007-05-21 20:54:16.000000000 +0900
@@ -2121,7 +2121,7 @@ pgdat3:
 	if (node == 0)
 		return pgdat;
 
-	for (i = 1; i < node; i++) {
+	for (i = 1; i <= node; i++) {
 		if (!readmem(info, pgdat + OFFSET(pglist_data.pgdat_next),
 		    &pgdat, sizeof pgdat))
 			goto pgdat4;
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
