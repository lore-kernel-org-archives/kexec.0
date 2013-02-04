Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U2S73-0001l8-0o
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 19:53:57 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
 by relay2.corp.sgi.com (Postfix) with ESMTP id B6337304043
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 11:53:55 -0800 (PST)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
 by estes.americas.sgi.com (Postfix) with ESMTP id 9A88A700179D
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 13:53:55 -0600 (CST)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
 (envelope-from <cpw@sgi.com>) id 1U2S71-00057C-Hj
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 13:53:55 -0600
Subject: [PATCH] kexec: lengthen the kernel command line image
Message-Id: <E1U2S71-00057C-Hj@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Mon, 04 Feb 2013 13:53:55 -0600
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>

The crash kernel's boot command line is not long enough to contain the
necessary memmap= options for a large memory.

The fix is simple, as long as the boot loader's command line is also long enough.
I'm not sure about boot loader or kernel restrictions to this length.

Signed-off-by: Cliff Wickman <cpw@sgi.com>

---
 include/x86/x86-linux.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: kexec-tools-2.0.2/include/x86/x86-linux.h
===================================================================
--- kexec-tools-2.0.2.orig/include/x86/x86-linux.h
+++ kexec-tools-2.0.2/include/x86/x86-linux.h
@@ -180,7 +180,7 @@ struct x86_linux_param_header {
 	uint8_t _pad8[48];			/* 0xcd0 */
 	struct 	edd_info eddbuf[EDDMAXNR];	/* 0xd00 */
 						/* 0xeec */
-#define COMMAND_LINE_SIZE 2048
+#define COMMAND_LINE_SIZE (64*1024)
 };
 
 struct x86_linux_faked_param_header {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
