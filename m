Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Isr2d-0007iW-Q2
	for kexec@lists.infradead.org; Thu, 15 Nov 2007 21:34:54 -0500
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lAG2Ykk1005604
	for <kexec@lists.infradead.org>; Fri, 16 Nov 2007 11:34:46 +0900 (JST)
Message-Id: <473D0163.5070602@mxs.nes.nec.co.jp>
Date: Fri, 16 Nov 2007 11:33:07 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 2/5] Use the existing offsetof() for VMCOREINFO_OFFSET()
References: <473CFE14.3010400@mxs.nes.nec.co.jp>
In-Reply-To: <473CFE14.3010400@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1663876181=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: lkml <linux-kernel@vger.kernel.org>, kexec-ml <kexec@lists.infradead.org>

--===============1663876181==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


It is better that the existing offsetof() is used for VMCOREINFO_OFFSET().

This discussion is the following:
http://www.ussg.iu.edu/hypermail/linux/kernel/0709.3/0584.html

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/include/linux/kexec.h b/include/linux/kexec.h
--- a/include/linux/kexec.h	2007-11-12 11:03:31.000000000 +0900
+++ b/include/linux/kexec.h	2007-11-12 11:03:43.000000000 +0900
@@ -137,7 +137,7 @@ unsigned long paddr_vmcoreinfo_note(void
 			      (unsigned long)sizeof(struct name))
 #define VMCOREINFO_OFFSET(name, field) \
 	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
-			      (unsigned long)&(((struct name *)0)->field))
+			      (unsigned long)offsetof(struct name, field))
 #define VMCOREINFO_LENGTH(name, value) \
 	vmcoreinfo_append_str("LENGTH(%s)=%lu\n", #name, (unsigned long)value)
 #define VMCOREINFO_NUMBER(name) \
_



--===============1663876181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1663876181==--
