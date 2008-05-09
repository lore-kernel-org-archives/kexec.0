Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JuVgj-0008Ga-8g
	for kexec@lists.infradead.org; Fri, 09 May 2008 16:43:17 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 2A6CA40AAE
	for <kexec@lists.infradead.org>; Fri,  9 May 2008 18:43:14 +0200 (CEST)
Date: Fri, 9 May 2008 18:43:55 +0200
Subject: [PATCH] Update 32 bit boot protocol
Message-ID: <20080509164355.GA16830@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
From: bwalle@suse.de (Bernhard Walle)
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This patch updates the boot protocol to match with the kernel. See
Documentation/i386/zero-page.txt in kernel.

The number of E820 map entries have been increased from 32 to 128. The update
is necessary for the next patch that implements EDD support for kexec.
when using the default 32 bit mode.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 doc/linux-i386-zero-page.txt |    3 +--
 include/x86/x86-linux.h      |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/doc/linux-i386-zero-page.txt
+++ b/doc/linux-i386-zero-page.txt
@@ -75,5 +75,4 @@ Offset	Type		Description
 0x224	unsigned short	setup.S heap end pointer
 0x290 - 0x2cf		EDD_MBR_SIG_BUFFER (edd.S)
 0x2d0 - 0x600		E820MAP
-0x600 - 0x7ff		EDDBUF (edd.S) for disk signature read sector
-0x600 - 0x7eb		EDDBUF (edd.S) for edd data
+0xd00 - 0xeec		EDDBUF (edd.S) for edd data
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -4,7 +4,7 @@
 #define TENATIVE 0 /* Code that is tenatively correct but hasn't yet been officially accepted */
 
 #define E820MAP	0x2d0		/* our map */
-#define E820MAX	32		/* number of entries in E820MAP */
+#define E820MAX	128		/* number of entries in E820MAP */
 #define E820NR	0x1e8		/* # entries in E820MAP */
 
 #ifndef ASSEMBLY

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
