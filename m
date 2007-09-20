Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYEe4-0007mU-TD
	for kexec@lists.infradead.org; Thu, 20 Sep 2007 01:32:21 -0400
Message-Id: <46F205DB.70209@mxs.nes.nec.co.jp>
Date: Thu, 20 Sep 2007 14:32:11 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 6/4] [-mm patch] use the existing offsetof().
References: <46E9F6A9.8060500@mxs.nes.nec.co.jp>	<46E9F942.5070007@mxs.nes.nec.co.jp>
	<20070914190350.011cdadb.akpm@linux-foundation.org>
	<46F204FD.6040303@mxs.nes.nec.co.jp>
In-Reply-To: <46F204FD.6040303@mxs.nes.nec.co.jp>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, Adrian Bunk <bunk@kernel.org>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, David Rientjes <rientjes@google.com>


[PATCH 6/4] [-mm patch] use the existing offsetof().
 It is better that offsetof() is used for VMCOREINFO_OFFSET().
 This idea is Joe Perches's.



Thanks
Ken'ichi Ohmichi 

---
Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/include/linux/kexec.h b/include/linux/kexec.h
--- a/include/linux/kexec.h	2007-09-18 15:23:22.000000000 +0900
+++ b/include/linux/kexec.h	2007-09-18 15:27:29.000000000 +0900
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
