Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Irt0l-00078G-24
	for kexec@lists.infradead.org; Tue, 13 Nov 2007 05:28:57 -0500
Received: from mailgate3.nec.co.jp (mailgate53.nec.co.jp [10.7.69.161])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lADASjfq001430
	for <kexec@lists.infradead.org>; Tue, 13 Nov 2007 19:28:45 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id lADASio19933 for kexec@lists.infradead.org;
	Tue, 13 Nov 2007 19:28:44 +0900 (JST)
Received: from saigo.jp.nec.com (saigo.jp.nec.com [10.26.220.6]) by
	mailsv3.nec.co.jp (8.11.7/3.7W-MAILSV4-NEC) with ESMTP
	id lADASiB17314 for <kexec@lists.infradead.org>;
	Tue, 13 Nov 2007 19:28:44 +0900 (JST)
Message-Id: <47397C7C.1020504@mxs.nes.nec.co.jp>
Date: Tue, 13 Nov 2007 19:29:16 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH] Fix the feature determining ELF32/ELF64 automatically
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0942873021=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: 

--===============0942873021==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

This patch fixes the problem that the kexec command cannot determine
ELF32/ELF64 automatically.

On i386 system, the kexec command always determined an ELF32 /proc/vmcore
even if the memory is 4GB or larger, because of referring the outside
of the array "range[]".


Thanks
Ken'ichi Ohmichi


Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
--- a/kexec/arch/i386/crashdump-x86.c	2007-11-13 18:06:05.000000000 +0900
+++ b/kexec/arch/i386/crashdump-x86.c	2007-11-13 18:13:09.000000000 +0900
@@ -496,7 +496,7 @@ static enum coretype get_core_type(struc
 		if (ranges == 0)
 			return CORE_TYPE_ELF64;
 
-		if (range[ranges].end > 0xFFFFFFFFUL)
+		if (range[ranges - 1].end > 0xFFFFFFFFUL)
 			return CORE_TYPE_ELF64;
 		else
 			return CORE_TYPE_ELF32;
_



--===============0942873021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0942873021==--
