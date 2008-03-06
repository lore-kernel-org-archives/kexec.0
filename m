Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JXCrA-0006sS-1M
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 09:57:44 +0000
Message-Id: <20080306094800.249412632@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
Date: Thu, 06 Mar 2008 18:46:47 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 10/12] kexec-tools: mipsel: Fit elf_mipsel_usage() into 80
	columns
Content-Disposition: inline; filename=elf_mipsel_usage-80col.patch
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

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/mipsel/kexec-elf-mipsel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-05 11:12:44.000000000 +0900
+++ kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-05 11:18:34.000000000 +0900
@@ -97,10 +97,10 @@ int elf_mipsel_probe(const char *buf, of
 
 void elf_mipsel_usage(void)
 {
-	printf
-	    (
-	     "    --command-line=STRING Set the kernel command line to STRING.  \n"
-	     "    --append=STRING       Set the kernel command line to STRING.  \n");
+	printf("    --command-line=STRING Set the kernel command line to "
+			"STRING.\n"
+	       "    --append=STRING       Set the kernel command line to "
+			"STRING.\n");
 }
 
 int elf_mipsel_load(int argc, char **argv, const char *buf, off_t len,

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
