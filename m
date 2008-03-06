Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JXCr5-0006N1-J5
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 09:57:40 +0000
Message-Id: <20080306094758.980350354@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
Date: Thu, 06 Mar 2008 18:46:41 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 04/12] kexec-tools: mipsel: Remove duplication declaration of
	BOOTLOADER_VERSION
Content-Disposition: inline; filename=mips-duplicate-BOOTLOADER_VERSION.patch
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Francesco Chiechi <francesco.chiechi@colibre.it>

BOOTLOADER_VERSION is defined in kexec.h

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/mipsel/kexec-elf-mipsel.c |    1 -
 1 file changed, 1 deletion(-)

Index: kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- kexec-tools-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-02-27 19:15:41.000000000 +0900
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-02-27 19:18:10.000000000 +0900
@@ -32,7 +32,6 @@
 static const int probe_debug = 0;
 
 #define BOOTLOADER         "kexec"
-#define BOOTLOADER_VERSION VERSION
 #define MAX_COMMAND_LINE   256
 
 #define UPSZ(X) ((sizeof(X) + 3) & ~3)

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
